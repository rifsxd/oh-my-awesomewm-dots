#!/usr/bin/env bash

## Autostart Programs

# Kill already running process
_ps=(picom polkit-gnome-authentication-agent-1 blazefetch)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall ${_prs}
	fi
done

# Picom compositor
picom &

# Gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# BLazefetch daemon
blazefetch -d