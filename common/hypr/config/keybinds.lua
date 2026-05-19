-- VARIABLES
local b  = hl.bind

local d   = hl.dsp
local dw  = hl.dsp.window
local dws = hl.dsp.workspace
local dg  = hl.dsp.group

local SUP = 'SUPER + '
local SSH = 'SUPER + SHIFT + '
local SCT = 'SUPER + CTRL + '
local SAL = 'SUPER + ALT + '
local SSC = 'SUPER + SHIFT + CTRL + '
local SCA = 'SUPER + CTRL + ALT +'

local flags = {
  lp = { long_press = true },
  e  = { repeating = true },
  l  = { locked = true },
  el = { repeating = true, locked = true},
  m  = { mouse = true },
}

local function exec_script(script)
  return d.exec_cmd(vars.hypr_dir .. 'scripts/' .. script)
end

-- NOCTALIA
local function noc_msg(cmd)
  return d.exec_cmd('noctalia msg ' .. cmd)
end

local PT = 'panel-toggle '

b(SUP .. 'Space', noc_msg(PT .. 'launcher'))
b(SUP .. 'V',     noc_msg(PT .. 'clipboard'))

b(SUP .. 'B', noc_msg('bar-toggle'))

b(SSH .. 'Q', noc_msg(PT .. 'session'))

b(SUP .. 'delete', noc_msg('dpms-off'))

b('XF86AudioRaiseVolume', noc_msg('volume-up'),   flags.el)
b('XF86AudioLowerVolume', noc_msg('volume-down'), flags.el)
b('XF86AudioMute',        noc_msg('volume-mute'), flags.l)

b('XF86MonBrightnessUp',   noc_msg('brightness-up'),   flags.el)
b('XF86MonBrightnessDown', noc_msg('brightness-down'), flags.el)

-- PROGRAMS
b(SUP .. 'T', d.exec_cmd(vars.terminal))
b(SUP .. 'W', d.exec_cmd(vars.browser))
b(SUP .. 'E', d.exec_cmd(vars.file_manager))

-- GENERAL
b(SUP .. 'Q', dw.close())
--
b(SUP .. 'A', dw.float({ action = 'toggle' }))
b(SSH .. 'A', dw.pin())

b(SUP .. 'X', dw.cycle_next())

b(SUP .. 'F', d.layout('colresize 1.0'))
b(SSH .. 'F', dw.fullscreen())
b(SAL .. 'F', exec_script('fullscreen.sh'))

b(SUP .. 'S', dws.toggle_special())
b(SCT .. 'S', dw.move({ workspace = 'special' }))

b(SSH .. 'G', dg.toggle())
b(SUP .. 'G', dg.next())
b(SSC .. 'G', dg.lock())

b(SUP .. 'N', dw.toggle_swallow())

b(SUP .. 'C', d.layout('fit all'))

b(SUP .. 'R', d.layout('colresize -conf'))

b(SUP .. 'equal', d.layout('colresize +0.1'))
b(SUP .. 'minus', d.layout('colresize -0.1'))

b(SUP .. 'mouse:272', dw.drag(),   flags.m)
b(SUP .. 'mouse:273', dw.resize(), flags.m)

b(SCA .. 'delete', d.exit())

-- SCREENSHOTS
local function hyprshot(mode)
  if mode == 'all' then
    return d.exec_cmd('grim - | wl-copy')
  else
    return d.exec_cmd('hyprshot -z -s --clipboard-only -m ' .. mode)
  end
end

b(SUP .. 'Z', hyprshot('region'))
b(SSH .. 'Z', hyprshot('window'))
b(SCT .. 'Z', hyprshot('output'))
b(SSC .. 'Z', hyprshot('all'))

local screenshot_fmt = 'screenshot_$(date +%Y-%m-%d_%H-%M-%S).png'
b(SAL .. 'Z', d.exec_cmd('wl-paste > ' .. vars.screenshot_dir .. screenshot_fmt))

-- DIRECTIONAL MOVEMENT
local axes = {
  h = { left = 'l', h = 'l', right = 'r', l = 'r' },
  v = { down = 'd', j = 'd', up = 'u', k = 'u' },
}

for axis, map in pairs(axes) do
  for key, dir in pairs(map) do
    b(SUP .. key, d.layout('focus ' .. dir))
    b(SCT .. key, dw.swap({ direction = dir }))

    if axis == 'h' then
      b(SSH .. key, d.focus({ monitor = dir }))
      b(SSC .. key, dw.move({ monitor = dir }))
    end

    if axis == 'v' then
      b(SSH .. key, exec_script('vertical-workspaces.sh focus ' .. dir))
      b(SSC .. key, exec_script('vertical-workspaces.sh move ' .. dir))
    end
  end
end

b(SUP .. 'comma',  d.layout('consume_or_expel prev'))
b(SUP .. 'period', d.layout('consume_or_expel next'))

-- NUMBERED MOVEMENT
for i = 1, 9 do
  local j = i + 10
  local key = tostring(i)

  b(SUP .. key, d.focus({ workspace = i }))
  b(SSH .. key, d.focus({ workspace = j }))
  b(SCT .. key, dw.move({ workspace = i }))
  b(SSC .. key, dw.move({ workspace = j }))
end
