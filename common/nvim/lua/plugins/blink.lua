return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',
  opts = {
    keymap = { preset = 'super-tab' },
    completion = { list = { selection = { preselect = true, auto_insert = false } } },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } }
  }
}
