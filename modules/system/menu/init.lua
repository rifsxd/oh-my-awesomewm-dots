local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi
require("system.screenshot")
local freedesktop = require("freedesktop")
require("system.theming")
require("system.wallpaper")
require("system.alphavar")

function runpromt()
   menubar.show()
end

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "config", editor_cmd .. " " .. awesome.conffile },
   { "code", ide .. " " .. conf_path },
   { "theme", editor_cmd .. " " .. theme_path },
   { "reload", awesome.restart },
   
}

mypowermenu = {
   { "logout", function() awesome.quit() end },
   { "reboot", function () awful.spawn.with_shell("systemctl reboot") end },
   { "poweroff", function () awful.spawn.with_shell("systemctl poweroff") end },
   { "lock", function () awful.spawn.with_shell("betterlockscreen -l blur") end },
}

mymiscmenu = {
   { "compositor on", function () awful.spawn.with_shell(comp_bin .. " --config " .. comp_path) end },
   { "compositor off", function () awful.spawn.with_shell("killall " .. comp_bin) end },
   { "compositor conf", editor_cmd .. " " .. comp_path },
   { "network manager", function () awful.spawn.with_shell(network) end },
}

myscreenshotmenu = {
   { "scrnshot full", scrot_full },
   { "scrnshot sel", scrot_selection },
   { "scrnshot win", scrot_window },
   { "scrnshot delay", scrot_delay },
   { "scrncord full", function () awful.spawn.with_shell(record) end },
}

mygamingmenu = {
   { "lutris", function () awful.spawn("lutris") end },
   { "steam", function () awful.spawn("steam") end },
}

mysocialmenu = {
   { "discord", function () awful.spawn("discord") end },
   { "spotify", function () awful.spawn("spotify") end },
}

mymainmenu = freedesktop.menu.build({
            after = { 
                { "awesome", myawesomemenu },
				    { "misc", mymiscmenu },
				    { "screenshot", myscreenshotmenu },
				    { "themes", generateThemeMenu() },
				    { "walls", generateWallMenu() },
				    { "social", mysocialmenu },
				    { "gaming", mygamingmenu },
				    { "run promt", runpromt },
				    { "open terminal", terminal },
				    { "open browser", browser },
				    { "open files", filemanager },
				    { "open vscode", "code" },
				    { "power", mypowermenu }
            },
            sub_menu = "applications"
})

mymiscmenu = {
   { "reload", awesome.restart },
   { "logout", function() awesome.quit() end },
   { "reboot", function () awful.spawn.with_shell("systemctl reboot") end },
   { "poweroff", function () awful.spawn.with_shell("systemctl poweroff") end },
   { "lock", function () awful.spawn.with_shell("betterlockscreen -l blur") end },
}

myrebootmenu = awful.menu({ items = mymiscmenu })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

