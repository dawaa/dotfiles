#!/usr/bin/env bash
# Slim Claude Code status line: model · ctx% · session cost · 5h quota (+reset) · weekly quota.
# ctx% is parsed from `ccusage statusline` (transcript-derived); everything else comes
# straight from the JSON Claude Code pipes in (.cost.total_cost_usd, .rate_limits.* —
# the same numbers /usage shows). Segments degrade gracefully when data is absent.
# Synced across devices via dotfiles/claude/ — keep paths $HOME-relative.
export LC_ALL=C  # numeric printf: some boxes use decimal-comma locales

command -v jq >/dev/null 2>&1 || { echo "statusline: jq missing"; exit 0; }
input=$(cat)

# ccusage: PATH first, then common install homes; CCUSAGE_BIN overrides for testing.
CCUSAGE="${CCUSAGE_BIN:-$(command -v ccusage 2>/dev/null)}"
if [ -z "$CCUSAGE" ] || [ ! -x "$CCUSAGE" ]; then
  for c in "$HOME/.bun/bin/ccusage" "$HOME/.local/bin/ccusage" "$HOME/.npm-global/bin/ccusage"; do
    [ -x "$c" ] && CCUSAGE="$c" && break
  done
fi

DIM=$'\e[2m'; BOLD=$'\e[1m'; CYAN=$'\e[36m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; RED=$'\e[31m'; R=$'\e[0m'
sep=" ${DIM}·${R} "

pct_color() { # $1 value, $2 yellow-from, $3 red-from
  local p=${1%.*}
  if [ "${p:-0}" -ge "$3" ] 2>/dev/null; then printf '%s' "$RED"
  elif [ "${p:-0}" -ge "$2" ] 2>/dev/null; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

IFS=$'\t' read -r model cost s5 wk reset <<<"$(printf '%s' "$input" | jq -r '[
  (.model.display_name // "?"),
  ((.cost.total_cost_usd // "") | tostring),
  ((.rate_limits.five_hour.used_percentage // "") | tostring),
  ((.rate_limits.seven_day.used_percentage // "") | tostring),
  ((.rate_limits.five_hour.resets_at // "") | tostring)
] | @tsv' 2>/dev/null)"

out="${BOLD}${CYAN}${model}${R}"

if [ -n "$CCUSAGE" ] && [ -x "$CCUSAGE" ]; then
  ctx=$(printf '%s' "$input" | "$CCUSAGE" statusline 2>/dev/null \
        | grep -oE '\([0-9.]+%\)' | tr -d '()%')
  [ -n "$ctx" ] && out+="${sep}🧠 $(pct_color "$ctx" 25 40)${ctx%.*}%${R}"
else
  out+="${sep}${YELLOW}⚠ ccusage missing — npm i -g ccusage${R}"
fi

[ -n "$cost" ] && out+="${sep}💰 \$$(printf '%.2f' "$cost")"
if [ -n "$s5" ]; then
  left=""
  if [ -n "$reset" ]; then
    secs=$(( ${reset%.*} - $(date +%s) ))
    [ "$secs" -gt 0 ] && left=" ${DIM}($((secs / 3600))h $(((secs % 3600) / 60))m)${R}"
  fi
  out+="${sep}⏳ 5h $(pct_color "$s5" 25 40)$(printf '%.0f' "$s5")%${R}${left}"
fi
[ -n "$wk" ] && out+="${sep}📅 wk $(pct_color "$wk" 25 40)$(printf '%.0f' "$wk")%${R}"
printf '%s\n' "$out"
