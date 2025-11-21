local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then
  local lazy_repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable', lazy_repo, lazy_path
  })
end
vim.opt.rtp:prepend(lazy_path)

require('config.options')
require('config.keymaps')

require('lazy').setup({
  spec = 'plugins',
  install = { colorscheme = { 'rose-pine' } },
  lockfile = vim.fn.stdpath('data') .. '/lazy/lazy-lock.json',
  rocks = { enabled = false },
  change_detection = { notify = false }
})
