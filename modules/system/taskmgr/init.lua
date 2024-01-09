local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")
local bling = require("bling")
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")

bling.widget.task_preview.enable {
    x = 20,                    -- The x-coord of the popup
    y = 20,                    -- The y-coord of the popup
    height = dpi(300),              -- The height of the popup
    width = dpi(300),               -- The width of the popup
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.bottom(c, {
            margins = {
                bottom = 30
            }
        })
    end,
    -- Your widget will automatically conform to the given size due to a constraint container.
    widget_structure = {
        {
            {
                {
                    id = 'icon_role',
                    widget = awful.widget.clienticon, -- The client icon
                },
                {
                    id = 'name_role', -- The client name / title
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            margins = 5
        },
        {
            id = 'image_role', -- The client preview
            resize = true,
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.imagebox,
        },
        layout = wibox.layout.fixed.vertical
    }
}

awful.screen.connect_for_each_screen(function(s)

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        style = {
            shape = gears.shape.rectangle,
            bg_normal = beautiful.border_normal,
            bg_focus = beautiful.border_focus,
            bg_minimize = beautiful.bg_normal,
        },
        layout = {
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = dpi(4),
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = dpi(4),
                widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
    
                -- BLING: Toggle the popup on hover and disable it off hover
                self:connect_signal('mouse::enter', function()
                        awesome.emit_signal("bling::task_preview::visibility", s,
                                            true, c)
                    end)
                    self:connect_signal('mouse::leave', function()
                        awesome.emit_signal("bling::task_preview::visibility", s,
                                            false, c)
                    end)
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    s.mynewwibox = awful.wibar({ position = "bottom", screen = s, ontop = true })

    s.mynewwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
	      s.mytasklist,
	      {
	        layout = wibox.layout.fixed.horizontal,
	      },
    }
end)