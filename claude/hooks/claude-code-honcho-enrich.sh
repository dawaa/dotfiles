#!/bin/bash
# claude-code-honcho-enrich.sh — Global Claude Code enrich hook
#
# Registered as a UserPromptSubmit hook in ~/.claude/settings.json,
# AFTER claude-code-honcho-capture.sh.
#
# Before each user prompt, fetches two representations from Honcho:
#   1. peer=preferences        — universal response-style preferences
#                                (curated; doesn't grow from prompt capture)
#   2. peer=<user>-<projdir>   — per-project facts/context
#                                (auto-grows from prompt capture)
#
# Both endpoints are static DB fetches (no LLM call inside Honcho), typical
# latency ~700ms each, run sequentially. Outputs JSON with additionalContext
# for system-reminder-style injection (more discrete than plain stdout).
#
# Skip conditions (all exit 0 silently, no output):
# - ~/.honcho/config.json missing
# - jq or curl not on PATH
# - Empty prompt or prompt < 8 chars
# - Slash command (mechanical / specialized)
# - Honcho call fails (network, timeout, parse error)
# - Both representations come back empty
#
# Exit code contract: ALWAYS 0. Exit 2 would block the user's prompt.

set +e
set -u

GLOBAL_HONCHO_CONFIG="$HOME/.honcho/config.json"

[ ! -f "$GLOBAL_HONCHO_CONFIG" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0
command -v curl >/dev/null 2>&1 || exit 0

stdin=$(cat 2>/dev/null)
[ -z "$stdin" ] && exit 0

prompt=$(echo "$stdin" | jq -r '.prompt // empty' 2>/dev/null)
[ -z "$prompt" ] && exit 0

# Skip slash commands (mechanical / specialized; orca-* dispatch their own enrich during planning)
case "$prompt" in
  /*) exit 0 ;;
esac

# Skip prompts too short to carry signal
[ "${#prompt}" -lt 8 ] && exit 0

base_url=$(jq -r '.baseUrl // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
api_key=$(jq -r '[.hosts[]?.apiKey] | map(select(. != null and . != "")) | .[0] // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
workspace=$(jq -r '[.hosts[]?.workspace] | map(select(. != null and . != "")) | .[0] // "hermes"' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
user_peer=$(jq -r '.userPeer // empty' "$GLOBAL_HONCHO_CONFIG" 2>/dev/null)
user_peer="${user_peer:-${USER:-user}}"

[ -z "$base_url" ] && exit 0
[ -z "$api_key" ] && exit 0

# Per-project peer = <user_peer>-<sanitized project basename>
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
proj=$(basename "$PROJECT_DIR" 2>/dev/null | tr -d '\n' | tr -c 'a-zA-Z0-9_.-' '-')
proj="${proj:-default}"
project_peer="${user_peer}-${proj}"

PREFERENCES_PEER="preferences"

fetch_representation() {
  local peer="$1"
  local body="$2"
  curl -sS -X POST \
    --max-time 2 \
    -H "Authorization: Bearer $api_key" \
    -H "Content-Type: application/json" \
    -d "$body" \
    "${base_url%/}/v3/workspaces/$workspace/peers/$peer/representation" 2>/dev/null \
    | jq -r '.representation // empty' 2>/dev/null
}

prefs_content=$(fetch_representation "$PREFERENCES_PEER" '{"include_most_frequent":true,"max_conclusions":50}')
project_content=$(fetch_representation "$project_peer" '{"include_most_frequent":true,"max_conclusions":50}')

# If both empty, skip the injection
if [ -z "$prefs_content" ] && [ -z "$project_content" ]; then
  exit 0
fi
if [ "$prefs_content" = "null" ] && [ "$project_content" = "null" ]; then
  exit 0
fi

# Build the combined context block. Each section labeled so Claude can weight
# them. Empty sections are omitted.
combined=""
if [ -n "$prefs_content" ] && [ "$prefs_content" != "null" ]; then
  combined="## Universal response-style preferences (Honcho peer=$PREFERENCES_PEER)

$prefs_content"
fi
if [ -n "$project_content" ] && [ "$project_content" != "null" ]; then
  if [ -n "$combined" ]; then
    combined="$combined

## Project context (Honcho peer=$project_peer)

$project_content"
  else
    combined="## Project context (Honcho peer=$project_peer)

$project_content"
  fi
fi

[ -z "$combined" ] && exit 0

jq -nc --arg ctx "$combined" \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $ctx}}'

exit 0
