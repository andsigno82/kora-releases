# Changelog

---

## [1.5.2] - 2026-08-06

### Fixed
- Use provider-reported final-step usage as the only persisted context measurement, fencing stale turns across session, payload, and telemetry stores
- Preserve open todos when steering queued messages so the replacement turn reconciles work instead of marking it failed
- Stop repeated todo continuation summaries by continuing the original task without interim recaps and halting on no-progress iterations
- Route manual compaction through the canonical generation-parameter builder, preserving temperature precedence and stripping unsupported empty values

---

## [1.5.0] - 2026-08-05

### Added
- Add persistent autonomous Goal Mode with bounded post-turn evaluation and safe continuation
- Add the master toolbar to the native title bar
- Record per-request context composition across messages, prompts, tools, skills, and metadata

### Changed
- Add inline /ask, /plan, /debug, and /build commands with immediate mode switching
- Represent /goal as a removable composer chip while preserving its condition text
- Show context composition and weighted cache hit rates in the context indicator at every viewport width

### Fixed
- Keep shell, scripts, Git, system tools, and relative paths local by default unless a remote project directory is explicit

---

## [1.4.13] - 2026-08-03

### Added
- Add working-tree diffs to the editor file toggle and GitPanel compact view with a virtual uncommitted node
- Cache provider capability metadata with TTL and stateless resolver fallback

### Changed
- Isolate editor file identity per session so paths, diffs, and pending edits never collide across sessions
- Store queued turns as versioned skill references and invalidate session skills on clear or removal

### Fixed
- Pair tool-call and tool-result chronologically to prevent provider 400s from orphaned persisted results

---

## [1.4.12] - 2026-07-31

### Changed
- Remove redundant status badges from todo rows — icons and styling keep task state clear

### Fixed
- Publish GitHub releases even when version-specific public notes are missing — safe English fallback, non-blocking

---

## [1.4.11] - 2026-07-31

### Added
- Controlli operativi per agente e per todo nell'addendum: stop del singolo agente, stop all, clear completati/falliti e clear all, con icone e tooltip dedicati

### Changed
- Send-now della coda reso atomico e session-safe — il messaggio viene rimosso dallo store autorevole prima dell'interruzione del turno e il dispatch resta sincrono per evitare consegne cross-session
- Cleanup del turno precedente (todo completati e flag auto-spawn) spostato all'avvio effettivo del provider — messaggi solo accodati o rifiutati non alterano più lo stato del turno in corso

---

## [1.4.9] - 2026-07-30

### Added
- Addendum operativo come overlay sopra la chat con padding dinamico misurato tramite ResizeObserver; MessageScrollerButton spostato sopra l'overlay
- Riepilogo verde con check "N/N completed" nell'header dell'addendum quando tutti i Todo sono completati

### Changed
- Badge "Completed" rimossi dalle singole righe Todo completate — il check e il testo barrato sono sufficienti come indicazione visiva
- Rimossa la riga Close con divider e padding dall'addendum — il riepilogo "N/N completed" funge da controllo di collapse

---

## [1.4.8] - 2026-07-30

### Added
- Ridisegnate le righe sessione strette con azioni su riga separata sotto 320px — lo stato compatto del ResizeObserver preserva titolo e metadati non compressi

### Changed
- Timestamp dei messaggi utente formattati in dd/MM/yyyy HH:mm con locale italiana — timestamp dei messaggi di sistema rimasti invariati

---

## [1.4.6] - 2026-07-29

### Added
- Riconoscimento e normalizzazione automatica della temperatura minima a 1.0 per tutti i modelli della famiglia Kimi, indipendentemente dal provider

---

## [1.4.3] - 2026-07-29

### Added
- Discovery dinamico dei modelli ByteDance ModelArk con persistenza catalogo, toggle per-modello e Test Connection live nelle impostazioni provider

