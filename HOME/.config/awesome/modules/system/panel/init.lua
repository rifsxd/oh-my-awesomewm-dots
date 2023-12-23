local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local volume_widget = require("volume")
local spotify_widget = require("spotify")
local net_widget = require("net")
require("awful.hotkeys_popup.keys")
local xresources = require("beautiful.xresources")
local screenshot = require("screenshot")
local dpi = xresources.apply_dpi

local function set_wallpaper(s)

    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

mykeyboardlayout = awful.widget.keyboardlayout()

mytextclock = wibox.widget.textclock()

net_wired = net_widget.indicator({
    interfaces  = {"enp5s0"},
    timeout     = 5
})

awful.screen.connect_for_each_screen(function(s)

    set_wallpaper(s)

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

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s, ontop = true })
    s.mynewwibox = awful.wibar({ position = "bottom", screen = s, ontop = true })

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
    s.mynewwibox:setup {
        layout = wibox.layout.align.horizontal,
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
	      s.mytasklist,
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
    }
end)