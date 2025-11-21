return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = { Keymap('Oil: Files', '<leader>e', '<cmd>Oil<cr>') },
  opts = {},
  init = function()
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
  end
}
