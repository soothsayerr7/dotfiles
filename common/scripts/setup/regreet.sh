#!/usr/bin/env bash

set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "ERROR: Must be run as root."
  exit 1
fi

pacman -S greetd greetd-regreet
systemctl enable greetd

cat <<EOF > /etc/greetd/config.toml
[terminal]
vt = 1

[default_session]
command = "dbus-run-session start-hyprland -- -c /etc/greetd/hyprland.lua"
user = "greeter"
EOF

cat <<EOF > /etc/greetd/hyprland.lua
hl.on('hyprland.start', function ()
  hl.exec_cmd('regreet --style /etc/greetd/regreet.css; hyprctl dispatch exit')
end)

hl.config({
  misc = {
    disable_hyprland_logo           = true,
    disable_splash_rendering        = true,
    disable_hyprland_guiutils_check = true,
  },

  input = {
    numlock_by_default = true,
    accel_profile      = 'flat',
  },
})
EOF

cat <<EOF > /etc/greetd/regreet.toml
[GTK]
theme_name = "adw-gtk3"
icon_theme_name = "Adwaita"
cursor_theme_name = "Adwaita"

application_prefer_dark_theme = true

font_name = "Noto Sans"

[commands]
reboot = [ "systemctl", "reboot" ]
poweroff = [ "systemctl", "poweroff" ]
EOF

cat <<EOF > /etc/greetd/regreet.css
@define-color accent_color #ebbcba;
@define-color accent_bg_color #ebbcba;
@define-color accent_fg_color #191724;

@define-color destructive_bg_color #eb6f92;
@define-color destructive_fg_color #191724;

@define-color error_bg_color #eb6f92;
@define-color error_fg_color #191724;

@define-color window_bg_color #191724;
@define-color window_fg_color #e0def4;

@define-color view_bg_color #191724;
@define-color view_fg_color #e0def4;

@define-color headerbar_bg_color #191724;
@define-color headerbar_fg_color #e0def4;
@define-color headerbar_backdrop_color @window_bg_color;

@define-color popover_bg_color #26233a;
@define-color popover_fg_color #e0def4;

@define-color card_bg_color #26233a;
@define-color card_fg_color #e0def4;

@define-color dialog_bg_color #191724;
@define-color dialog_fg_color #e0def4;

@define-color overview_bg_color #26233a;
@define-color overview_fg_color #e0def4;

@define-color sidebar_bg_color #26233a;
@define-color sidebar_fg_color #e0def4;
@define-color sidebar_backdrop_color @window_bg_color;
@define-color sidebar_border_color @window_bg_color;

@define-color secondary_sidebar_bg_color #191724;
@define-color secondary_sidebar_fg_color #e0def4;

/* Backdrop/unfocused states */
@define-color theme_unfocused_fg_color @window_fg_color;
@define-color theme_unfocused_text_color @view_fg_color;
@define-color theme_unfocused_bg_color @window_bg_color;
@define-color theme_unfocused_base_color @window_bg_color;
@define-color theme_unfocused_selected_bg_color @accent_bg_color;
@define-color theme_unfocused_selected_fg_color @accent_fg_color;

:root {
    --accent-color: #ebbcba;
    --accent-bg-color: #ebbcba; 
    --accent-fg-color: #191724;

    --destructive-bg-color: #eb6f92;
    --destructive-fg-color: #191724;

    --error-bg-color: #eb6f92;
    --error-fg-color: #191724;
    --error-color: #eb6f92;

    --window-bg-color: #191724;
    --window-fg-color: #e0def4;

    --view-bg-color: #191724;
    --view-fg-color: #e0def4;

    --headerbar-bg-color: #191724;
    --headerbar-fg-color: #e0def4;
    --headerbar-backdrop-color: @window_bg_color;

    --popover-bg-color: #26233a;
    --popover-fg-color: #e0def4;

    --card-bg-color: #26233a;
    --card-fg-color: #e0def4;

    --dialog-bg-color: #191724;
    --dialog-fg-color: #e0def4;

    --overview-bg-color: #26233a;
    --overview-fg-color: #e0def4;

    --sidebar-bg-color: #26233a;
    --sidebar-fg-color: #e0def4;
    --sidebar-backdrop-color: @window_bg_color;
    --sidebar-border-color: @window_bg_color;

    --warning-bg-color: #0e313f;
    --warning-fg-color: #d9ebf2;
    --warning-color: #31748f;

    --success-color: #9ccfd8;
    --success-bg-color: #288899;
    --success-fg-color: #091417;
    
    --shade-color: rgba(0, 0, 0, 0.36);
}
EOF
