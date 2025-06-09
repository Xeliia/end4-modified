#!/usr/bin/env bash

# Vars
cache_dir="$HOME/.cache/albumart"
fallback="$HOME/.face.icon"

# Ensure cache exists
mkdir -p "$cache_dir"

# Get metadata
url=$(playerctl metadata mpris:artUrl 2>/dev/null)
artist=$(playerctl metadata xesam:artist 2>/dev/null)
album=$(playerctl metadata xesam:album 2>/dev/null)

# Check if music is playing
if [[ -z "$url" || "$url" == "No player found" || -z "$artist" || -z "$album" ]]; then
  echo "$fallback"
  exit 0
fi

# Generate file path
metadata="${artist} - ${album}"
safe_metadata=$(echo "$metadata" | sed 's/[^a-zA-Z0-9._-]/_/g') # sanitize filename
img_path="$cache_dir/${safe_metadata}.png"
tmp_img="$cache_dir/${safe_metadata}.tmp"

# Use cached image if it exists
if [[ -f "$img_path" ]]; then
  echo "$img_path"
  exit 0
fi

# Download and convert
if curl -s --fail "$url" -o "$tmp_img"; then
  if magick "$tmp_img" "$img_path" 2>/dev/null; then
    rm "$tmp_img"
    echo "$img_path"
    exit 0
  else
    rm -f "$tmp_img"
    echo "$fallback"
    exit 0
  fi
else
  rm -f "$tmp_img"
  echo "$fallback"
  exit 0
fi
