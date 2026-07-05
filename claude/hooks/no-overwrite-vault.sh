#!/usr/bin/env bash
# PreToolUse/Write hook: refuse to OVERWRITE an existing note inside the
# Obsidian vault (~/.syncthing/obsidian). New files and the Edit tool are
# unaffected. Fails open (allows) on any unexpected input so it can never
# wedge the Write tool globally.
vault="$HOME/.syncthing/obsidian"
path="$(jq -r '.tool_input.file_path // empty' 2>/dev/null)" || exit 0
[ -n "$path" ] || exit 0
case "$path" in
  "$vault"/*) ;;
  *) exit 0 ;;
esac
if [ -e "$path" ]; then
  jq -n --arg p "$path" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("Blocked: Write would overwrite an existing vault note (\($p)). Use Edit for in-place changes, or Write only to a new path. (no-overwrite-vault hook)")
    }
  }'
fi
exit 0
