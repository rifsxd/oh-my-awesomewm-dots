local naughty = require("naughty")
local wibox      = require("wibox")

naughty.config.defaults['icon_size'] = 100

naughty.config.defaults['bg'] = "beautiful.bg_normal"

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n,
        position = "top_right",
        widget_template = {
            {
                {
                    naughty.widget.icon,
                    widget = wibox.container.background,
                },
                layout = wibox.layout.align.vertical,
            },
            {
                {
                    {
                        markup = n.title,
                        widget = naughty.widget.title,
                    },
                    {
                        markup = n.message,
                        widget = naughty.widget.message,
                    },
                    layout = wibox.layout.align.vertical,
                },
                margins = 5,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.align.vertical,
        }
        
    }
end)

