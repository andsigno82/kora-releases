#!/bin/zsh
set -euo pipefail

APP_NAME="Kora"
APP_BUNDLE="Kora.app"
TARGET_APP="/Applications/${APP_BUNDLE}"
LOCK_DIR="/tmp/Kora.app.install.lock"
LOCK_PID="${LOCK_DIR}/pid"
LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

SCRIPT_PATH="${0:A}"
SCRIPT_DIR="${SCRIPT_PATH:h}"
SOURCE_APP="${SCRIPT_DIR}/${APP_BUNDLE}"
ELEVATED="${1:-}"

log() { print -r -- "[Kora Installer] $*"; }
fail() { print -r -- "[Kora Installer] ERROR: $*" >&2; exit 1; }

elevate_if_needed() {
  if [[ "${ELEVATED}" == "--elevated" || "${EUID}" -eq 0 ]]; then
    return
  fi
  [[ -d "${SOURCE_APP}" ]] || fail "${APP_BUNDLE} not found next to Install.command."
  log "Administrator permission is required to install ${APP_NAME} in /Applications."
  local elevated_dir elevated_script osa_status
  elevated_dir="$(/usr/bin/mktemp -d /tmp/kora-installer.XXXXXX)"
  elevated_script="${elevated_dir}/Install.command"
  /usr/bin/ditto --norsrc --noextattr "${SOURCE_APP}" "${elevated_dir}/${APP_BUNDLE}"
  /bin/cp "${SCRIPT_PATH}" "${elevated_script}"
  /bin/chmod +x "${elevated_script}"
  # `.elevated-started` is touched by the privileged shell ONLY after the admin
  # dialog succeeds. It separates "auth cancelled" (marker absent → sudo fallback
  # is appropriate) from "auth ok but install failed" (marker present → do NOT
  # sudo-retry, which would re-run a failed install and log a misleading message).
  osa_status=0
  /usr/bin/osascript - "${elevated_dir}" "${elevated_script}" <<'OSA' || osa_status=$?
on run argv
  set scriptDir to item 1 of argv
  set scriptPath to item 2 of argv
  do shell script "touch " & quoted form of (scriptDir & "/.elevated-started") & " && cd " & quoted form of scriptDir & " && /bin/zsh " & quoted form of scriptPath & " --elevated" with administrator privileges
end run
OSA
  if (( osa_status != 0 )) && [[ ! -e "${elevated_dir}/.elevated-started" ]]; then
    log "AppleScript elevation failed; falling back to sudo."
    /usr/bin/sudo /bin/zsh "${elevated_script}" --elevated
    osa_status=$?
  fi
  /bin/rm -rf "${elevated_dir}" 2>/dev/null || true
  exit "${osa_status}"
}

acquire_lock() {
  if /bin/mkdir "${LOCK_DIR}" 2>/dev/null; then
    print -r -- "$$" > "${LOCK_PID}"
    trap 'rm -rf "${LOCK_DIR}"' EXIT
    return
  fi

  if ! installer_lock_is_active; then
    /bin/rm -rf "${LOCK_DIR}" 2>/dev/null || true
    if /bin/mkdir "${LOCK_DIR}" 2>/dev/null; then
      print -r -- "$$" > "${LOCK_PID}"
      trap 'rm -rf "${LOCK_DIR}"' EXIT
      return
    fi
  fi
  fail "Another Kora installation is already running. If no install is in progress, remove ${LOCK_DIR} manually."
}

installer_lock_is_active() {
  local pid command
  [[ -f "${LOCK_PID}" ]] || return 1
  pid="$(<"${LOCK_PID}")"
  [[ "${pid}" == <-> ]] || return 1
  command="$(/bin/ps -p "${pid}" -o command= 2>/dev/null || print -r -- '')"
  [[ "${command}" == *"Install.command"* ]]
}

strip_xattrs() {
  local path="$1"
  /usr/bin/xattr -cr "${path}" 2>/dev/null || true
}

bundle_executable() {
  /usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "${SOURCE_APP}/Contents/Info.plist" 2>/dev/null
}

