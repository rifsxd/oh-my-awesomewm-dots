local awful = require("awful")

local comp_bin = string.format("%s/.config/awesome/misc/compositor/bin/picom", os.getenv("HOME"))

local comp_path = string.format("%s/.config/awesome/config/compositor/picom.conf", os.getenv("HOME"))

function killProcess(processName)
    local _, _, pid = io.popen('pgrep ' .. processName)
    if pid then
        os.execute('killall ' .. processName)
    end
end

local processesToKill = {'picom',
 			 'polkit-gnome-authentication-agent-1',
			 'blazefetch',
 			 'unclutter'
}

for _, process in ipairs(processesToKill) do
    killProcess(process)
end

awful.spawn.with_shell(comp_bin .. " --config " .. comp_path)

awful.spawn.with_shell('/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1')

awful.spawn.with_shell('blazefetch -d')

awful.spawn.with_shell('unclutter --start-hidden')