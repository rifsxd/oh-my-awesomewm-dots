local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local json = require("json")

config_file_path = string.format("%s/.config/awesome/config/theme/config.json", os.getenv("HOME"))

config_file = io.open(config_file_path, "r")

if config_file then
    local config_content = config_file:read("*all")
    config_file:close()

    local config_data = json.decode(config_content)

    if config_data and config_data.chosen_theme then
        chosen_theme = config_data.chosen_theme
    else
        print("Error: Invalid or missing chosen_theme value in config file")
    end
else
    print("Error: Config file not found")
end

function reloadAwesomeWM()
    awesome.restart()
end

function updateChosenTheme(default)
    local config_file_path = string.format("%s/.config/awesome/config/theme/config.json", os.getenv("HOME"))

    local config_file = io.open(config_file_path, "r+")

    if config_file then
        local config_content = config_file:read("*all")
        config_file:close()

        local config_data = json.decode(config_content)

        if config_data then
            config_data.chosen_theme = default

            config_file = io.open(config_file_path, "w")
            config_file:write(json.encode(config_data))
            config_file:close()

            print("Chosen theme updated successfully.")
            reloadAwesomeWM()  -- Reload AwesomeWM after changing the theme
        else
            print("Error: Unable to decode config file.")
        end
    else
        print("Error: Config file not found")
    end
end

function getAvailableThemes()
    local theme_path = string.format("%s/.config/awesome/themes/", os.getenv("HOME"))
    local themes = {}

    local dir = io.popen('ls "' .. theme_path .. '"')
    for theme in dir:lines() do
        table.insert(themes, theme)
    end

    return themes
end

function generateThemeMenu()
    local themes = getAvailableThemes()
    local themeMenu = {}

    for _, theme in ipairs(themes) do
        table.insert(themeMenu, { theme, function() updateChosenTheme(theme) end })
    end

    return themeMenu
end

theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)