pcall(require, "luarocks.loader")

package.path = package.path .. ";/home/rifsxd/.config/awesome/modules/?.lua;/home/rifsxd/.config/awesome/modules/?/init.lua;/home/rifsxd/.config/awesome/widgets/?.lua;/home/rifsxd/.config/awesome/widgets/?/init.lua"

require("system.keybind")
require("system.layout")
require("system.theming")
require("system.wallpaper")
require("system.error")
require("system.notify")
require("system.menu")
require("system.panel")
require("system.base")
require("system.autostart")

