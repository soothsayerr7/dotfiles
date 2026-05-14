local M = {}

local handle = io.popen('hostnamectl hostname')
M.hostname = handle:read('*a'):gsub('%s+', '')
handle:close()

M.username = os.getenv("USER")

M.home = '/home/' .. M.username .. '/'

M.hypr_dir = M.home .. '.config/hypr/'
M.screenshot_dir = M.home .. 'pictures/screenshots/'

M.terminal       = 'alacritty'
M.terminal_class = 'Alacritty'

M.browser = 'helium-browser'

M.file_manager = 'nautilus -w'

M.font      = 'Inter'
M.font_mono = 'JetBrains Mono'
M.font_size = 11

return M
