# Claude Code global config

Tracked subset of `~/.claude`. Named `claude/` (no dot) on purpose — a `.claude/`
directory at the repo root is read by Claude Code as *project* config for
sessions running inside this repo, which would double-register the hooks below.

`bin/restore` maps this directory onto `~/.claude`.

## Contents

- `CLAUDE.md` — global operating instructions
- `MISTAKES.md` — recurring mistakes + corrections, with a `×N` recurrence counter per entry; `CLAUDE.md` requires reading it before any non-trivial task
- `settings.json` — model, hooks, sandbox, statusline (no secrets; hook paths are absolute `/Users/jandro/...`)
- `statusline.sh` — slim status line (model · ctx% · session cost · 5h quota + reset · weekly quota),
  invoked as `bash ~/.claude/statusline.sh` from settings.json. Quotas come from the official
  `rate_limits` stdin JSON; ctx% needs **ccusage** (`npm i -g ccusage`) and degrades to an inline
  warning without it. Traffic-light thresholds (yellow 25% / red 40%) live in the `pct_color` calls.
- `hooks/`
  - `claude-code-honcho-capture.sh` / `claude-code-honcho-enrich.sh` — Honcho memory capture/enrich on every prompt; read the API key at runtime from `~/.honcho/config.json` (NOT tracked — recreate it by hand)
  - `no-overwrite-vault.sh` — PreToolUse guard: blocks `Write` from overwriting existing Obsidian vault notes
- `skills/` — hand-written skills only (see below)

## Skills not tracked here

Only hand-written skills live in `skills/`. Third-party ones are installed with
`npx skills@latest add <repo>` into `~/.agents/skills/` and symlinked from
`~/.claude/skills/`. Deliberately not tracked and not restored — whichever ones
are still wanted can be re-added by hand; `~/.agents/.skill-lock.json` records
what was installed and from where.

`plex-debug` symlinks into `../nerds_lan/.claude/skills/plex-debug`, versioned in
that repo.
