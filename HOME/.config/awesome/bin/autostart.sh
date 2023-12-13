#!/usr/bin/env bash

## Autostart Programs

# Kill already running process
_ps=(compfy polkit-gnome-authentication-agent-1 blazefetch unclutter)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall ${_prs}
	fi
done

# Compfy compositor
compfy &

# Gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# BLazefetch daemon
blazefetch -d

unclutter --start-hidden &
