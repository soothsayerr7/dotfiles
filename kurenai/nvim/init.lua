vim.g.mapleader = ' '

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.ignorecase = true
opt.smartcase = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.expandtab = true
opt.smartindent = true

opt.scrolloff = 8
opt.wrap = false

opt.clipboard = 'unnamedplus'

local keymap = vim.keymap.set

keymap('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
keymap('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
keymap('n', '<leader>e', ':Oil<CR>', { desc = 'Explorer' })
keymap('n', '<Esc>', ':noh<CR>', { desc = 'Clear highlights' })

vim.pack.add({
  {
    src = 'https://github.com/rose-pine/neovim',
    name = 'rose-pine'
  },
  {
    src = 'https://github.com/stevearc/oil.nvim',
  }, 
  {
    src = 'https://github.com/nvim-mini/mini.icons',
  } 
})

require('rose-pine').setup({
  styles = {
    transparency = true
  }
})

vim.cmd('colorscheme rose-pine')

require('mini.icons').setup({})

require('oil').setup({})

