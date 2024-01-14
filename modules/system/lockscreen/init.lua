local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')

local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()

package.cpath = package.cpath .. ";" .. config_dir .. "modules/system/lockscreen/library/?.so;"
local pam = require('liblua_pam')

local dpi = beautiful.xresources.apply_dpi

local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'modules/system/lockscreen/'

-- Configuration

beautiful.background = '#00000066'
beautiful.fg_normal = '#EBDBB2EE'
beautiful.transparent = '#00000000'
beautiful.system_red_dark = '#EA6962'
beautiful.system_green_dark = '#89B482'
beautiful.system_yellow_dark = '#D8A657'
beautiful.system_blue_dark = '#7DAEA3'

-- Useful variables (DO NOT TOUCH)

local input_password = nil
local lock_again = nil
local type_again = true

-- Process

local locker = function(s)

	local lockscreen = wibox {
		visible = false,
		ontop = true,
		type = "splash",
		width = s.geometry.width,
		height = s.geometry.height,
		bg = beautiful.background,
		fg = beautiful.fg_normal,
	}

	local uname_text = wibox.widget {
		id = 'uname_text',
		markup = '$USER',
		font = 'JetBrainsMono Nerd Font Bold 17',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local uname_text_shadow = wibox.widget {
		id = 'uname_text_shadow',
		markup = '<span foreground="#00000066">' .. '$USER' .. "</span>",
		font = 'JetBrainsMono Nerd Font Bold 17',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local caps_text = wibox.widget {
		id = 'uname_text',
		markup = 'Caps Lock is off',
		font = 'JetBrainsMono Nerd Font Italic 10',
		align = 'center',
		valign = 'center',
		opacity = 0.0,
		widget = wibox.widget.textbox
	}
	local caps_text_shadow = wibox.widget {
		id = 'uname_text',
		markup = '<span foreground="#00000066">' .. 'Caps Lock is off' .. "</span>",
		font = 'JetBrainsMono Nerd Font Italic 10',
		align = 'center',
		valign = 'center',
		opacity = 0.0,
		widget = wibox.widget.textbox
	}

	-- Update username textbox
	awful.spawn.easy_async('whoami | tr -d "\\n"', function(stdout) 
		uname_text.markup = stdout
		uname_text_shadow.markup = '<span foreground="#00000066">' .. stdout .. "</span>"
	end)


	local profile_imagebox = wibox.widget {
		id = 'user_icon',
		image = widget_icon_dir .. (gears.filesystem.file_readable(widget_icon_dir .. 'user.png') and 'user.png' or 'user.svg'),
		forced_height = dpi(100),
		forced_width = dpi(100),
		clip_shape = gears.shape.circle,
		widget = wibox.widget.imagebox,
		resize = true
	}

	local time = wibox.widget.textclock(
		'<span font="JetBrainsMono Nerd Font Bold 56">%H:%M</span>',
		1
	)

	local time_shadow = wibox.widget.textclock(
		'<span foreground="#00000066" font="JetBrainsMono Nerd Font Bold 56">%H:%M</span>',
		1
	)

	local date_value = function()
		local date_val = {}
		local ordinal = nil

		local day = os.date('%d')
		local month = os.date('%B')

		local first_digit = string.sub(day, 0, 1) 
		local last_digit = string.sub(day, -1) 

		if first_digit == '0' then
		  day = last_digit
		end

		if last_digit == '1' and day ~= '11' then
		  ordinal = 'st'
		elseif last_digit == '2' and day ~= '12' then
		  ordinal = 'nd'
		elseif last_digit == '3' and day ~= '13' then
		  ordinal = 'rd'
		else
		  ordinal = 'th'
		end

		date_val.day = day
		date_val.month = month
		date_val.ordinal= ordinal

		return date_val
	end


	local date = wibox.widget {
		markup = date_value().day .. date_value().ordinal .. ' of ' .. date_value().month,
		font = 'JetBrainsMono Nerd Font Bold 20',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local date_shadow = wibox.widget {
		markup = "<span foreground='#00000066'>" .. date_value().day .. date_value().ordinal .. " of " .. 
			date_value().month .. "</span>",
		font = 'JetBrainsMono Nerd Font Bold 20',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local circle_container = wibox.widget {
		bg = '#f2f2f233',
	    forced_width = dpi(110),
	    forced_height = dpi(110),
	    shape = gears.shape.circle,
	    widget = wibox.container.background
	}

	local locker_arc = wibox.widget {
	    bg = beautiful.transparent,
	    forced_width = dpi(110),
	    forced_height = dpi(110),
	    shape = function(cr, width, height)
	        gears.shape.arc(cr, width, height, dpi(5), 0, math.pi/2, true, true)
	    end,
	    widget = wibox.container.background
	}

	-- Check Capslock state
	check_caps = function()
		awful.spawn.easy_async(config_dir .. 'modules/system/lockscreen/binary/capschecker', function(stdout)
			
			status = stdout:gsub('%\n','')

			if status:match('on') then
				caps_text.opacity = 1.0
				caps_text_shadow.opacity = 1.0

				caps_text:set_markup('Caps Lock is on')
				caps_text_shadow:set_markup('<span foreground="#00000066">' .. 'Caps Lock is on' .. "</span>")
			else
				caps_text.opacity = 0.0
				caps_text_shadow.opacity = 0.0
			end

			caps_text:emit_signal('widget::redraw_needed')
			caps_text_shadow:emit_signal('widget::redraw_needed')
		end)
	end

	local rotate_container = wibox.container.rotate()

	local locker_widget = wibox.widget {
		{
		    locker_arc,
		    widget = rotate_container
		},
		layout = wibox.layout.fixed.vertical
	}

	-- Rotation direction table
	local rotation_direction = {"north", "west", "south", "east"}

	-- Red, Green, Yellow, Blue
	local red = beautiful.system_red_dark
	local green = beautiful.system_green_dark
	local yellow = beautiful.system_yellow_dark
	local blue = beautiful.system_blue_dark
	
	-- Color table
	local arc_color = {red, green, yellow, blue}


	local locker_widget_rotate = function()

		local direction = rotation_direction[math.random(#rotation_direction)]
		local color = arc_color[math.random(#arc_color)]

		rotate_container.direction = direction

		locker_arc.bg = color

		rotate_container:emit_signal("widget:redraw_needed")
		locker_arc:emit_signal("widget::redraw_needed")
		locker_widget:emit_signal("widget::redraw_needed")

	end

	function logIntruderDetection()
		-- Get current date and time
		local currentDate = os.date("%Y-%m-%d")
		local currentTime = os.date("%H:%M:%S")
		
		-- Compose log entry
		local logEntry = "Intruder detected @ " .. currentDate .. " " .. currentTime
		
		-- Specify the log file path
		local logFolderPath = os.getenv("HOME") .. "/Documents/Intrusion"
		local logFileName = logFolderPath .. "/intruder_log.txt"
	
		-- Create the folder if it doesn't exist
		os.execute("mkdir -p " .. logFolderPath)
	
		-- Open the log file in append mode
		local file = io.open(logFileName, "a")
	
		if file then
			-- Write the log entry and close the file
			file:write(logEntry .. "\n")
			file:close()
		else
		end

		circle_container.bg = red .. 'AA'

		gears.timer.start_new(1, function()
	 			circle_container.bg = beautiful.groups_title_bg
	 			type_again = true
	 	end)
		
	end


	local generalkenobi_ohhellothere = function()
		
		circle_container.bg = green .. 'AA'

		-- Add a little delay before unlocking completely
		gears.timer.start_new(1, function()

			-- Hide all the lockscreen on all screen
			for s in screen do
				if s.index == 1 then
					s.lockscreen.visible = false
				else
					s.lockscreen_extended.visible = false
				end
			end

			circle_container.bg = beautiful.groups_title_bg
			
			-- Enable locking again
			lock_again = true

			-- Enable validation again
			type_again = true

		end)

	end

	-- A backdoor
	local back_door = function()
		generalkenobi_ohhellothere()
	end

	local password_grabber = awful.keygrabber {
		auto_start          = true,
		stop_event          = 'release',
		mask_event_callback = true,
	    keybindings = {
	        awful.key {
	            modifiers = {'Control'},
	            key       = 'u',
	            on_press  = function() 
	            	input_password = nil

	            end
	        },
	        awful.key {
	            modifiers = {'Mod1', 'Mod4', 'Shift', 'Control'},
	            key       = 'Return',
	            on_press  = function(self) 
	            	self:stop()
	            	back_door() 
	        	end
	        }
	    },
		keypressed_callback = function(self, mod, key, command) 

			if not type_again then
				return
			end

			-- Clear input string
			if key == 'Escape' then
				-- Clear input threshold
				input_password = nil
			end

			-- Accept only the single charactered key
			-- Ignore 'Shift', 'Control', 'Return', 'F1', 'F2', etc., etc
			if #key == 1 then
				
				locker_widget_rotate()

				if input_password == nil then
					input_password = key
					return
				end
				
				input_password = input_password .. key
			end

		end,
		keyreleased_callback = function(self, mod, key, command)
			locker_arc.bg = beautiful.transparent
			locker_arc:emit_signal('widget::redraw_needed')

			if key == 'Caps_Lock' then
				check_caps()
			end

			if not type_again then
				return
			end

			-- Validation
			if key == 'Return' then

				type_again = false

				-- Validate password
				local pam_auth = pam:auth_current_user(input_password)
				if pam_auth then
					-- Come in!
					self:stop()
					generalkenobi_ohhellothere()
				else
					-- F*ck off, you [REDACTED]!
					logIntruderDetection()
				end

				input_password = nil
			end
		
		end

	}


	lockscreen : setup {
		layout = wibox.layout.align.vertical,
		expand = 'none',
		nil,
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			nil,
			{
				layout = wibox.layout.fixed.vertical,
				expand = 'none',
				spacing = dpi(20),
				{
					{
						layout = wibox.layout.align.horizontal,
						expand = 'none',
						nil,
						{
							time_shadow,
							time,
							vertical_offset = dpi(-1),
							widget = wibox.layout.stack
						},
						nil

					},
					{
						layout = wibox.layout.align.horizontal,
						expand = 'none',
						nil,
						{
							date_shadow,
							date,
							vertical_offset = dpi(-1),
							widget = wibox.layout.stack
						},
						nil

					},
					expand = 'none',
					layout = wibox.layout.fixed.vertical
				},
				{
					layout = wibox.layout.fixed.vertical,
					{
						circle_container,
						locker_widget,
						{
							layout = wibox.layout.align.vertical,
							expand = 'none',
							nil,
							{
								layout = wibox.layout.align.horizontal,
								expand = 'none',
								nil,
								profile_imagebox,
								nil
							},
							nil,
						},
						layout = wibox.layout.stack
					},
					{
						uname_text_shadow,
						uname_text,
						vertical_offset = dpi(-1),
						widget = wibox.layout.stack
					},
					{
						caps_text_shadow,
						caps_text,
						vertical_offset = dpi(-1),
						widget = wibox.layout.stack
					}
				},
			},
			nil
		},
		nil
	}

	show_lockscreen = function()

		-- Why is there a lock_again variable?
		-- Well, it fixes a bug.
		-- What is the bug? 
		-- It's a secret.

		if lock_again == true or lock_again == nil then		

			-- Check capslock status
			check_caps()

			-- Show all the lockscreen on each screen
			for s in screen do
				if s.index == 1 then
					s.lockscreen.visible = true
				else
					s.lockscreen_extended.visible = true
				end
			end

			-- Start key grabbing for password
			password_grabber:start()

			-- Dont lock again
			lock_again = false

		end

	end

	return lockscreen

end


-- This lockscreen is for the extra/multi monitor
local locker_ext = function(s)
	local extended_lockscreen = wibox {
		visible = false,
		ontop = true,
		ontype = 'true',
		x = s.geometry.x,
		y = s.geometry.y,
		width = s.geometry.width,
		height = s.geometry.height,
		bg = beautiful.background,
		fg = beautiful.fg_normal
	}

	return extended_lockscreen
end


-- Create a lockscreen for each screen
screen.connect_signal("request::desktop_decoration", function(s)

	if s.index == 1 then
		s.lockscreen = locker(s)
	else
		s.lockscreen_extended = locker_ext(s)
	end

end)

-- Dont show notification popups if the screen is locked
naughty.connect_signal("request::display", function(_)
	focused = awful.screen.focused()
	if (focused.lockscreen and focused.lockscreen.visible) or 
		(focused.lockscreen_extended and focused.lockscreen_extended.visible) then
		naughty.destroy_all_notifications()
	end
end)