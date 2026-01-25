# !/usr/bin/env bash
set -e

THEME_NAME="animated-sddm-themes"
THEME_SOURCE_DIR="$(pwd)"
SDDM_THEME_DIR="/usr/share/sddm/themes"
SDDM_CONF_DIR="/etc/sddm.conf.d"
SDDM_CONF_FILE="$SDDM_CONF_DIR/10-theme.conf"
SDDM_CONF_DEF_FILE="/etc/sddm.conf"

if [[ $EUID -ne 0 ]]; then
  echo "run as root (sudo) yo"
  exit 1
fi

if [ ! -d "$THEME_SOURCE_DIR" ]; then
  echo "theme folder not found, install again"
fi

cp -r "$THEME_SOURCE_DIR" "$SDDM_THEME_DIR/"

mkdir -p "$SDDM_CONF_DIR"

cat >"$SDDM_CONF_FILE" <<EOF
[Theme]
Current=$THEME_NAME
EOF

cat >"$SDDM_CONF_DEF_FILE" <<EOF
[Theme]
Current=$THEME_NAME

[General]
InputMethod=
EOF

echo "theme set (prolly)"
