local wezterm = require 'wezterm'

return {
  font = wezterm.font( 'JetBrainsMono Nerd Font', { weight = 'Regular', italic = false })
,
  font_size = 10.0,

  use_fancy_tab_bar = false,
  window_background_opacity = 1.0,
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 500,
  window_close_confirmation = 'NeverPrompt',
  scrollback_lines = 3500,
  window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
  },
  front_end = "OpenGL",
  max_fps = 75,
  animation_fps = 75,
  colors = {
      foreground = '#CCC4FF',
      background = '#1E1E2E',
      cursor_bg = '#CCC4FF',
      cursor_fg = '#0a0013',
      cursor_border = '#DFAFFF',
    ansi = {
    	'#111111',
    	'#ff5c5c',
    	'#88ff78',
    	'#fffa78',
    	'#7aa2ff',
    	'#cc80ff',
    	'#9cfffc',
    	'#ffffff',
  	},
  	brights = {
    	'#3b3b3b',
    	'#ff8e8e',
    	'#b6ffac',
    	'#fffca7',
    	'#a9c3ff',
    	'#dfafff',
    	'#befffd',
    	'#e7e7e7',
  	},

    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = '#CCC4FF',

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = '#DFAFFF',
        -- The color of the text for the tab
        fg_color = '#0a0013',

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = 'Normal',

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = 'None',

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = true,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = '#CCC4FF',
        fg_color = '#0a0013',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = '#0a0013',
        fg_color = '#CCC4FF',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = '#CCC4FF',
        fg_color = '#0a0013',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = '#0a0013',
        fg_color = '#CCC4FF',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },
  },
}