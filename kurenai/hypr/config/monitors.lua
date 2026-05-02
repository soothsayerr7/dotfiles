hl.monitor({
  output = 'DP-1',
  mode = '2560x1440@164.96',
  position = '1440x920',
  scale = 1,
})

hl.monitor({
  output = 'DP-2',
  mode = '2560x1440@164.96',
  position = '0x0',
  scale = 1,
  transform = 1,
})

local wr = hl.workspace_rule

for i = 1, 9 do
  local wsh = tostring(i)
  local wsv = tostring(i + 10)

  wr({ workspace = wsh, default_name = 'H' .. tostring(i), monitor = 'DP-1', default = (i == 1) })
  wr({ workspace = wsv, default_name = 'V' .. tostring(i), monitor = 'DP-2', default = (i == 1) })
end

wr({ workspace = 'r[11-19]', layout_opts = { direction = 'down' } })