### Fixed
- Skill attive di sessione ora visibili nel composer dopo l'invio e dopo remount del pannello, con possibilità di rimozione singola (X) o massiva (Clear all) per i turni successivi
- Aggiunta di una nuova skill non esclude più quelle già attive dal sistema prompt del turno corrente
- Contatore turni ripristinato dal valore persisted al remount, evitando degradazione STE in eco/balanced su riapertura sessione
- Lettura metadata modelli custom dai provider built-in

---

## [1.4.2] - 2026-07-28

### Added
- Inline fuzzy @ mentions: Tab sfoglia le directory, Enter conferma, il path raw resta nel testo del messaggio mentre la bolla utente mostra un chip compatto richiudibile
- Guida fissa Tab to browse · Enter to confirm sopra i risultati del menù a tendina
- Hover sul chip mention mostra il path completo in un tooltip; click ripristina la mention nel composer e riapre la ricerca fuzzy

### Fixed
- Percorsi con spazi ora quotati con doppi apici nel composer per evitare tokenizzazione errata
- Contesto di browsing stale cancellato alla pressione di Escape o cambio manuale della mention
- Percorsi remoti ripristinati al corretto root remoto invece del path assoluto locale

---

## [1.4.1] - 2026-07-28

### Fixed
- Estesa la ricerca fuzzy delle mention a tutte le folder locali con fan-out parallelo e guardia contro risultati obsoleti, preservato il fallback legacy su singola cartella

---

## [1.4.0] - 2026-07-27

### Added
- **Queue automation** — advance queued messages automatically after each completed turn

### Changed
- **Cleaner user prompts** — redesign the prompt with a clearer full-width layout and a single timestamp in the footer
- **Open response canvas** — show model answers on an open canvas for a cleaner reading experience
- **Accessible long paste** — make long pasted messages easier to expand with the keyboard
- **Theme-aware message links** — use theme-aware colors for links in user messages
- **Turn navigation controls** — refresh turn navigation controls for a clearer visual hierarchy
- **Compact queued message row layout** — tighten queue row spacing and align drag preview with message bounds

---

## [1.3.5] - 2026-07-27

### Added
- **Provider catalog reliability** — improve provider catalog reliability
- **Compact inline file references** — render file paths as compact chips inside chat messages
- **Unified context references and navigation** — single consistent pattern for file/line references across chat and editor
- **Deferred restart update flow** — 3-choice update modal with dismiss checkbox, progress, and phased install
- **First-response timeout UX** — non-blocking 6s toast warning at 3min (remote) / 5min (localhost) instead of abort; safety 10min hard cutoff preserved
- **Composer constrained layouts** — adapt composer UI to constrained layout contexts for better responsiveness
- **Opt-in anonymous desktop activation metrics** — lightweight usage telemetry for product decisions
- **Automatic context optimization** — adapt optimization to the active model and conversation size
- **Public release channel** — make application downloads and update manifests available from the public release channel
- **Apple credential settings** — configure Apple credentials from the app settings

### Fixed
- **Update modal action leak** — keep update actions inside modal, prevent click-through to underlying UI
- **Streaming and session handling hardening** — guard against race conditions in stream lifecycle and session state transitions
- **Todo state isolation** — isolate task state and execution by session, preventing cross-session todo contamination
- **OTA verification smoke gate** — mark latest verification as deploy smoke to catch broken releases
- **Token engine auto mode alignment** — context-aware auto mode correctly falls back when context window is insufficient
- **GitHub auth check** — use gh repo view instead of gh auth status --repo for reliable auth verification

### Performance
- **Defer markdown rendering until stream completion** — avoid per-token re-render during active streaming; reduces jank in long responses
- **Stream markdown in frame-aligned blocks** — batch markdown updates to animation frames for smoother rendering

---

## [1.1.7] - 2026-07-17

### Added
- Normalize attachment chips and add collapsible file activity summary
- Selective clear of completed or failed todo items with human-readable labels

### Performance
- Lazy-load heavy component chunks

---

## [1.1.6] - 2026-07-17

