local vars = require('config/vars')

local scripts_dir = '$HOME/.config/hypr/scripts/'

hl.on('hyprland.start', function () 
  hl.exec_cmd('qs -c noctalia-shell')

  hl.exec_cmd('systemctl --user start hyprpolkitagent')

  hl.exec_cmd(scripts_dir .. 'gtk-setup.sh ' .. vars.terminal)
end)
