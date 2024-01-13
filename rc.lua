pcall(require, "luarocks.loader")

local home_dir = os.getenv("HOME")

package.path = package.path .. ";" .. home_dir .. "/.config/awesome/modules/?.lua;" .. home_dir .. "/.config/awesome/modules/?/init.lua"

require("system.autostart")
require("system.base")
require("system.error")
require("system.keybind")
require("system.layout")
require("system.menu")
require("system.notify")
require("system.panel")
require("system.scrhpad")
require("system.taskmgr")
require("system.theming")
require("system.titlebar")
require("system.wallpaper")
require("system.winswitch")