### Fixed
- Remove misleading "local" label from AI diagnostics (applies to every provider, not just local)

### Performance
- Replace scroll-intent state with ref callback to avoid re-render on wheel
- Early return for inactive sessions to avoid hidden tree reconciliation

---

## [1.1.5] - 2026-07-16

### Fixed
- Remove misleading "local" label from AI diagnostics (applies to every provider, not just local)

### Performance
- Replace scroll-intent state with ref callback to avoid re-render on wheel
- Early return for inactive sessions to avoid hidden tree reconciliation

---

## [1.1.4] - 2026-07-16

### Added
- Tier-aware image quality and resize logging
- Thread image resize options through file picker and drag-drop paths

### Fixed
- Prevent turn counter flicker during fast scroll
- Tool group disclosure respects always-closed during streaming
- Missing privacy tab branch with exhaustive switch

---

## [1.1.3] - 2026-07-16

### Added
- Persist account catalog, fix vision capability and reasoning effort parser
- Preserve images and file attachments through the session queue

### Fixed
- Isolate turn Stop/abort via monotonic epoch
- Turn-abort support types and store methods
- Integrate turn-abort support in stream lifecycle
- Reset stall counter on stream state clear
- Retry queue dispatch on ready with bounded wait and Stop guard

---

## [1.1.1] - 2026-07-15

### Added
- Recover orphaned session provider/model from project defaults

---

## [1.0.11] - 2026-07-14

### Added
- File context marker parsing and UI chip rendering

### Fixed
- Prevent dropdown menu close from reopening session row

---

## [1.0.10] - 2026-07-13

### Fixed
- Correct lipo verify_arch argument order in release workflow

---

## [1.0.9] - 2026-07-13

### Fixed
- Single-base64 pubkey and add preflight validation

---

## [1.0.8] - 2026-07-13

### Fixed
- Bash 3.2 compatible empty array expansion

---

## [1.0.7] - 2026-07-13

### Added
- 3-choice update modal with dismiss checkbox and progress
- Forward phase, progress, error and 3-choice actions
- Gate full-auto updater on signed GitHub release

---

## [1.0.6] - 2026-07-13

### Added
- --skip-build and --skip-local-install flags with local install support
- Context pressure forecast policy
- Local hard block with typed error classification
- Pre-stream and per-step hard guards
- Exclude local hard block from circuit breaker

---

## [1.0.5] - 2026-07-12

### Added
- Inline Kora key validation and pass provider/model to project

---

## [1.0.0] - 2026-07-06

### Added
- **Agentless Sessions** — complete sidebar UX overhaul and abort hardening
- First-run wizard + guided product tour with full app walkthrough
- Redesign operational extension with pointer-based drag-and-drop
- Turn predictor with improved prediction logic
- Todo step steering, tool approval policy, lifecycle hardening

### Fixed
- Separate release/dev icons and polish context mini-ring UX
- Stable turn-counter + scroll-to-end on session change
- Stabilize transcript jump-scroller with anchor offset, neighbor prefetch, and scroll guard
- Release jump-scroller anchor lock on manual wheel scroll
- Jump-scroll blank viewport after lazy layout settle
- Singleton tool calls collapsed by default
- Narrow TerminalPanel store subscription
- Allow spaces while renaming items
- Prevent markdown table columns collapsing
- Remove live projection gate wiring to restore chat rendering
- Settings migration panic on dev build startup
- Preserve release migration and v7 text deltas

---

## [0.21.2] - 2026-07-03

### Added
- Detached panel strip refactor, session title metadata, keyboard shortcuts tab
- Agentless Sessions with sidebar UX overhaul and abort hardening

### Fixed
- Criticalthinker findings: dedup session title, scoped subscription, real-offset clamp
- Track previously untracked required source files
- Restore session drag-and-drop and harden sidebar DnD UX
- Reposition sidebar tooltips to 'right' and theme-tint agent avatar in dark mode

---

