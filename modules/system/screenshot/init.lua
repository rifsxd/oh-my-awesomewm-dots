local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local timestamp = os.date("%F_%T")
local screenshot_path = os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"

function scrot_full()
    
    local cmd = "scrot " .. screenshot_path
    
    awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
        if stderr and stderr ~= "" then
            naughty.notify({
                text = "Error: " .. stderr,
                timeout = 2.0
            })
        else
            naughty.notify({
                text = "Took a screenshot of the entire screen",
                timeout = 2.0
            })
        end
    end)
end

function scrot_window()
    
    local cmd = "scrot -u " .. screenshot_path

    awful.spawn.easy_async_with_shell(cmd, function(_, stderr, _, _)
        if stderr and stderr ~= "" then
            naughty.notify({
                text = "Error: " .. stderr,
                timeout = 2.0
            })
        else
            naughty.notify({
                text = "Took a screenshot of the focused window",
                timeout = 2.0
            })
        end
    end)
end

function scrot_selection()

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
                    naughty.notify({
                        text = "Took a screenshot of the selection",
                        timeout = 2.0
                    })
                end
            end)
        end
    }
end

function scrot_delay()
    
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
                                naughty.notify({
                                    text = "Took a screenshot with " .. delay .. " seconds delay",
                                    timeout = 2.0
                                })
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