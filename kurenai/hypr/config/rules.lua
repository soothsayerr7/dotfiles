hl.layer_rule({
  name = 'noctalia-blur',
  match = { namespace = 'noctalia-background-.*$' },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
