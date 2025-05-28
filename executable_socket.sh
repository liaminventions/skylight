#!/bin/sh
set -ex
wsp="" 

ws() {
	if [ "$1" != "$wsp" ]; then
		~/play switch &
	fi
	wsp=$1

}

fsp="" 
fs() { 
	if [ "$1" != "$fsp" ]; then
		stat=$(echo "$1" | grep -o '[0-9]\+')
		if [ $stat -eq 1 ]; then
			#enable
			~/play full &
		else
			#disable
			~/play down &
		fi
	fi
	fsp=$1
}

swp=""
sw() {
	if [ "$1" != "$swp" ]; then
		~/play cl 12000 &
	fi
	swp=$1
} 

owp=""
ow() {	
	if [ "$1" != "$owp" ]; then
		~/play pop &
	fi
}

cwp=""
cw() {
	if [ "$1" != "$cwp" ]; then
		~/play pop2 60020 &
	fi
}

olp=""
ol() {
	d=$(echo "$1" | cut -d'>' -f3)
	if [ "$d"  != "gtk-layer-shell" ] && [ "$d" != "notifications" ] && [ "$d" != "hyprpicker" ] && [ "$d" != "selection" ]; then
		if [ "$1" != "$olp" ]; then
		~/play open 60020 &
		fi
	fi
} 

clp=""
cl() {
	d=$(echo "$1" | cut -d'>' -f3)
	if [ "$d"  != "gtk-layer-shell" ] && [ "$d" != "notifications" ] && [ "$d" != "hyprpicker" ] && [ "$d" != "selection" ]; then
		if [ "$1" != "$clp" ]; then
			~/play close &
		fi 
	fi
} 

handle() {
  case $1 in
	  workspacev2*) ws "$1";;
	  fullscreen*) fs "$1";;
	  activewindowv2*) ;; 
	  activewindow*) sw "$1";;
	  openwindow*) ow "$1";;
	  closewindow*) cw "$1";;
	  openlayer*) ol "$1";;
	  closelayer*) cl "$1";;
  esac
} 

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
