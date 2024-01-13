local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local volume_widget = require("volume")
local spotify_widget = require("spotify")
local net_widget = require("net")
require("system.systray")

local screen_width = awful.screen.focused().geometry.width
local mytextclock = wibox.widget.textclock(" %a, %b %d, %Y - %I:%M %p ")

local volume = volume_widget({
    font        = 'JetBrainsMono Nerd Font 10',
    widget_type = 'horizontal_bar_text',
})

local spotify = spotify_widget({
    font = 'JetBrainsMono Nerd Font 10',
})

local calendar_widget = wibox.widget {
    date         = os.date('*t'),
    font         = 'JetBrainsMono Nerd Font 10',
    start_sunday = true,
    long_weekdays = true,
    widget       = wibox.widget.calendar.month
}

local calendar_wibox = wibox({
    ontop = true,
    visible = false,
    type = "dropdown_menu",
    height = 190,
    width = 260,
    x = screen_width - 315,
    y = 34,
    bg = gears.color.transparent,
})

local calendar_layout = wibox.layout.margin(calendar_widget, 10, 10, 10, 10)

calendar_wibox:setup {
    nil,
    {
        nil,
        calendar_layout,
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal,
    },
    nil,
    layout = wibox.layout.align.vertical,
}

mytextclock:connect_signal("mouse::enter", function()
    calendar_wibox.visible = true
end)

mytextclock:connect_signal("mouse::leave", function()
    calendar_wibox.visible = false
end)

net_wired = net_widget.indicator({
    interfaces  = {"enp5s0"},
    timeout     = 5
})

awful.screen.connect_for_each_screen(function(s)

    awful.tag({ "一", "二", "三", "四", "五", "六", "七", "八", "九" }, s, awful.layout.suit.tile)

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s, ontop = true, bg = gears.color.transparent })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
	      expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
	          spacing = 10,
        },
	      {
            layout = wibox.layout.fixed.horizontal,
	        spotify,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            systray_toggle,
      	    net_wired,
              volume,
	          mytextclock, 
            s.mylayoutbox,
	          spacing = 10,
        },
    }

end)