local o = vim.o
local g = vim.g
local keymap = vim.keymap

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

o.shiftwidth = 2
o.expandtab = true

o.termguicolors = true
vim.cmd([[
  set t_Co=256
  set noerrorbells
  syntax enable
  syntax on
]])

keymap.set("n", ",/", ":noh<cr>", { silent = true})
keymap.set("n", "<leader>ft", "<cmd>Neotree toggle<cr>", { silent = true})
keymap.set("n", "<leader>fh", "<cmd>Neotree reveal_file=%<cr>", { silent = true})
keymap.set("n", ";", ":", { silent = true})
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
