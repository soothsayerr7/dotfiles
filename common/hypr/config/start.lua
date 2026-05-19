local exec = hl.exec_cmd

local function exec_script(script, ...)
  local args = { ... }

  local quoted_args = {}
  for i, v in ipairs(args) do
    quoted_args[i] = '"' .. tostring(v) .. '"'
  end

  local args_string = #args > 0 and (' ' .. table.concat(quoted_args, ' ')) or ''

  exec(vars.hypr_dir .. 'scripts/' .. script .. args_string)
end

hl.on('hyprland.start', function () 
  exec('noctalia')

  exec_script('gtk.sh', vars.font, vars.font_mono, vars.font_size, vars.terminal)
  exec_script('default-applications.sh')

  if vars.hostname == 'kurenai' then
    exec('openrgb --profile "off"')
  end
end)
