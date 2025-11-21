set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

set -x EDITOR nvim

zoxide init fish | source

set -g fish_color_normal e0def4
set -g fish_color_command c4a7e7
set -g fish_color_keyword 9ccfd8
set -g fish_color_quote f6c177
set -g fish_color_redirection 31748f
set -g fish_color_end 908caa
set -g fish_color_error eb6f92
set -g fish_color_param ebbcba
set -g fish_color_comment 908caa
set -g fish_color_selection --reverse
set -g fish_color_operator e0def4
set -g fish_color_escape 31748f
set -g fish_color_autosuggestion 908caa
set -g fish_color_cwd ebbcba
set -g fish_color_user f6c177
set -g fish_color_host 9ccfd8
set -g fish_color_host_remote c4a7e7
set -g fish_color_cancel e0def4
set -g fish_color_search_match --background=191724
set -g fish_color_valid_path
set -g fish_pager_color_progress ebbcba
set -g fish_pager_color_background --background=1f1d2e
set -g fish_pager_color_prefix 9ccfd8
set -g fish_pager_color_completion 908caa
set -g fish_pager_color_description 908caa
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_prefix
set -g fish_pager_color_secondary_completion
set -g fish_pager_color_secondary_description
set -g fish_pager_color_selected_background --background=26233a
set -g fish_pager_color_selected_prefix 9ccfd8
set -g fish_pager_color_selected_completion e0def4
set -g fish_pager_color_selected_description e0def4
set -g fish_color_subtle 908caa
set -g fish_color_text e0def4
set -g fish_color_love eb6f92
set -g fish_color_gold f6c177
set -g fish_color_rose ebbcba
set -g fish_color_pine 31748f
set -g fish_color_foam 9ccfd8
set -g fish_color_iris c4a7e7
