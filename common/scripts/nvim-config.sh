#!/usr/bin/env bash

set -euo pipefail

nvim_dir="$HOME/.config/nvim"
init_lua="$nvim_dir/init.lua"

if [[ -d "$nvim_dir" ]]; then
  rm -rf "$nvim_dir".bak
  mv "$nvim_dir" "$nvim_dir".bak
fi

mkdir -p "$nvim_dir"

cat <<EOF > "$init_lua"
vim.g.mapleader = " "

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

opt.swapfile = false
opt.undofile = true

opt.clipboard = "unnamedplus"

local keymap = vim.keymap.set

keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>e", ":Exp<CR>", { desc = "Explorer" })
keymap("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
EOF
