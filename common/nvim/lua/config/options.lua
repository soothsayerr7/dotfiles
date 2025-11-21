local o = vim.o
local g = vim.g

o.scrolloff = 10
o.smoothscroll = true

o.laststatus = 3
o.showmode = false

o.number = true
o.numberwidth = 2
o.relativenumber = true
o.ruler = false
o.cursorline = true
o.signcolumn = 'number'

o.splitbelow = true
o.splitright = true

o.timeoutlen = 300

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.incsearch = true

o.list = true
o.listchars = 'lead:.,trail:.'

o.termguicolors = true
o.title = true
o.clipboard = 'unnamed,unnamedplus'

o.swapfile = false
o.undofile = true

g.mapleader = ' '
g.maplocalleader = '\\'

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

if vim.fn.has('win32') == 1 then
  require('util').pwsh()
end
