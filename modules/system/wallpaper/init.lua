local beautiful = require("beautiful")
local gears = require("gears")
local json = require("json")
local awful = require("awful")
local naughty = require("naughty")

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

local blurred = false;


function get_wallpaper(screen)
    if beautiful.wallpaper then
        -- Get the wallpaper value, which could be a string or a function
        local wallpaper = beautiful.wallpaper

        -- If it's a function, evaluate it to get the actual wallpaper path
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end

        -- Construct the paths for regular and blurred wallpapers
        wallpaper_path = string.format("%s/.config/awesome/walls/%s.png", os.getenv("HOME"), chosen_wall)
        blurred_wallpaper_path = string.format("%s/.config/awesome/walls/blur/%s_blurred.png", os.getenv("HOME"), chosen_wall)

        -- Check if the blurred wallpaper doesn't exist, then create it
        if not gears.filesystem.file_readable(blurred_wallpaper_path) then
            os.execute("convert " .. wallpaper_path .. " -blur 0x8 " .. blurred_wallpaper_path)

            -- Schedule a timer to send a notification after 2 seconds
            gears.timer.start_new(1, function()
                naughty.notify({ text = "New blurred wallpaper created!", timeout = 4 })
                
            end)
        end

        global_wallpaper_path = wallpaper_path
    end
end

local function init_wall(screen)
    get_wallpaper()
    gears.wallpaper.maximized(wallpaper_path, screen, true)
end

init_wall()

local function unblur(screen)

    get_wallpaper()
    
    if blurred then
        gears.wallpaper.maximized(wallpaper_path, screen, true)
        blurred = false
    end
    
end

local function blur(screen)

    get_wallpaper()

    if not blurred then
            gears.wallpaper.maximized(blurred_wallpaper_path, screen, true)
            blurred = true
    end
end

-- blur / unblur on tag change
tag.connect_signal('property::selected', function(t)
    -- if tag has clients
    for _ in pairs(t:clients()) do
       blur()
       return
    end
    -- if tag has no clients
    unblur()
 end)
 
 -- check if wallpaper should be blurred on client open
 client.connect_signal("manage", function(c)
    blur()
 end)
 
 -- check if wallpaper should be unblurred on client close
 client.connect_signal("unmanage", function(c)
    local t = awful.screen.focused().selected_tag
    -- check if any open clients
    for _ in pairs(t:clients()) do
       return
    end
    -- unblur if no open clients
    unblur()
 end)
