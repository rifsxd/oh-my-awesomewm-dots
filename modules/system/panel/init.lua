local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")
local volume_widget = require("volume")
local spotify_widget = require("spotify")
local net_widget = require("net")


mytextclock = wibox.widget.textclock(" %a, %b %d, %Y - %I:%M %p ")

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

    s.mywibox = awful.wibar({ position = "top", screen = s, ontop = true })

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
	          spotify_widget({
               font = 'JetBrainsMono Nerd Font 10',
            }),
        },
        {
            layout = wibox.layout.fixed.horizontal,
	          wibox.widget.systray(),
      	    net_wired,
            volume_widget{
              widget_type = 'horizontal_bar'
	          },
	          mytextclock, 
            s.mylayoutbox,
	          spacing = 10,
        },
    }

end)