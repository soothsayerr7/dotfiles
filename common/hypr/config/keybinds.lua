-- VARIABLES
local b  = hl.bind

local d   = hl.dsp
local dw  = hl.dsp.window
local dg  = hl.dsp.group
local dws = hl.dsp.workspace

local SU = 'SUPER + '
local SS = 'SUPER + SHIFT + '
local SC = 'SUPER + CTRL + '
local SA = 'SUPER + ALT + '
local SX = 'SUPER + SHIFT + CTRL + '
local SY = 'SUPER + CTRL + ALT +'

local flags = {
  e  = { repeating = true },
  l  = { locked = true },
  el = { repeating = true, locked = true},
  m  = { mouse = true },
}

local function exec_script(script)
  return d.exec_cmd('$HOME/.config/hypr/scripts/' .. script)
end

-- NOCTALIA
local function noctalia(cmd)
  return d.exec_cmd('qs -c noctalia-shell ipc call ' .. cmd)
end

b(SU .. 'Space', d.exec_cmd('hyprlauncher'))
b(SU .. 'V',     noctalia('launcher clipboard'))

b(SU .. 'B', noctalia('bar toggle'))

b(SS .. 'Q', noctalia('sessionMenu toggle'))

b('XF86AudioRaiseVolume', noctalia('volume increase'),   flags.el)
b('XF86AudioLowerVolume', noctalia('volume decrease'),   flags.el)
b('XF86AudioMute',        noctalia('volume muteOutput'), flags.l)

b('XF86MonBrightnessUp',   noctalia('brightness increase'), flags.el)
b('XF86MonBrightnessDown', noctalia('brightness decrease'), flags.el)

-- PROGRAMS
b(SU .. 'T', d.exec_cmd(vars.terminal))
b(SU .. 'W', d.exec_cmd(vars.browser))
b(SU .. 'E', d.exec_cmd(vars.file_manager))

-- GENERAL
b(SU .. 'Q', dw.close())
--
b(SU .. 'A', dw.float({ action = 'toggle' }))
b(SS .. 'A', dw.pin())

b(SU .. 'X', dw.cycle_next())

b(SU .. 'F', d.layout('colresize 1.0'))
b(SS .. 'F', exec_script('hypr-fullscreen-toggle.sh'))

b(SU .. 'S', dws.toggle_special())
b(SS .. 'S', dw.move({ workspace = 'special' }))

b(SS .. 'G', dg.toggle())
b(SU .. 'G', dg.next())
b(SX .. 'G', dg.lock())

b(SU .. 'N', dw.toggle_swallow())

b(SU .. 'C', d.layout('fit all'))

b(SU .. 'R', d.layout('colresize -conf'))

b(SU .. 'equal', d.layout('colresize +0.1'))
b(SU .. 'minus', d.layout('colresize -0.1'))

b(SU .. 'mouse:272', dw.drag(),   flags.m)
b(SU .. 'mouse:273', dw.resize(), flags.m)

b(SY .. 'delete', d.exit())

-- DIRECTIONAL MOVEMENT
local axes = {
  h = { left = 'l', h = 'l', right = 'r', l = 'r' },
  v = { down = 'd', j = 'd', up = 'u', k = 'u' },
}

for axis, map in pairs(axes) do
  for key, dir in pairs(map) do
    b(SU .. key, d.layout('focus ' .. dir))
    b(SC .. key, exec_script('hypr-swap.sh ' .. dir))

    if axis == 'h' then
      b(SS .. key, d.focus({ monitor = dir }))
      b(SX .. key, dw.move({ monitor = dir }))
    end

    if axis == 'v' then
      b(SS .. key, exec_script('hypr-workspace.sh focus ' .. dir))
      b(SX .. key, exec_script('hypr-workspace.sh move ' .. dir))
    end
  end
end

b(SU .. 'comma',  exec_script('hypr-move.sh b'))
b(SU .. 'period', exec_script('hypr-move.sh f'))

b(SS .. 'comma',  exec_script('hypr-consume.sh f'))
b(SS .. 'period', exec_script('hypr-consume.sh b'))

-- NUMBERED MOVEMENT
for i = 1, 9 do
  local j = i + 10
  local key = tostring(i)

  b(SU .. key, d.focus({ workspace = i }))
  b(SS .. key, d.focus({ workspace = j }))
  b(SC .. key, dw.move({ workspace = i }))
  b(SX .. key, dw.move({ workspace = j }))
end
