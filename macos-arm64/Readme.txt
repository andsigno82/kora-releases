Kora manual ZIP beta installer
================================

This ZIP is for macOS Apple Silicon (arm64) only.

Contents:
- Kora.app
- Install.command
- Readme.txt

How to install:
1. Unzip the downloaded file.
2. Open Terminal in the extracted folder.
3. If macOS blocks the script because it was downloaded from the internet, run:

   xattr -dr com.apple.quarantine .

4. Run:

   ./Install.command

5. Approve the administrator prompt. Kora will be copied to /Applications and opened.

Important:
- This MVP channel is not notarized.
- If a Developer ID certificate was available during packaging, the app was signed with it.
- Otherwise this beta build is ad-hoc signed for internal/manual distribution.
- Do not treat ad-hoc signing as equivalent to Apple Developer ID notarization.

Troubleshooting:
- If Terminal says the script is not executable, run: chmod +x Install.command
- If Kora is already open, the installer will ask it to quit before replacing the app.
- This package is valid only when downloaded from the release manifest URL published by Kora.