## [0.21.1] - 2026-07-01

### Added
- Semantic group-header icons and command shimmer lifecycle
- Pin selected model at top of dropdown, show model first in trigger

### Fixed
- Flush tool groups only after text is sanitized
- Deferred PTY creation for terminal tabs to prevent duplicate zsh prompt
- Bottom padding to search input in dropdown
- Scroll to bottom on submit, simplify scroll architecture
- Preserve model metadata in reasoning-first assistant messages

---

## [0.19.1] - 2026-06-26

### Added
- Auto-refresh skills when active folder changes + marketplace fixes
- Isolate dev and release builds
- Borderless code blocks, responsive grid, exec error detection

### Fixed
- Catch-all filter for non-text parts

---

## [0.16.2] - 2026-06-19

### Added
- Malformed tool-call args normalization framework
- Model capability badges editable with clickable toggles
- Rename Kora themes with display names (City, Slate, Anne, Morning)
- Alpine (Green) dark theme variant
- "Set current folder as root" button in file explorer
- Thinking Effort Selector + Provider Logos
- Telegram session sync with expand callback and workspace tools

### Fixed
- Replace Radix Select with CustomSelect to fix ~1800ms dropdown delay in release build
- Sync session lifecycle/visibility to bot, 6 bug fixes

---

## [0.16.1] - 2026-06-19

### Added
- "!" shell command prefix for direct command execution
- Refactor "!" to toggle-based shell mode with live visual feedback

---

## [0.15.0] - 2026-06-16

### Added
- Icon generation workflow + color logo in dashboard
- Native OS menu + event-bus bridge (073, waves 1–5)
- Cycle-mode + copy-session + external URLs (073, known-limitations)
- Todo-driven iteration (Cursor/Claude Code parity)
- Kora Purple theme and dropdown/select UI uniformation
- Progressive soft gate for command fan-out + misc fixes

### Fixed
- Reactive zoom live + theme radio sync + fullscreen xplat
- Theme radio — all 3 lit (default checked + menu.get non-recursive)
- Fix skills marketplace command + block command injection P1
- Resolve send-now race + interrupted tool render
- OOB compaction continuation prompt (soft variant)
- Symmetric global orphan filter for cross-message patterns
- Image token counting and bubble thumbnails
- Cross-session dispatch race, streaming guard UI, todo-continuation contract
- Unbalanced markdown table layouts + terminal always in selected folder
- Top-bar selector regressions
- Suppress false-positive integrity warning in plan mode
- Theme radio generic — supports kora-purple (and future themes)

---

## [0.14.4] - 2026-06-15

### Added
- Shimmer + auto-scroll for thinking block
- Model refresh from models.dev for connected providers

### Fixed
- Resolve queue race condition, double cursor, and compaction UX
- Queue/todo/turn integration — dead code, memory leak, UX polish

---

## [0.12.2] - 2026-06-02

### Added
- Accurate BPE token estimate via gpt-tokenizer (was byte heuristic)
- Remove virtualization, implement lazy message loading
- Detect consecutive same-role violations in quality checker

### Fixed
- Repair pre-existing test failures
- SessionList.test no longer hangs (lucide mock thenable trap)
- Align 5 pre-existing stale logic-test assertions with actual behavior
- Never show 'context pending' when a turn has run
- Conservative byte estimate (round up) + adversarial verification
- Proactive occupancy on reload + cleaner label
- Multiple bug fixes and session rename feature

---

## [0.11.5] - 2026-05-30

### Added
- Inline diffs in build mode + plan-to-build autoswitch fix
- Platform context usage tracking with session-level accounting
- Bulk-select rows in app log to copy just 1..N (not all)
- Session attention store with unit tests
- OS turn-completion notification helper
- Wire sidebar attention border, dashboard handlers, and chat completion trigger

