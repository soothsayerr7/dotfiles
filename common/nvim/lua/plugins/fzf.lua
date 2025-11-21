return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  keys = {
    Keymap('Fzf: Files', '<leader>f', '<cmd>FzfLua files<cr>'),
    Keymap('Fzf: Grep', '<leader>g', '<cmd>FzfLua live_grep_native<cr>'),
    Keymap('Fzf: Buffers', '<leader>b', '<cmd>FzfLua buffers<cr>')
  },
  opts = {}
}
