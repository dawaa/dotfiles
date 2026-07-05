---
name: session-handoff
description: "Write a Claude-readable session handoff file so the user can /clear context and a fresh Claude session can resume from it. Trigger phrases: save session, handoff, snapshot session, write session summary, dump context, save context, before I clear, prep for clear, /handoff. Defaults to /tmp/<cwd-as-hyphens>-<date-time>.md. Pass an alternate path as args if user requests it."
---

# session-handoff

Write a single file that **a future Claude session, with zero memory of this conversation, can read and immediately resume from**. The audience is Claude, not a human. Optimize for Claude's ability to act, not for human narrative or pedagogy.

The fresh Claude reading this file already has: filesystem access, the same tools, CLAUDE.md, and memory. It does **not** have: this transcript, what the user said in passing, what you tried and rejected, or any unsaved reasoning.

## What "Claude-readable" means here

- **Dense > readable.** No narrative arcs, no "we then…", no TL;DR for humans. Facts and pointers.
- **Pointers > content.** Don't re-paste files. Give absolute paths and line ranges; the reader has Read.
- **Verbatim > paraphrase** for user instructions, constraints, preferences, error messages.
- **Negative knowledge matters.** What you *tried and ruled out* is as valuable as what worked — it stops the next session from redoing it.
- **No emojis. No headers-for-headers' sake.** Every line earns its place.

If a section would be empty, omit it. Don't write "N/A".

## Default output filename

Encode cwd-as-hyphens + date + time so handoffs never silently overwrite each other and the file is one copy-pasteable token.

```bash
echo "/tmp/$(pwd | sed 's|/|-|g')-$(date +%Y-%m-%d-%H%M).md"
```

Example: `/tmp/-Users-jandro-Documents-Projects-ios-ipa-tweak-2026-05-01-1530.md`

The leading `-` (from the leading `/`) is intentional — mirrors Claude's project-dir naming. If the computed path already exists, append `-2`, `-3`, … before `.md`.

If user passes a path as args, use it verbatim. Bare filename → put it in `/tmp/`.

## Before writing — collect ground truth

Run these (parallel where possible) and pin the output into the file:

- `pwd`
- `git rev-parse --abbrev-ref HEAD`
- `git log -1 --oneline`
- `git status --short`
- `git diff --stat` (and full `git diff` if uncommitted changes are central to the task)
- Any background process you started (port, PID command, how to stop it)
- Any prior handoff files in `/tmp/` matching this cwd's prefix — list them so the reader can chain back

Also re-scan the conversation for: every absolute path you touched, every command the user told you to use or avoid, every error message that mattered, every approach you tried and abandoned.

## File structure (write it exactly like this)

Lead with a short directive to the future Claude, then dense fact blocks. Order is fixed — the reader will skim top-down.

```markdown
# HANDOFF

You are a fresh Claude session resuming work in this repo. Read this file as
ground truth. Verify any claim against the live filesystem before acting on it
(files may have changed). Start from `## NEXT` unless the user says otherwise.

## META
cwd: <absolute path>
branch: <branch>
head: <sha> <subject>
written: <ISO datetime>
prior_handoffs: <absolute paths of any earlier /tmp/<this-cwd>-*.md, oldest→newest, or "none">

## GOAL
<1–3 lines. What the user is trying to accomplish in this thread of work.
Include hard constraints the user stated, verbatim if short.>

## USER_CONSTRAINTS
<Bulleted, verbatim where possible. Preferences, do-nots, must-dos that the
fresh session would otherwise violate. Examples:
- "keep the intro screen, don't skip it"
- "don't run idevicesyslog, doesn't work on iOS 26"
- "single repo, one tweak per dir under tweaks/"
Pull from this conversation; don't restate what's already in CLAUDE.md unless
the user reinforced it.>

## STATE
working_tree:
  modified: <list, or "none">
  untracked: <list, or "none">
build:
  last_result: <ok | fail | not built>
  last_command: <exact command, or "—">
running_processes:
  - <name> :<port> — pid <pid> — stop with `<command>`
  - …
device_or_external:
  - <e.g. "Pandora installed in LiveContainer at v2601.1, with PandoraLife dylib injected">
  - <e.g. "HTTP server serving decrypted/pandora on :8080 — phone IP 192.168.1.42 hit it at 14:22">

## FILES
<Absolute path — one-line why-it-matters. Order by importance to NEXT.
Include:
- files edited this session (with a one-line summary of the edit + line refs)
- NOTES.md / PLAN.md / CLAUDE.md sections that drove decisions
- prior handoff files
- memory files referenced
Format:
- /abs/path:LINE-LINE — what's there and why the reader cares
>

## DID
<Bullets of meaningful actions taken, each anchored to a path:line or a command.
Skip trivia (ls, cd, simple reads). One line per action. No chronology unless
order matters for correctness.>

## TRIED_AND_RULED_OUT
<Approaches attempted and abandoned, with the reason. Critical — stops the next
session from redoing dead ends. Format:
- <approach> — <why it failed / was rejected, with evidence: error msg, user
  pushback verbatim, or path:line of the proof>
>

## OPEN
<Unresolved questions, untested assumptions, things deferred. Be honest:
"didn't run the build", "user hasn't confirmed X", "hook compiles but unverified
on device".>

## NEXT
1. <The single concrete next action. Specific enough that the fresh session can
   start without asking.>
2. <Follow-up.>
3. <Follow-up.>

## COMMANDS
<Exact, copy-pasteable commands the next session will likely need. Include the
build command for this app, the rebuild script invocation, the log tail
command, the HTTP server command. Don't paraphrase — paste.>

## GOTCHAS
<Things that bit us and would bite again. Sandbox quirks, flaky tools,
"insert_dylib needs codesign -fs- not ldid", etc. One line each.>
```

## Writing rules

- **Absolute paths only** in FILES, COMMANDS, prior_handoffs. The reader cannot infer cwd from context.
- **Line refs** when pointing at code (`Tweak.m:142-178`), not "near the top".
- **Verbatim user quotes** for preferences and corrections. Paraphrase loses nuance.
- **No re-pasting file contents.** Reader has Read. The exception: an error message or short snippet (≤5 lines) that is the *evidence* for a TRIED_AND_RULED_OUT entry.
- **No CLAUDE.md restating.** The fresh session loads CLAUDE.md automatically. Only mention CLAUDE.md content if the user overrode or refined it this session.
- **Negative findings are first-class.** "X doesn't work because Y" earns a line in TRIED_AND_RULED_OUT.
- **Date-stamp the META block.** Use the actual `date` command output, not "today".

## Self-check before saving

Before writing the file, verify it would actually let a fresh Claude resume:

- Could the reader run `## NEXT` step 1 without asking the user a clarifying question? If no, NEXT is too vague — fix it.
- Are all referenced paths absolute and present on disk?
- Does TRIED_AND_RULED_OUT cover the dead ends from this session, or did you skip them because they felt obvious to you (they won't to the reader)?
- Are USER_CONSTRAINTS pulled verbatim from this session's messages, not invented?

## After writing

End your reply with exactly this block, substituting the real absolute path:

```
Handoff written → <absolute path>

Resume in a new session with:
    Read <absolute path> and continue from "## NEXT".
```

The path must appear on its own line, twice, so it's trivially copy-pasteable. No other commentary after this block.

## When NOT to invoke

- One-shot question, not a working session — nothing to hand off.
- User wants a commit message / PR description / memory update — different artifacts; suggest the right tool.