### Fixed
- Atomic finalize of streaming messages on workflow-completed
- Token-window survival guard in payload preflight
- Honest+actionable context-overflow message (UC4)
- Absolute oversized-tool-result cap — survival beats recency
- Never strip compaction markers as synthetic — fixes irrecoverable session after Compact
- Show exact provider-reported tokens, drop the misleading ~
- Report 'before' as the REAL context, not the post-compression estimate
- Use the authoritative recorded input limit, not a registry default
- Don't overwrite provider usage with a pre-stream estimate
- Preserve partial text across a stall + log provider usage
- TokenUsage + Stall logs are info, not error
- Raise unknown-model output fallback 8192 → 32768
- Token meter denominator = full context window; output is the model's concern
- Meter fills with turn TOTAL (input+output); reclassify workflow log levels
- Distrust bogus provider total; derive it from input+output
- Skip reasoning-only assistant messages (was destroying sessions)
- Flag+repair reasoning-only messages; add converter payload guardrail
- Close reasoning on so the answer text is never lost (ROOT)
- Forced autocompaction actually reduces (no more no-op) + honest feedback
- Token-bound the forced-compaction recent window (proportional gain)
- Don't force compaction when usage is fixed system+tools overhead
- Universal content-based mitigation of reasoning leaked into the answer
- Contiguous-word mirror detection (no char threshold) — catches short leaks
- LIVE mirror suppression — leaked reasoning never appears on screen
- Re-arm live mirror guard per reasoning segment (multi-step leak)
- Normalize tool-call args so arguments serialize to valid JSON object (MiniMax 2013)
- Rules of Hooks violation + a11y label associations
- Reset watchdog on every raw stream event (swallowed deltas included)
- Measure container width via ResizeObserver for diff view switching
- Prevent UI collapse at 50-message threshold in virtualized view
- Scope proactive auto-compact by session id and add failure cooldown

### Performance
- Inject full project rules only on the first turn (compact outline after)

---

## [0.11.1] - 2026-05-27

### Added
- Turn-start todo reconciliation, stream continuation, context-overflow diagnostics
- Empirical payload meter with pre-provider survival guard
- Session scanner & auto-repair for corrupted sessions
- Reasoning block quarantine in post-stream reconciliation

### Fixed
- Filter phantom turn-chain messages from exports
- Scope remote explorer to file browser project
- Session panel toolbar layout and repair cache invalidation
- Abort sync on 507, fix telegram config persistence and polling disable
- Persist attachment dismiss across auto-context repopulation

---

## [0.10.2] - 2026-05-22

### Added
- Bulk actions (export/archive/close/delete) to session list
- Extend emoji replacement to all LLM-produced emoji with fallback stripping
- Align skill activation with Agent Skills standard, real-time chips + forced eval
- Color swatch preview for hex codes in LLM responses
- Markdown preview toggle with code/preview modes inside editor panel
- Premium gating per settings section + cascade disable
- 3-layer compaction architecture with predictive + emergency layers
- 3-layer compaction with context overflow death spiral fix
- Sanitize invisible chars in reasoning + auto-continue banner + edit badge

### Fixed
- Harden mode-switch tools with mode guards, fix session leak, DRY factory
- Prevent turn-chain re-creation loop that destroys sessions
- Prevent unwanted chain creation when model only adds pending todos
- Add third-layer defense-in-depth against turn-chain re-creation
- Remove reasoning breakthrough detection and never promote reasoning to text

---

## [0.9.6] - 2026-05-17

### Added
- Smooth FAB transition with cubic-bezier easing
- Auto-scroll to active step on step change
- Show up-one-level button in local mode too
- Unattended mode core (store, service, tool, hook)
- Unattended mode UI components
- Harden system prompt and add turn boundary summaries
- Todo integrity validation and auto-deactivation
- Enable reasoning/thinking on all providers, fix build mode streaming
- Suggest Prompt button to agent create/edit modal
- Reasoning Guard (CoT Meter) + accumulated fixes

