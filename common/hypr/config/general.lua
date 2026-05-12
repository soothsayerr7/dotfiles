hl.config({
  general = {
    border_size = 2,
    gaps_in     = 3,
    gaps_out    = 6,

    layout = 'scrolling',

    no_focus_fallback = true,

    allow_tearing = true,

    snap = {
      enabled = true,

      window_gap  = 20,
      monitor_gap = 20,

      border_overlap = true,
      respect_gaps   = true,
    },
  },

  decoration = {
    rounding = 0,

    blur = {
      enabled = true,

      size     = 3,
      passes   = 2,
      vibrancy = 0.1696,
    },

    shadow = {
      enabled = true,
      
      range        = 4,
      render_power = 3,
      color        = 'rgba(1a1a1aee)',
    },
  },

  input = {
    kb_layout  = 'us',
    kb_variant = 'altgr-intl',

    numlock_by_default = true,

    repeat_rate = 50,

    accel_profile = 'flat',
    follow_mouse  = 2,

    float_switch_override_focus = 0,
  },

  group = {
    groupbar = {
      enabled = true,

      font_size = 14,
      height    = 16,

      font_weight_active = 'bold',

      gradients = true,
      
      rounding          = 0,
      gradient_rounding = 0,
      
      keep_upper_gap = false,

      blur = true,
    },
  },

  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    force_default_wallpaper  = 0,

    font_family = vars.font,

    enable_swallow = true,
    swallow_regex  = '^' .. vars.terminal_class .. '$',

    mouse_move_focuses_monitor = false,
  },

  binds = {
    hide_special_on_workspace_change  = true,
    window_direction_monitor_fallback = false,
  },

  cursor = {
    no_hardware_cursors = true,
  },

  scrolling = {
    wrap_focus   = false,
    wrap_swapcol = false,

    fullscreen_on_one_column = false,

    explicit_column_widths = '0.33333, 0.5',
  },
})
