local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local xresources = require("beautiful.xresources")
local screenshot = require("screenshot")
local dpi = xresources.apply_dpi

local comp_path = string.format("%s/.config/awesomw/misc/compositor/compfy.conf", os.getenv("HOME"))

awful.util.terminal = "kitty"
terminal = "kitty"
filemanager = "thunar"
browser = "firefox"
editor = os.getenv("EDITOR") or "mousepad"
editor_cmd = terminal .. " -e " .. editor

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "config", editor_cmd .. " " .. awesome.conffile },
   { "theme", editor_cmd .. " " .. theme_path },
   { "reload", awesome.restart },
   
}

mypowermenu = {
   { "logout", function() awesome.quit() end },
   { "reboot", function () awful.spawn.with_shell("systemctl reboot") end },
   { "poweroff", function () awful.spawn.with_shell("systemctl poweroff") end },
}

mymiscmenu = {
   { "compositor on", function () awful.spawn.with_shell("compfy --config ~/.config/awesome/misc/compositor/compfy.conf") end },
   { "compositor off", function () awful.spawn.with_shell("killall compfy") end },
   { "compositor config", editor_cmd .. " " .. comp_path },
}

myscreenshotmenu = {
   { "scrnshot full", scrot_full },
   { "scrnshot sel", scrot_selection },
   { "scrnshot win", scrot_window },
   { "scrnshot delay", scrot_delay },
}

mygamingmenu = {
   { "lutris", function () awful.spawn("lutris") end },
   { "steam", function () awful.spawn("steam") end },
}

mysocialmenu = {
   { "discord", function () awful.spawn("discord") end },
   { "spotify", function () awful.spawn("spotify") end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
				    { "misc", mymiscmenu },
				    { "screenshot", myscreenshotmenu },
				    { "themes", generateThemeMenu() },
				    { "social", mysocialmenu },
				    { "gaming", mygamingmenu },
				    { "run promt", function () menubar.show() end },
				    { "open terminal", terminal },
				    { "open browser", browser },
				    { "open files", filemanager },
				    { "open vscode", "code" },
				    { "power", mypowermenu }
                                  }
				})

mymiscmenu = {
   { "reload", awesome.restart },
   { "logout", function() awesome.quit() end },
   { "reboot", function () awful.spawn.with_shell("systemctl reboot") end },
   { "poweroff", function () awful.spawn.with_shell("systemctl poweroff") end },
}

myrebootmenu = awful.menu({ items = mymiscmenu })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })


