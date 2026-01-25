#!/usr/bin/env bash

THEME_DIR="/usr/share/sddm/themes/animated-sddm-themes/themeConfigs"

if [ -z "$1" ]; then
  echo "Usage: $0 <theme-name>"
  echo "available themes: frieren, makima, senjougahara"
  echo "Example: $0 frieren"
  exit 1
fi

THEME="$1"
TARGET="$THEME_DIR/${THEME}.conf"
CURRENT="$THEME_DIR/current.conf"

if [ ! -f "$TARGET" ]; then
  echo "Error: $TARGET doesnt exist"
  exit 1
fi

cp "$TARGET" "$CURRENT"
