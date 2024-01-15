local awful = require("awful")

awful.util.terminal = "wezterm" -- sets the preferred terminal for awesomewm's terminal ENV_VARIABLE

terminal = awful.util.terminal -- really? >.<

filemanager = "thunar" -- you know what it is ;)

browser = "firefox" -- you know what it is ;)

editor = os.getenv("EDITOR") or "mousepad" -- gets editor from ENV_VARIABLE or mousepad

editor_cmd = terminal .. " -e " .. editor -- open config with the preferred editor

launcher = "~/.config/awesome/misc/menu/bin/launcher" -- app launcher menu

windows = "~/.config/awesome/misc/menu/bin/windows" -- windows selection menu

emoji = "~/.config/awesome/misc/menu/bin/emoji" -- emoji menu

network = "~/.config/awesome/misc/menu/bin/network" -- network menu

record = "obs --startrecording --minimize-to-tray" -- quick record with obs

ide = "code" -- you know what it is ;)

comp = "picom_fluid" -- available options: picom(v10.2 - stable - stock) & picom_fluid(vgit-49645-fluid - edge - animations) && compfy(v1.7.2 - stable - animations)

modkey = "Mod4" -- Win Key

altkey = "Mod1" -- Alt Key

comp_bin = string.format("%s/.config/awesome/misc/compositor/bin/%s", os.getenv("HOME"), comp) -- current path .. bin of the compositor

comp_path = string.format("%s/.config/awesome/config/compositor/comp.conf", os.getenv("HOME")) -- current path of the compositor config

conf_path = string.format("%s/.config/awesome/", os.getenv("HOME")) -- current path of awesomewm config (rc.lua)