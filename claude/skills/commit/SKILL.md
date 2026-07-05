---
name: commit
description: "MUST be invoked for ANY git commit creation or commit-message edit, including amend/reword/rephrase/fixup/squash-with-message. Trigger phrases (non-exhaustive): commit, commit it, commit this, commit that, commit them, commit changes, make a commit, create a commit, save changes, check this in, check in, git commit, amend, amend commit, amend the commit, amend last commit, git amend, reword, reword it, reword that, reword commit, reword last commit, rephrase, rephrase commit, rephrase the message, fix the commit message, change the commit message, edit the commit message, update the commit message, rewrite the commit message, rename the commit, fixup, squash (when squashing involves a new message). MANDATORY — never run `git commit`, `git commit --amend`, or any equivalent message-editing operation directly without invoking this skill first. Pass `--amend` as args when amending or rewording the previous commit."
---

# Git Commit Skill (Tim Pope's Standard)

When the user asks you to create a commit, follow these steps:

## 1. Gather Information

Run these commands in parallel to understand the changes:

```bash
git status
git diff --staged
git diff
git log --oneline -5
```

## 2. Stage Changes

- If there are unstaged changes, ask the user which files to include or stage all relevant changes
- Never stage files that likely contain secrets (.env, credentials, keys, etc.)

## 3. Write the Commit Message

**Read `STYLE.md` in this skill's directory first** — it captures the
author's voice (subject-line habits, when a body is warranted, register).
The rules below are the structural baseline; STYLE.md decides how the
message actually sounds.

Follow Tim Pope's commit message standard:

### Subject Line Rules
- **Limit to 50 characters** - Hard limit, be concise
- **Capitalize the first letter** - "Add feature" not "add feature"
- **No period at the end** - Trailing punctuation is unnecessary
- **Use imperative mood** - "Add" not "Added" or "Adds" (reads as a command: "This commit will... Add feature")

### Body Rules (if needed)
- **Separate from subject with a blank line**
- **Wrap at 72 characters**
- **Explain why, not what** - The diff shows what changed; the body carries the reasoning

### Good Subject Line Examples
- `Fix memory leak in image processor`
- `Add user authentication via OAuth2`
- `Remove deprecated API endpoints`
- `Update dependencies to fix security vuln`

### Bad Subject Line Examples
- `Fixed bug` (not specific, past tense)
- `Adding new feature for users.` (gerund, has period)
- `updated the code to fix the thing that was broken` (too long, lowercase, vague)

## 4. Present the Commit Message for Review

**CRITICAL: Always present the proposed commit message to the user and wait for their confirmation before committing.**

Format your proposal clearly:

```
Proposed commit message:
─────────────────────────
Subject line here (max 50 chars)

Optional body wrapped at 72 characters explaining what changed
and why. Focus on the motivation and context, not the mechanics.
─────────────────────────

Please confirm or suggest changes.
```

## 5. Create the Commit (After User Approval)

Only after the user confirms, use a HEREDOC to preserve formatting:

```bash
git commit -m "$(cat <<'EOF'
Subject line here

Body text here if needed.
EOF
)"
```

## 6. Verify

Run `git status` after committing to confirm success.

## Important Notes

- NEVER commit without user confirmation of the commit message
- NEVER amend commits that have been pushed to remote
- NEVER skip hooks unless explicitly requested
- NEVER commit secrets or sensitive files
- NEVER include `Co-Authored-By` lines or mention Claude, AI, Anthropic, or any AI tool in commit messages
- NEVER use Conventional Commit prefixes like `feat:`, `fix:`, `chore:`, `refactor:`, etc. — just write a clean imperative subject
- If a commit fails due to hooks, fix the issue and create a NEW commit
