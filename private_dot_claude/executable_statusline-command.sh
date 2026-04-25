#!/bin/bash
input=$(cat)

RESET='\033[0m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'

total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
total_tokens=$((total_in + total_out))

token_display=$(printf "%'d" "$total_tokens")

ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$ctx_used" ]; then
  ctx_int=$(printf "%.0f" "$ctx_used")
  if [ "$ctx_int" -ge 80 ]; then ctx_color="$RED"; ctx_icon="🔴"
  elif [ "$ctx_int" -ge 50 ]; then ctx_color="$YELLOW"; ctx_icon="🟡"
  else ctx_color="$GREEN"; ctx_icon="🟢"; fi
  ctx_part=$(printf "${ctx_color}${ctx_icon} ctx:%d%%${RESET}" "$ctx_int")
fi

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$five_pct" ]; then
  five_int=$(printf "%.0f" "$five_pct")
  if [ "$five_int" -ge 80 ]; then five_color="$RED"; five_icon="🔴"
  elif [ "$five_int" -ge 50 ]; then five_color="$YELLOW"; five_icon="🟡"
  else five_color="$GREEN"; five_icon="🟢"; fi
  five_part=$(printf "${five_color}${five_icon} 5h:%d%%${RESET}" "$five_int")

  if [ -n "$five_resets_at" ]; then
    now=$(date +%s)
    diff=$(( five_resets_at - now ))
    if [ "$diff" -le 0 ]; then
      five_part="$five_part ${DIM}(resets now)${RESET}"
    else
      diff_min=$(( diff / 60 ))
      diff_hr=$(( diff_min / 60 ))
      diff_rem=$(( diff_min % 60 ))
      if [ "$diff_hr" -gt 0 ]; then
        five_part="$five_part ${DIM}(resets in ${diff_hr}h${diff_rem}m)${RESET}"
      else
        five_part="$five_part ${DIM}(resets in ${diff_min}m)${RESET}"
      fi
    fi
  fi
fi

tokens_part=$(printf "${CYAN}🪙 %s tokens${RESET}" "$token_display")

result="$tokens_part"
[ -n "$ctx_part" ] && result="$result ${DIM}|${RESET} $ctx_part"
[ -n "$five_part" ] && result="$result ${DIM}|${RESET} $five_part"

printf "%b" "$result"
