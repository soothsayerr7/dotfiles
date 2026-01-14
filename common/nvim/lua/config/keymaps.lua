Keymap = require('util').keymap
Flash = require('util').flash

Keymap('Write', '<leader>w', '<cmd>w<cr>')
Keymap('Quit', '<leader>q', '<cmd>q<cr>')

Keymap('Clear highlights', '<esc>', '<cmd>noh<cr>')

Keymap('Toggle indent size', '<leader>tt', function()
  local next = vim.bo.tabstop == 4 and 2 or 4

  vim.bo.tabstop = next
  vim.bo.shiftwidth = next
  vim.bo.softtabstop = next

  Flash('Tab size: ' .. next)
end)
