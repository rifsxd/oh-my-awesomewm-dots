local dpi   = require("beautiful.xresources").apply_dpi

local theme                                     = {}

theme.icon_theme = "Gruvbox-Material-Dark"

theme.zenburn_dir                               = require("awful.util").get_themes_dir() .. "zenburn"
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/steamburn"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "Terminus 10.5"
theme.fg_normal                                 = "#e2ccb0"
theme.fg_focus                                  = "#d88166"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#140c0b80"
theme.bg_focus                                  = "#140c0b80"
theme.bg_urgent                                 = "#2a1f1e80"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#302627"
theme.border_focus                              = "#c2745b"
theme.border_marked                             = "#CC9393"
theme.taglist_fg_focus                          = "#d88166"
theme.tasklist_bg_focus                         = "#140c0b"
theme.tasklist_fg_focus                         = "#d88166"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.layout_txt_tile                           = "[t]"
theme.layout_txt_tileleft                       = "[l]"
theme.layout_txt_tilebottom                     = "[b]"
theme.layout_txt_tiletop                        = "[tt]"
theme.layout_txt_fairv                          = "[fv]"
theme.layout_txt_fairh                          = "[fh]"
theme.layout_txt_spiral                         = "[s]"
theme.layout_txt_dwindle                        = "[d]"
theme.layout_txt_max                            = "[m]"
theme.layout_txt_fullscreen                     = "[F]"
theme.layout_txt_magnifier                      = "[M]"
theme.layout_txt_floating                       = "[|]"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_normal              = theme.zenburn_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.zenburn_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.zenburn_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.zenburn_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.zenburn_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.zenburn_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.zenburn_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.zenburn_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.zenburn_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.zenburn_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.zenburn_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.zenburn_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.zenburn_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.zenburn_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.zenburn_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.zenburn_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.zenburn_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.zenburn_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.zenburn_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.zenburn_dir.."/titlebar/maximized_focus_active.png"

-- borders and gaps
theme.useless_gap   = 11
theme.border_width  = 1

theme.wd = "~/.config/awesome/themes/steamburn/"

theme.play_icon = theme.wd .. "icons/play.png"
theme.pause_icon = theme.wd .. "icons/pause.png"
theme.wired = theme.wd .. "icons/wired.png"
theme.wired_na = theme.wd .. "icons/wired_na.png"
theme.vpn = theme.wd .. "icons/vpn.png"
theme.systray_visible_icon = theme.wd .. "icons/systray_visible_icon.png"
theme.systray_hidden_icon = theme.wd .. "icons/systray_hidden_icon.png"

theme.task_preview_widget_border_radius = 0        -- Border radius of the widget (With AA)
theme.task_preview_widget_bg = theme.bg_normal           -- The bg color of the widget
theme.task_preview_widget_border_color = theme.border_focus -- The border color of the widget
theme.task_preview_widget_border_width = dpi(1)        -- The border width of the widget
theme.task_preview_widget_margin = 0

theme.window_switcher_widget_bg = theme.bg_normal             -- The bg color of the widget
theme.window_switcher_widget_border_width = dpi(1)            -- The border width of the widget
theme.window_switcher_widget_border_radius = 0           -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_focus    -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 300                 -- The width of one client widget
theme.window_switcher_client_height = 300                -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200            -- The width of one title
theme.window_switcher_name_font = "JetBrainsMono Nerd Font 10"              -- The font of all titles
theme.window_switcher_name_normal_color = theme.border_normal      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.fg_focus      -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 10  

return theme
