package.loaded.net_widgets = nil

local net_widgets = {
    indicator   = require("widgets/net.indicator"),
    wireless    = require("widgets/net.wireless"),
    internet    = require("widgets/net.internet")
}

return net_widgets