### Fixed
- Stall watchdog abort stream, integrity validation, retry logic + PTC security
- Post-critical-review bug fixes (6 bugs + test suite)
- Support multiple execution-mode listeners for Dockview multi-session
- Anchor chat panels to empty-state to preserve left-column position
- Move processing-indicator above avatar and ensure cleanup on stream end
- Smooth scroll on FAB click
- Eliminate FAB flash during smooth scroll + add fade toggle
- Post-processing automatico per spacing su thinking chunks
- Timeout 5min, step limit rimosso, prompt summary, fallback summary
- Robustness mitigations for model heterogeneity + default build mode
- Recovery hint no-op + test alignment
- Fallback summary when model executes tools but generates no text
- Resolve 4 low-severity findings from critical review
- Left-align edit-decision pills to match tool chips
- Switch skill injection to plural form for multi-skill awareness
- @ autocomplete follows the current root of DirectoryTree
- Remove broken orchestration tool and fix regression cascade
- Align EditDecisionBadge with tool card content via
- Resolve vision capability for custom providers and CLI providers

---

## [0.9.3] - 2026-05-09

### Added
- Auto-configure and immediate sync trigger
- Keychain passphrase persistence and Kora key binding
- Verify extension, fix MiniMax reasoning-only response
- Z.AI dual-mode (standard + coding plan), generalize mode selector UI
- Full-panel file drag-and-drop + PR review hardening
- Custom provider system with models.dev catalog integration
- Refine custom provider flow — model toggles in form, CORS bypass, null-safe access
- Project lifecycle management and improve quick chat, sync, and stall watchdog
- Migliora sync cloud con debug logging e purge sessioni orfane
- Aggiunge OTA auto-updater silenzioso
- Comprime testo incollato con badge + migliora rendering compaction
- "Set as root" context menu + preserve expanded state on refresh

### Fixed
- Prevent right-click from opening files in editor
- S03 embeddings — remove X-Kora-System, accept any Kora key
- Increase timeout to 120s and reduce batch to 8
- Resolve 0KB cloud sync — add first-sync bulk upload and align server protocol
- Use default_headers for Authorization and add debug logging
- Trigger debounced sync_now after marking session dirty
- Use eprintln! instead of log::info! for diagnostic output
- Add required k parameter to vec0 KNN queries, suppress dead_code warning
- Bring thinking block chevron closer to text
- Reload passphrase from keychain if not in memory
- Improve UI consistency and fix stall watchdog false positive
- Migliora gestione provider custom e error handling workflow
- Wire RemoteFileExplorerPanel into FileExplorerContainer sections
- Support ~ paths and global project scan in remote file explorer
- Auto-refresh file explorer after AI operations + fix end-of-turn summary

---

## [0.1.0] - 2026-04-18

### Added
- **Execution modes**: Ask, Plan, Debug, Build with permission gates
- **Git Flow Panel** — Phases 1–6
- Token engine UI, session improvements, editor enhancements
- **Telegram bot integration** with polling, commands, and notifications
- TL;DR generator for long responses
- On/off toggle and simplified notification format
- Session resume, disk persistence v2, and session management improvements
- **Dual theme system** and light mode for 40+ components
- Cloud sync UI and crypto tests
- Search, @mention fix, AI refresh wiring
- Todo-driven turn-by-turn workflow
- Quick Chat from Folder — handler, sidebar UI, wiring
- Cancel download for model download
- Phase 1 — install 17 primitives + playground
- Phase 2 — Suggestion pills + Shimmer (additive)
- Fuzzy/abbreviation matching for @ file search
- Enhanced system prompt with few-shot tool calling and component updates
- Exclude extensions from indexing
- Exclude patterns support folders and file suffixes
- Comprehensive syntax highlighting for all development languages in tool results
- Hybrid FTS5 + vector search with Reciprocal Rank Fusion
- Multi-source progress bar system to sidebar footer
- Hybrid search auto-load and sqlite-vec fixes
- Migrate ONNX inference from ort 2.0-rc.12 to tract-onnx
- Send button outline style + double-Esc to interrupt
- Render attached images as AI Elements inline chips
- Chips side-by-side + in-app lightbox for image expand
- Smooth expand/collapse for agent session list
- Emit OpenCode-style compaction report inline in chat
- Real per-layer savings + reactive analytics
- Manual /compact now mimics Claude Code / OpenCode handoff
- Opt-in checkbox to wipe session files on project/agent delete
- LLM-driven manual /compact with persistent message-log state
- ByteDance ModelArk provider with dual-mode support

