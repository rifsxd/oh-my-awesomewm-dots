local awful = require("awful")
local naughty = require("naughty")

screenshot = os.getenv("HOME") .. "/Pictures/screenshots/$(date +%F_%T).png"

function scrot_full()
    scrot("scrot " .. screenshot .. " -e 'xclip -selection c -t image/png < $f'", "Took a screenshot of the entire screen")
end

function scrot_selection()
    scrot("sleep 0.5 && scrot -s " .. screenshot .. " -e 'xclip -selection c -t image/png < $f'", "Took a screenshot of the selection")
end

function scrot_window()
    scrot("scrot -u " .. screenshot .. " -e 'xclip -selection c -t image/png < $f'", "Took a screenshot of the focused window")
end

function scrot_delay()
    local prompt = "Choose delay (in seconds):"
    awful.prompt.run {
        prompt = prompt,
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = function(input)
            local delay = tonumber(input)
            if delay then
                local timestamp = os.date("%F_%T")
                local cmd = "sleep " .. delay .. " && scrot " .. os.getenv("HOME") .. "/Pictures/screenshots/" .. timestamp .. ".png"
                scrot(cmd, "Took a screenshot with " .. delay .. " seconds delay")
            else
                naughty.notify({
                    text = "Invalid input for delay!",
                    timeout = 2.0
                })
            end
        end
    }
end

function scrot(cmd, args)
    local success, _, _, exit_code = awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            scrot_callback(args)
        else
            naughty.notify({
                text = "Failed to take a screenshot!",
                timeout = 2.0
            })
        end
    end)
end


function scrot_callback(text)
    naughty.notify({
        text = text,
        timeout = 2.0
    })
end