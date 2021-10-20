local o = vim.o
local wo = vim.wo
local bo = vim.bo

local map = vim.api.nvim_set_keymap

-- set up packer
require("plugins")
require("lsp_setup").Setup()

-- plugin settings
-- airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'default'
vim.g['airline_powerline_fonts'] = 1

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.scrolloff = 12
o.showmatch = true
o.ignorecase = true
o.backspace = 'indent,eol,start'
o.smarttab = true
o.number = true
o.buftype = ''
o.cmdheight = 2

vim.g.mapleader = '\\'

o.termguicolors = true
vim.g['solarized_termcolors'] = 256
vim.cmd([[
  set t_Co=256
  set noerrorbells
  syntax enable
  syntax on
]])

-- window-local options
-- wo.number = false
-- wo.wrap = false

-- buffer-local options
-- bo.expandtab = true
-- bo.shiftwidth = 2
-- bo.tabstop = 2
-- except I like these to be global
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

-- mapping
-- Example usage:
--   map( mode, mappable key, behaviour, options )
map('n', ',/', ':noh<cr>', { silent = true})
map('n', '<C-h>', '<C-w>h', {})
map('n', '<C-j>', '<C-w>j', {})
map('n', '<C-k>', '<C-w>k', {})
map('n', '<C-l>', '<C-w>l', {})
map('n', '<Tab>', ':bn<cr>', { silent = true })
map('n', ';', ':', { noremap = true })
map('n', '<leader>h', ':NERDTreeFind<cr>', { silent = true })
map('n', '<leader>n', ':NERDTreeToggle<cr>', { silent = true })
map('n', '<leader>sc', ':source $MYVIMRC<cr>', {})

map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', {})
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', {})
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', {})
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', {})


-- commands
vim.cmd('colo palenight')
