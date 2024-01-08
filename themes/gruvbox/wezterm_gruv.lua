local wezterm = require 'wezterm'

return {
  font = wezterm.font( 'JetBrainsMono Nerd Font', { weight = 'Regular', italic = false })
,
  font_size = 10.0,
  color_scheme = 'Gruvbox Material (Gogh)',
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
      foreground = '#EBDBB2',
      cursor_bg = '#EBDBB2',
      cursor_fg = '#000000',
      cursor_border = '#EBDBB2',
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = '#282828',

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = '#EBDBB2',
        -- The color of the text for the tab
        fg_color = '#282828',

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
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = '#282828',
        fg_color = '#EBDBB2',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = '#EBDBB2',
        fg_color = '#282828',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = '#282828',
        fg_color = '#EBDBB2',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = '#EBDBB2',
        fg_color = '#282828',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },
  },
}