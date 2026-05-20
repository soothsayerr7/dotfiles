if vars.hostname == 'kurenai' then
  hl.monitor({
    output = 'DP-1',
    mode = '2560x1440@164.96',
    position = '1440x865',
    scale = 1,
    icc = vars.hypr_dir .. 'misc/ultragear.icc'
  })

  hl.monitor({
    output = 'DP-2',
    mode = '2560x1440@164.96',
    position = '0x0',
    scale = 1,
    icc = vars.hypr_dir .. 'misc/ultragear.icc',
    transform = 1,
  })

  local wr = hl.workspace_rule

  for i = 1, 9 do
    local wsh = tostring(i)
    local wsv = tostring(i + 10)

    wr({ workspace = wsh, default_name = 'H' .. tostring(i), monitor = 'DP-1', persistent = true, default = (i == 1) })
    wr({ workspace = wsv, default_name = 'V' .. tostring(i), monitor = 'DP-2', persistent = true, default = (i == 1) })
  end

  wr({ workspace = 'r[11-19]', layout_opts = { direction = 'down' } })

  hl.window_rule({ match = { workspace = 'r[11-19]' }, scrolling_width = 0.33333 })

elseif vars.hostname == 'seiryu' then
  hl.monitor({
    output = 'eDP-1',
    mode = '1920x1080@120.015',
    position = '0x0',
    scale = 1.2,
    icc = vars.hypr_dir .. 'misc/ultragear.icc',
  })

  local wr = hl.workspace_rule

  for i = 1, 9 do
    wr({ workspace = tostring(i), default_name = 'H' .. tostring(i), persistent = true, default = (i == 1) })
  end
end
