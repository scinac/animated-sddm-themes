#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "run as root (sudo) y0"
  exit 1
fi

if [ -f /etc/arch-release ]; then
  pacman -S --needed --noconfirm qt6-multimedia qt6-declarative qt6-5compat qt6-svg
elif [ -f /etc/debian_version ]; then
  apt update
  apt install -y qml6-module-qtmultimedia qml6-module-qtquick-layouts qml6-module-qtquick-controls qml6-module-qtquick-effects libqt6multimedia6
elif [ -f /etc/fedora-release ]; then
  dnf install -y qt6-qtmultimedia qt6-qtdeclarative qt6-qtsvg
else
  exit 1
fi

echo "dependencies installed"
