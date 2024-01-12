local beautiful = require("beautiful")
local gears = require("gears")
local json = require("json")
local surface = require("gears.surface")
local awful = require("awful")

config_file_path = string.format("%s/.config/awesome/config/theme/config.json", os.getenv("HOME"))

config_file = io.open(config_file_path, "r")

if config_file then
    local config_content = config_file:read("*all")
    config_file:close()

    local config_data = json.decode(config_content)

    if config_data and config_data.chosen_wall then
        chosen_wall = config_data.chosen_wall
    else
        print("Error: Invalid or missing chosen_wall value in config file")
    end
else
    print("Error: Config file not found")
end

function reloadAwesomeWM()
    awesome.restart()
end

function updateChosenWall(default)
    local config_file_path = string.format("%s/.config/awesome/config/theme/config.json", os.getenv("HOME"))

    local config_file = io.open(config_file_path, "r+")

    if config_file then
        local config_content = config_file:read("*all")
        config_file:close()

        local config_data = json.decode(config_content)

        if config_data then
            config_data.chosen_wall = default

            config_file = io.open(config_file_path, "w")
            config_file:write(json.encode(config_data))
            config_file:close()

            print("Chosen wall updated successfully.")
            reloadAwesomeWM()  -- Reload AwesomeWM after changing the wall
        else
            print("Error: Unable to decode config file.")
        end
    else
        print("Error: Config file not found")
    end
end

function getAvailableWalls()
    local wall_path = string.format("%s/.config/awesome/walls/", os.getenv("HOME"))
    local walls = {}

    local dir = io.popen('ls "' .. wall_path .. '"')
    for wall in dir:lines() do
        if wall:match("%.png$") then
            -- Remove the ".png" extension and add to the walls table
            local wallName = wall:gsub("%.png$", "")
            table.insert(walls, wallName)
        end
    end

    return walls
end


function generateWallMenu()
    local walls = getAvailableWalls()
    local wallMenu = {}

    for _, wall in ipairs(walls) do
        table.insert(wallMenu, { wall, function() updateChosenWall(wall) end })
    end

    return wallMenu
end

local naughty = require("naughty")

function set_wallpaper(screen)
    -- Check if a wallpaper is defined in the Beautiful theme
    if beautiful.wallpaper then
        -- Get the wallpaper value, which could be a string or a function
        local wallpaper = beautiful.wallpaper

        -- If it's a function, evaluate it to get the actual wallpaper path
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end

        -- Construct the paths for regular and blurred wallpapers
        local wallpaper_path = string.format("%s/.config/awesome/walls/%s.png", os.getenv("HOME"), chosen_wall)
        local blurred_wallpaper_path = string.format("%s/.config/awesome/walls/blur/%s_blurred.png", os.getenv("HOME"), chosen_wall)

        -- Check if the blurred wallpaper doesn't exist, then create it
        if not gears.filesystem.file_readable(blurred_wallpaper_path) then
            os.execute("convert " .. wallpaper_path .. " -blur 0x8 " .. blurred_wallpaper_path)

            -- Schedule a timer to send a notification after 2 seconds
            gears.timer.start_new(1, function()
                naughty.notify({ text = "New blurred wallpaper created!", timeout = 4 })
                
            end)
        end

        -- Check if the screen has clients (apps) open
        if screen and screen.selected_tag and #screen.selected_tag:clients() > 0 then
            -- Use the pre-generated blurred wallpaper if clients are present
            gears.wallpaper.maximized(blurred_wallpaper_path, screen, true)
        else
            -- No clients in the screen, use the regular wallpaper
            gears.wallpaper.maximized(wallpaper_path, screen, true)
        end
    end
end

-- Automatically apply wallpaper changes when the selected tag changes
tag.connect_signal('property::selected', function(t)
    set_wallpaper(t.screen)  -- Set wallpaper based on the screen associated with the selected tag
end)

-- Handle wallpaper adjustments when a new client (application window) is opened
client.connect_signal("manage", function(c)
    set_wallpaper(c.screen)  -- Set wallpaper based on the screen associated with the new client
end)

-- Handle wallpaper adjustments when a client (application window) is closed
client.connect_signal("unmanage", function(c)
    set_wallpaper(c.screen)  -- Set wallpaper based on the screen associated with the closed client
end)

-- this function gets the wallpaper from the theme.lua
--function set_wallpaper(s)

--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper

--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
--end

screen.connect_signal("property::geometry", set_wallpaper)

set_wallpaper(s)