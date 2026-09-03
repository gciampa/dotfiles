#!/bin/bash

# Configuration
WEATHER_LOCATION="Tampa"

input=$(cat)

# Catppuccin Mocha colors
BLUE='\033[38;2;137;180;250m'
MAUVE='\033[38;2;203;166;247m'
SUBTEXT='\033[38;2;186;194;222m'
OVERLAY='\033[38;2;127;132;156m'
PEACH='\033[38;2;250;179;135m'
NC='\033[0m'

SEP="${OVERLAY}·${NC}"

# Get current directory and change to it
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
cd "$current_dir" 2>/dev/null || cd /

# Model
model=$(echo "$input" | jq -r '.model.display_name')

# Directory, with $HOME shortened to ~
dir=${current_dir/#$HOME/\~}

# Branch
branch=$(git branch --show-current 2>/dev/null)
if [ -z "$branch" ] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="detached"
fi

# Context usage
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
current_usage=$(echo "$input" | jq '.context_window.current_usage')

if [ "$current_usage" != "null" ]; then
  used_tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
else
  used_tokens=0
fi

pct_left=$((100 - used_tokens * 100 / ctx_size))
used_k="$((used_tokens / 1000))K"

# Weather (cached for 10 minutes)
weather_cache="/tmp/claude_weather_cache"
cache_max_age=600

if [ -f "$weather_cache" ]; then
  cache_age=$(($(date +%s) - $(stat -f %m "$weather_cache" 2>/dev/null || echo 0)))
else
  cache_age=$((cache_max_age + 1))
fi

if [ $cache_age -gt $cache_max_age ]; then
  weather=$(curl -s -m 2 "wttr.in/${WEATHER_LOCATION}?format=%c%C%20%t&u" 2>/dev/null)
  if [ -n "$weather" ]; then
    echo "$weather" > "$weather_cache"
  else
    weather=$(cat "$weather_cache" 2>/dev/null || echo "☁Unknown +--°F")
  fi
else
  weather=$(cat "$weather_cache")
fi

# Output: model · directory · branch · context left · tokens used · weather
segments=("${MAUVE}${model}${NC}" "${SUBTEXT}${dir}${NC}")
[ -n "$branch" ] && segments+=("${BLUE}${branch}${NC}")
segments+=("${SUBTEXT}Context ${pct_left}% left${NC}")
segments+=("${SUBTEXT}${used_k} used${NC}")
segments+=("${PEACH}${WEATHER_LOCATION}:${NC} ${SUBTEXT}${weather}${NC}")

line=""
for segment in "${segments[@]}"; do
  if [ -z "$line" ]; then
    line="$segment"
  else
    line="${line} ${SEP} ${segment}"
  fi
done

printf "%b\n" "$line"
