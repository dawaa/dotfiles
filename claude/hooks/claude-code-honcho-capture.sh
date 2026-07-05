#!/bin/bash
# claude-code-honcho-capture.sh — Global Claude Code prompt capture to Honcho
#
# Registered as the UserPromptSubmit hook in ~/.claude/settings.json (user-global).
# Fires on EVERY user message in EVERY Claude Code session.
#
# Backs off when the project has its own .claude/hooks/orca-prompt-capture.sh —
# in that case the project-local hook handles it and we exit silently to
# avoid double-capture.
#
# Self-contained: reads ~/.honcho/config.json for endpoint + api key + workspace.
# No dependency on orca being installed in the project.
#
# Skip conditions (all result in exit 0, silent):
# - Project has its own orca-prompt-capture.sh (back off, no double-capture)
# - ~/.honcho/config.json missing
# - jq or curl not on PATH
# - Empty prompt
# - Prompt starts with /orca-auto or /clear (mechanical)
# - Honcho posting fails (3s timeout)
#
# Exit code contract: ALWAYS 0. Exit 2 would block the user's prompt from
# reaching Claude — never do that.

set +e
set -u

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
GLOBAL_HONCHO_CONFIG="$HOME/.honcho/config.json"
LOCAL_ORCA_CAPTURE="$PROJECT_DIR/.claude/hooks/orca-prompt-capture.sh"

# Back off if the project has its own Orca-scoped capture (avoid double-capture)
[ -x "$LOCAL_ORCA_CAPTURE" ] && exit 0

# Need global Honcho config + tools to do anything
[ ! -f "$GLOBAL_HONCHO_CONFIG" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0
command -v curl >/dev/null 2>&1 || exit 0

# Read stdin JSON; per code.claude.com/docs/en/hooks.md, UserPromptSubmit
# stdin has a `.prompt` field.
stdin=$(cat 2>/dev/null)
[ -z "$stdin" ] && exit 0

prompt=$(echo "$stdin" | jq -r '.prompt // empty' 2>/dev/null)
[ -z "$prompt" ] && prompt="$stdin"
[ -z "$prompt" ] && exit 0

# Skip mechanical commands
case "$prompt" in
  /orca-auto*) exit 0 ;;
  /clear*)     exit 0 ;;
esac

# Read Honcho config (matches ~/.honcho/config.json shape used by Hermes)
base_url=$(jq -r '.baseUrl // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
api_key=$(jq -r '[.hosts[]?.apiKey] | map(select(. != null and . != "")) | .[0] // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
workspace=$(jq -r '[.hosts[]?.workspace] | map(select(. != null and . != "")) | .[0] // "hermes"' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)

[ -z "$base_url" ] && exit 0
[ -z "$api_key" ] && exit 0

# Per-directory project basename, sanitized to alphanum/._-. tr -d '\n' first
# strips basename's trailing newline so there's no trailing dash.
proj=$(basename "$PROJECT_DIR" 2>/dev/null | tr -d '\n' | tr -c 'a-zA-Z0-9_.-' '-')
proj="${proj:-default}"

session_id="claude-code-${proj}"

# Per-project peer scheme: <user>-<projbasename> so each project accumulates
# its own context. Universal preferences live on a separate `preferences` peer
# that's curated manually. user defaults to $USER (works zero-config for
# anyone whose Honcho identity matches their Mac username); override by
# setting userPeer in ~/.honcho/config.json.
user_peer=$(jq -r '.userPeer // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
user_peer="${user_peer:-${USER:-user}}"
peer="${user_peer}-${proj}"

# Build message body and POST. Don't block on the response.
body=$(jq -nc --arg c "$prompt" --arg pid "$peer" \
  '{messages: [{content: $c, peer_id: $pid, metadata: {event: "user_prompt", source: "claude-code-global"}}]}' 2>/dev/null)
[ -z "$body" ] && exit 0

curl -sS -X POST \
  --max-time 3 \
  -H "Authorization: Bearer $api_key" \
  -H "Content-Type: application/json" \
  -d "$body" \
  "${base_url%/}/v3/workspaces/$workspace/sessions/$session_id/messages" \
  >/dev/null 2>&1

exit 0
