local beautiful = require("beautiful")
local gears = require("gears")
local json = require("json")

config_file_path = string.format("%s/.config/awesome/misc/theming/config.json", os.getenv("HOME"))

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
    local config_file_path = string.format("%s/.config/awesome/misc/theming/config.json", os.getenv("HOME"))

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



function set_wallpaper(s)

    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(string.format("%s/.config/awesome/walls/%s.png", os.getenv("HOME"), chosen_wall), s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

set_wallpaper(s)