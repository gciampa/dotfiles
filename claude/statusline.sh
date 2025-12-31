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

# Get current directory and change to it
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
cd "$current_dir" 2>/dev/null || cd /

# Git info
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
  branch=$(git branch --show-current 2>/dev/null || echo "detached")
  git_info="${BLUE}${repo}${NC} ${OVERLAY}(${NC}${BLUE}${branch}${NC}${OVERLAY})${NC}"
else
  git_info=""
fi

# Model info
model=$(echo "$input" | jq -r '.model.display_name')

# Context usage
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
current_usage=$(echo "$input" | jq '.context_window.current_usage')

if [ "$current_usage" != "null" ]; then
  current_tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  pct=$((current_tokens * 100 / ctx_size))
else
  pct=0
fi

# Progress bar
filled=$((pct * 20 / 100))
empty=$((20 - filled))
filled_bar=""
empty_bar=""
for ((i=0; i<filled; i++)); do filled_bar+="█"; done
for ((i=0; i<empty; i++)); do empty_bar+="░"; done
bar="${SUBTEXT}${filled_bar}${OVERLAY}${empty_bar}${NC}"

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

# Output
if [ -n "$git_info" ]; then
  printf "%b\n" "${git_info} ${OVERLAY}|${NC} ${MAUVE}${model}${NC} ${OVERLAY}|${NC} ${SUBTEXT}Context:${NC} [${bar}] ${SUBTEXT}${pct}%${NC} ${OVERLAY}|${NC} ${PEACH}${WEATHER_LOCATION}:${NC} ${SUBTEXT}${weather}${NC}"
else
  printf "%b\n" "${MAUVE}${model}${NC} ${OVERLAY}|${NC} ${SUBTEXT}Context:${NC} [${bar}] ${SUBTEXT}${pct}%${NC} ${OVERLAY}|${NC} ${PEACH}${WEATHER_LOCATION}:${NC} ${SUBTEXT}${weather}${NC}"
fi
