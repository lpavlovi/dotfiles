local o = vim.o
local g = vim.g
local map = vim.api.nvim_set_keymap

-- global options
g.mapleader = " "

o.swapfile = true
o.dir = "/tmp"
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.scrolloff = 4
o.showmatch = true
o.ignorecase = true
o.backspace = "indent,eol,start"
o.smarttab = true
o.number = true
o.buftype = ""
o.cmdheight = 1
o.numberwidth = 3
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
o.relativenumber = true
o.rnu = true

o.termguicolors = true
vim.cmd([[
  set t_Co=256
  set noerrorbells
  syntax enable
  syntax on
]])

map("n", ",/", ":noh<cr>", { silent = true})
