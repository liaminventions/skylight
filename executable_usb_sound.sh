#!/bin/bash
set -ex

USER=$(loginctl list-users | awk '$1 != "UID" {print $2}' | head -n 1)
RUNTIME_DIR=$(loginctl show-user "$USER" -p RuntimePath | cut -d= -f2)

if [ "$1" == "add" ]; then
	sudo -u "$USER" XDG_RUNTIME_DIR="$RUNTIME_DIR" paplay --volume=65536 /usr/share/sounds/add.ogg

elif [ "$1" == "remove" ]; then
	sudo -u "$USER" XDG_RUNTIME_DIR="$RUNTIME_DIR" paplay --volume=65536 /usr/share/sounds/remove.ogg
fi

