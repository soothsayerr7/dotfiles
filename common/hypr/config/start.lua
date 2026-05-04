local scripts = '$HOME/.config/hypr/scripts/'

hl.on('hyprland.start', function () 
  hl.exec_cmd('qs -c noctalia-shell')

  hl.exec_cmd('systemctl --user start hyprpolkitagent')

  hl.exec_cmd(scripts .. 'gtk-setup.sh ' .. vars.terminal)
end)
