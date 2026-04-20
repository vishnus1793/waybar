#!/bin/bash

url=$(playerctl metadata xesam:url 2>/dev/null)

# Extract YouTube video ID
if [[ $url == *"youtube.com"* ]]; then
    video_id=$(echo "$url" | sed -n 's|.*v=\([^&]*\).*|\1|p')
    thumb="https://img.youtube.com/vi/$video_id/hqdefault.jpg"
else
    thumb=""
fi

title=$(playerctl metadata xesam:title 2>/dev/null)

echo "{\"text\": \"$title\", \"image\": \"$thumb\"}"
