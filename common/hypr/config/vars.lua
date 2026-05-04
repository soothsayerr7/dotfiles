local M = {}

local handle = io.popen('hostnamectl hostname')
M.hostname = handle:read('*a'):gsub('%s+', '')
handle:close()

M.terminal       = 'wezterm'
M.terminal_class = 'org.wezfurlong.wezterm'

M.browser = 'helium-browser'

M.file_manager = 'nautilus -w'

M.font      = 'Noto Sans'
M.font_mono = 'JetBrains Mono'

return M
