local theme = {
  base           = 'rgb(191724)',
  surface        = 'rgb(1f1d2e)',
  overlay        = 'rgb(26233a)',
  muted          = 'rgb(6e6a86)',
  subtle         = 'rgb(908caa)',
  text           = 'rgb(e0def4)',
  love           = 'rgb(eb6f92)',
  gold           = 'rgb(f6c177)',
  rose           = 'rgb(ebbcba)',
  pine           = 'rgb(31748f)',
  foam           = 'rgb(9ccfd8)',
  iris           = 'rgb(c4a7e7)',
  highlight_low  = 'rgb(21202e)',
  highlight_med  = 'rgb(403d52)',
  highlight_high = 'rgb(524f67)',
}

hl.config({
  general = {
    col = {
      active_border   = theme.iris,
      inactive_border = theme.base,
    },
  },

  group = {
    col = {
      border_active   = theme.pine,
      border_inactive = theme.base,

      border_locked_active   = theme.love,
      border_locked_inactive = theme.base,
    },

    groupbar = {
      col = {
        active   = theme.pine,
        inactive = theme.base,

        locked_active   = theme.love,
        locked_inactive = theme.base,

      },

      text_color          = theme.base,
      text_color_inactive = theme.text,
    },
  },


  misc = {
    background_color = theme.base,
  },
})
