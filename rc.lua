pcall(require, "luarocks.loader")

package.path = package.path .. ";/home/rifsxd/.config/awesome/modules/?.lua;/home/rifsxd/.config/awesome/modules/?/init.lua"

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
require("system.wallpaper")
require("system.winswitch")
