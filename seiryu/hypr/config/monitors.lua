hl.monitor({
  output = 'eDP-1',
  mode = '1920x1080@120.015',
  position = '0x0',
  scale = 1.2,
})

local wr = hl.workspace_rule

for i = 1, 9 do
  wr({ workspace = tostring(i), default = (i == 1) })
end
