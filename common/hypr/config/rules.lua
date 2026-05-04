local wr = hl.window_rule
local lr = hl.layer_rule

lr({
  name = 'noctalia-blur',
  match = { namespace = 'noctalia-background-.*$' },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