### Fixed
- Strip thinking tags from TL;DR, resolve agent name from hierarchy
- Toggle stops all comms, TL;DR shows only summary, fix agent name regression
- Exclude test files from tsc compilation
- Remove NodeJS type dependencies from production code
- Suppress platform-conditional warnings on Windows
- Remove matrix reference from job-level if condition
- Restore dropdown UX in ModelSelector
- Fix stuck-open toggle, layout block, and invisible Shimmer text
- Auto-close ephemeral sessions + track message count
- ConfirmationView handoff + turn-chain resume/retry/skip dispatch
- Resolve scroll layout and stick-to-bottom flickering
- Improve scroll behavior and thinking indicator during AI streaming
- Smooth thinking indicator fade-out and end-of-turn scroll
- Add aria-label to icon-only buttons across 8 components
- Stop button fully finalizes turn + tool chips use AI Elements
- Tool chip width based on title, not content
- ToolOutput container gets p-2 padding, remove duplicate from renderers
- Processing indicator only shows during pre-processing (submitted)
- Processing indicator fades out smoothly, scrolls with content
- Bubble tail stays top-right, pointing at avatar
- Resizable sidebar with min-width from settings, X close works
- Check model status at cold start, not on-demand
- Auto-load model at cold start when assets are ready
- Critical review fixes — missing defaults, DRY consolidation
- Improve auto-scroll behavior during agent turn
- Improve auto-scroll behavior during streaming
- Sidebar coherence, git branch, destructive guards, layout enforce
- Align send button + token bar to AI Elements SDK
- Tree connector anchors to agent card on first session
- Inactive agent avatar — match contrast to active
- File explorer width clamp is bidirectional
- Close-explorer button fights stale-closure clamp
- Remove bidirectional width clamp from layout-change callback
- Align button heights to 32px textarea baseline
- No vertical-line stub past the L-bend on last session
- Clear "Loading model..." once backend reports loaded
- Log OnnxEmbedding::new errors before propagating
- Use fixed MAX_SEQ_LEN=512 — tract can't type Unsqueeze13 with symbols
- Subtitle slot — git branch shrinks to fit, ellipsis on overflow
- Drop "Warning:" prefix from double-Esc toast
- Drop notify macos_kqueue feature — backend panics
- Right edge of session rings was clipped against project card
- Align session right edges with agent card via border
- Clamp context-menu Y to viewport, add scroll fallback
- Right-click no longer opens the file
- Restore explorer width after the last editor panel closes
- Relax click guard — only block button 1/2, allow 0/undefined
- Always-visible X + solid-red Clear all, revert click guard
- Force-override the bundled theme variables with !important
- Also restore explorer width when the last terminal closes
- Also clamp explorer width when an editor panel is added
- Raise first-token + safety timeouts for long tool chains
- Honest toggles — compaction gate + prefix stability + output-opt gap
- Address all 4 P1+P2 findings + minor cleanups from critical review
- Roll cache hits + adaptive-params into "Tokens Saved"
- Manual /compact always clickable when callback is wired
- Post-compaction status badge no longer looks clickable
- Manual /compact summary now persists across turns
- Show post-compaction tokens, never touch chat history
- Block duplicate manual /compact reports
- "Recovered Sessions" stops resurrecting after deletion
- Resolve custom model IDs + summarise everything past the marker
- Dedup defense for re-emitted identical questions
- Add runner.os guard to platform-specific workflow steps
