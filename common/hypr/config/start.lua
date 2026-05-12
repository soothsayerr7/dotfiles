local scripts = '$HOME/.config/hypr/scripts/'

hl.on('hyprland.start', function () 
  hl.exec_cmd('noctalia')

  hl.exec_cmd(scripts .. 'gtk-setup.sh ' .. vars.terminal)
end)
