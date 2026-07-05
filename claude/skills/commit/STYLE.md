# Commit Voice Reference

Broad strokes, not templates — the goal is that a commit reads like the
author wrote it, not like a changelog generator did.

The one rule above all: **the diff shows the WHAT; the message carries the
WHY.** The reasoning behind a change is the only thing that can't be
recovered from the diff later, so that's what the body exists for.

## Subject lines

- Imperative, capitalized, no period, ~50 chars — standard Tim Pope.
- Backtick every technical token: file names (`.tmux.conf`), tools
  (`kmonad`, `brew`), env vars (`$IS_TMUX`), keybindings (`hyper - space`),
  plugin names. This is the single most distinctive habit — subjects are
  dense with backticks.
- Verb-led and plain: Add, Remove, Fix, Update, Move, Revert, Turn off,
  Allow, Correct, Clarify, Adjust, Improve, Set, Make, Introduce, Use.
- For pure config touch-ups, a noun-phrase subject with no verb is fine:
  "`.tmux.conf` visual optimizations", "`karabiner.json` update".
- Honesty over polish: subjects admit uncertainty or low effort when true —
  "Blindly update …", "Attempt at automizing installation".
- Abbreviations are acceptable to fit 50 chars ("impl.", "docs").

## Bodies

- **Most commits have no body.** If the subject says it all, stop there.
  Don't manufacture a body to look thorough.
- Explains **why / the backstory**, almost never the mechanics: what
  prompted the change, what was annoying, what was tried before, why this
  approach over another. The mechanics are already in the diff.
- **First-person and conversational** — a note to future self, not
  documentation. "Since I no longer use these." "For work." "I don't
  remember why." Two words is a valid body if they carry the why.
- The body may grammatically continue the subject as one sentence.
- Personal context is welcome ("Setting up new mac", "for when I'm sharing
  my screen").
- **Admits uncertainty and untested state plainly**: "This has not been
  tested", "Things _might_ break", "I don't exactly remember why", even
  self-deprecation when a past mistake is being fixed. Never dress up a
  guess as a decision.
- Cites sources when a fix came from somewhere: footnote-style links
  (`[^1]: https://…`), GitHub issue titles + links, Stack Overflow/Reddit.
- Includes fenced code blocks when useful — the annoying output being
  silenced, the commands to run/debug later.
- References an earlier commit by its hash when correcting it.
- Bullet lists for genuinely multi-item changes; prose otherwise.
- Wrapped at ~72 chars.

## Overall register

Casual, terse, honest, slightly wry. No exclamation-mark enthusiasm, no
corporate changelog tone ("This commit introduces enhanced…" — never).
When in doubt: shorter, plainer, more first-person.
