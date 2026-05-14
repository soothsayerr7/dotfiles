local function exec_script(script, ...)
  local args = { ... }

  local quoted_args = {}
  for i, v in ipairs(args) do
    quoted_args[i] = '"' .. tostring(v) .. '"'
  end

  local args_string = #args > 0 and (' ' .. table.concat(quoted_args, ' ')) or ''

  hl.exec_cmd(vars.hypr_dir .. 'scripts/' .. script .. args_string)
end

hl.on('hyprland.start', function () 
  hl.exec_cmd('noctalia')

  exec_script('gtk.sh', vars.font, vars.font_mono, vars.font_size, vars.terminal)
  exec_script('default-applications.sh')
end)
