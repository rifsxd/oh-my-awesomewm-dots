package.loaded.net_widgets = nil

local net_widgets = {
    indicator   = require("modules.net.indicator"),
    wireless    = require("modules.net.wireless"),
    internet    = require("modules.net.internet")
}

return net_widgets
