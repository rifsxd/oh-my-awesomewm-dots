local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    beautiful.titlebar_bg = beautiful.bg_normal
    beautiful.titlebar_fg = beautiful.fg_normal
    beautiful.titlebar_bg_focus = beautiful.bg_focus
    beautiful.titlebar_fg_focus = beautiful.fg_focus

    awful.titlebar(c) : setup {
        {
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {
            {
                align  = "left",
		widget = wibox.container.margin(awful.titlebar.widget.titlewidget(c), dpi(10)),
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
	    awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.maximizedbutton(c),
	    awful.titlebar.widget.minimizebutton (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)