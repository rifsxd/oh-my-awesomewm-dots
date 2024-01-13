local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local screen_width = awful.screen.focused().geometry.width

local systray = wibox.widget.systray()

systray:set_horizontal(true)

local systray_wibox = wibox({
    ontop = true,
    visible = false,
    type = "dropdown_menu",
    height = 40,
    width = 200,
    x = screen_width - 570,
    y = 34,
    bg = gears.color.transparent,
})

local systray_layout = wibox.layout.margin(systray, 10, 10, 10, 10)

systray_wibox:setup {
    layout = wibox.layout.align.horizontal,
        expand = "none",
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
	      systray_layout,
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
}

systray_wibox.visible = false

local systray_visible_icon = beautiful.systray_visible_icon
local systray_hidden_icon = beautiful.systray_hidden_icon

-- Toggle button for showing/hiding the systray wibar
systray_toggle = awful.widget.button({ image = systray_hidden_icon })

systray_toggle:connect_signal("button::press", function()
    systray_wibox.visible = not systray_wibox.visible
    -- Update the button icon based on the visibility state
    systray_toggle.image = systray_wibox.visible and systray_visible_icon or systray_hidden_icon
end)