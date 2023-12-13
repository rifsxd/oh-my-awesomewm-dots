package.loaded.net_widgets = nil

local net_widgets = {
    indicator   = require("widgets/net-widgets.indicator"),
    wireless    = require("widgets/net-widgets.wireless"),
    internet    = require("widgets/net-widgets.internet")
}

return net_widgets
