local awful = require("awful")
require("system.alphavar")

function killProcess(processName)
    os.execute('killall ' .. processName)
end

local processesToKill = { 'picom',
                          'picom_fluid',
                          'compfy',
                          'polkit-gnome-authentication-agent-1',
                          'blazefetch',
                          'unclutter'
}

for _, process in ipairs(processesToKill) do
    killProcess(process)
end

function autostart(commands)
    for _, command in ipairs(commands) do
        awful.spawn.with_shell(command)
    end
end

local autostartArray = {

    comp_bin .. " --config " .. comp_path,
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
    'blazefetch -d',
    'unclutter --start-hidden',

}

autostart(autostartArray)