quit_running_app() {
  local executable="$1"
  if ! /usr/bin/pgrep -x "${executable}" >/dev/null 2>&1 && ! /usr/bin/pgrep -x "${APP_NAME}" >/dev/null 2>&1; then
    return
  fi
  log "${APP_NAME} is running; asking it to quit."
  /usr/bin/osascript -e "tell application \"${APP_NAME}\" to quit" 2>/dev/null || true
  for _ in {1..10}; do
    if ! /usr/bin/pgrep -x "${executable}" >/dev/null 2>&1 && ! /usr/bin/pgrep -x "${APP_NAME}" >/dev/null 2>&1; then
      return
    fi
    /bin/sleep 1
  done
  log "${APP_NAME} did not quit in time; force-killing the running process."
  /usr/bin/pkill -9 -x "${executable}" 2>/dev/null || /usr/bin/pkill -9 -x "${APP_NAME}" 2>/dev/null || true
}

verify_host_architecture() {
  local host_arch
  host_arch="$(/usr/bin/uname -m)"
  [[ "${host_arch}" == "arm64" ]] || fail "This build requires macOS arm64 (Apple Silicon). Host arch: ${host_arch}"
}

verify_architecture() {
  local executable="$1"
  /usr/bin/file "${executable}"
  /usr/bin/lipo "${executable}" -verify_arch arm64
}

source_has_developer_id() {
  /usr/bin/codesign -dv "${SOURCE_APP}" 2>&1 | /usr/bin/grep -q 'Authority=Developer ID Application'
}

verify_or_resign() {
  local app="$1"
  if /usr/bin/codesign --verify --deep --strict --verbose=2 "${app}"; then
    return
  fi
  if source_has_developer_id; then
    fail "Developer ID signature verification failed; refusing to downgrade to ad-hoc."
  fi
  log "Ad-hoc signature verification failed; re-signing this beta build ad-hoc."
  /usr/bin/codesign --force --deep --sign - "${app}"
  /usr/bin/codesign --verify --deep --strict --verbose=2 "${app}"
}

open_installed_app() {
  local console_user uid
  console_user="$(/usr/bin/stat -f %Su /dev/console 2>/dev/null || print -r -- '')"
  if [[ -n "${console_user}" && "${console_user}" != "root" ]]; then
    uid="$(/usr/bin/id -u "${console_user}" 2>/dev/null || print -r -- '')"
    if [[ -n "${uid}" ]]; then
      /bin/launchctl asuser "${uid}" /usr/bin/open "${TARGET_APP}" 2>/dev/null && return
    fi
  fi
  /usr/bin/open "${TARGET_APP}" 2>/dev/null || true
}

install_app() {
  [[ -d "${SOURCE_APP}" ]] || fail "${APP_BUNDLE} not found next to Install.command."
  local executable_name executable_path tmp_app backup_app
  executable_name="$(bundle_executable)"
  [[ -n "${executable_name}" ]] || fail "Cannot read CFBundleExecutable from ${APP_BUNDLE}."
  executable_path="${SOURCE_APP}/Contents/MacOS/${executable_name}"
  [[ -x "${executable_path}" ]] || fail "Main executable is missing or not executable: ${executable_path}"

  verify_architecture "${executable_path}"
  strip_xattrs "${SOURCE_APP}"
  verify_or_resign "${SOURCE_APP}"
  quit_running_app "${executable_name}"

  tmp_app="/Applications/.${APP_BUNDLE}.installing.$$"
  backup_app="/Applications/.${APP_BUNDLE}.backup.$$"
  /bin/rm -rf "${tmp_app}" "${backup_app}"
  log "Copying ${APP_BUNDLE} to staging."
  /usr/bin/ditto --norsrc --noextattr "${SOURCE_APP}" "${tmp_app}"
  strip_xattrs "${tmp_app}"
  /bin/chmod -R u+rwX,go+rX "${tmp_app}"
  /bin/chmod +x "${tmp_app}/Contents/MacOS/${executable_name}"
  verify_architecture "${tmp_app}/Contents/MacOS/${executable_name}"
  verify_or_resign "${tmp_app}"

  if [[ -d "${TARGET_APP}" ]]; then
    /bin/mv "${TARGET_APP}" "${backup_app}"
  fi
  if ! /bin/mv "${tmp_app}" "${TARGET_APP}"; then
    [[ ! -d "${backup_app}" ]] || /bin/mv "${backup_app}" "${TARGET_APP}"
    fail "Could not replace ${TARGET_APP}; previous installation restored."
  fi
  /bin/rm -rf "${backup_app}"
  strip_xattrs "${TARGET_APP}"
  "${LSREGISTER}" -f "${TARGET_APP}" 2>/dev/null || true
  log "Opening ${APP_NAME}."
  open_installed_app
}

verify_host_architecture
elevate_if_needed
acquire_lock
install_app
log "Installation completed."
