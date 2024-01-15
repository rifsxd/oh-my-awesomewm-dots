local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local function copy_to_clipboard(image_path)
    local cmd = "xclip -selection clipboard -t image/png -i " .. image_path
    awful.spawn.easy_async_with_shell(cmd)
end


local function create_screenshots_directory()
    local screenshots_path = os.getenv("HOME") .. "/Pictures/screenshots"
    awful.util.mkdir(screenshots_path)
end

function scrot_full()

    create_screenshots_directory()

    local unique_id = tostring(math.random(1000))
    local timestamp = os.date("%F_%T") .. ("_") .. unique_id
    local screenshot_path = os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"
    
    local cmd = "scrot " .. screenshot_path
    
    awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
        if stderr and stderr ~= "" then
            naughty.notify({
                text = "Error: " .. stderr,
                timeout = 2.0
            })
        else

            local screenshot_image = gears.surface.load(screenshot_path)

            local preview_width = 200

            naughty.notify({
                text = "Took a screenshot of the entire screen",
                timeout = 2.0,
                icon = screenshot_image,
                icon_size = preview_width
            })

            copy_to_clipboard(screenshot_path)
        end
    end)
end


function scrot_window()

    create_screenshots_directory()

    local unique_id = tostring(math.random(1000))
    local timestamp = os.date("%F_%T") .. ("_") .. unique_id
    local screenshot_path = os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"
    
    local cmd = "scrot -u " .. screenshot_path

    awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
        if stderr and stderr ~= "" then
            naughty.notify({
                text = "Error: " .. stderr,
                timeout = 2.0
            })
        else

            local screenshot_image = gears.surface.load(screenshot_path)

            local preview_width = 200

            naughty.notify({
                text = "Took a screenshot of the focused window",
                timeout = 2.0,
                icon = screenshot_image,
                icon_size = preview_width
            })

            copy_to_clipboard(screenshot_path)
        end
    end)
end

function scrot_selection()

    create_screenshots_directory()

    local unique_id = tostring(math.random(1000))
    local timestamp = os.date("%F_%T") .. ("_") .. unique_id
    local screenshot_path = os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"

    local delay = 0.5
    local timer = gears.timer {
        timeout = delay,
        autostart = true,
        single_shot = true,
        callback = function()
            local cmd = "scrot -s " .. screenshot_path
            
            awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
                if stderr and stderr ~= "" then
                    naughty.notify({
                        text = "Error: " .. stderr,
                        timeout = 2.0
                    })
                else

                    local screenshot_image = gears.surface.load(screenshot_path)

                    local preview_width = 200

                    naughty.notify({
                        text = "Took a screenshot of the selection",
                        timeout = 2.0,
                        icon = screenshot_image,
                        icon_size = preview_width
                    })

                    copy_to_clipboard(screenshot_path)
                end
            end)
        end
    }
end

function scrot_delay()

    create_screenshots_directory()

    local unique_id = tostring(math.random(1000))
    local timestamp = os.date("%F_%T") .. ("_") .. unique_id
    local screenshot_path = os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"
    
    local prompt = "Choose delay (in seconds):"
    awful.prompt.run {
        prompt = prompt,
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = function(input)
            local delay = tonumber(input)
            if delay then
                local timer = gears.timer {
                    timeout = delay,
                    autostart = true,
                    single_shot = true,
                    callback = function()
                        local cmd = "scrot " .. screenshot_path
                        awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
                            if stderr and stderr ~= "" then
                                naughty.notify({
                                    text = "Error: " .. stderr,
                                    timeout = 2.0
                                })
                            else

                                local screenshot_image = gears.surface.load(screenshot_path)

                                local preview_width = 200

                                naughty.notify({
                                    text = "Took a screenshot with " .. delay .. " seconds delay",
                                    timeout = 2.0,
                                    icon = screenshot_image,
                                    icon_size = preview_width
                                })

                                copy_to_clipboard(screenshot_path)
                            end
                        end)
                    end
                }
            else
                naughty.notify({
                    text = "Invalid input for delay!",
                    timeout = 2.0
                })
            end
        end
    }
end