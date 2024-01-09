local awful = require("awful")

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

awful.spawn.with_shell('picom --config ~/.config/awesome/config/compositor/picom.conf')

awful.spawn.with_shell('/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1')

awful.spawn.with_shell('blazefetch -d')

awful.spawn.with_shell('unclutter --start-hidden')