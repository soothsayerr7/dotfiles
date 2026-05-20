local wr = hl.window_rule
local lr = hl.layer_rule

wr({ match = { class = "helium", workspace = 'r[1-9]' }, scrolling_width = 1.0})

lr({
  name = 'noctalia-blur',
  match = { namespace = '^noctalia-(bar-.+|notification|dock|panel)$' },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
