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
o.cmdheight = 6

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
map('n', ',/', ':noh<cr>', {})
map('n', '<C-h>', '<C-w>h', {})
map('n', '<C-j>', '<C-w>j', {})
map('n', '<C-k>', '<C-w>k', {})
map('n', '<C-l>', '<C-w>l', {})
map('n', '<Tab>', ':bn<cr>', { silent = true })
map('n', ';', ':', { noremap = true })
map('n', '<leader>h', ':NERDTreeFind<cr>', { silent = true })
map('n', '<leader>sc', ':source $MYVIMRC<cr>', {})

local completion = {}

local function esc(cmd)
  return vim.api.nvim_replace_termcodes(cmd, true, false, true)
end

function completion.check_back_space()
  local col = vim.fn.col('.') - 1
  return col <= 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function completion.tab_completion()
  if vim.fn['vsnip#jumpable'](1) > 0 then
    return esc('<Plug>(vsnip-jump-next)')
  end

  if vim.fn.pumvisible() > 0 then
    return esc('<C-n>')
  end

  if completion.check_back_space() then
    return esc('<TAB>')
  end

  if vim.fn['vsnip#expandable']() > 0 then
    return esc('<Plug>(vsnip-expand)')
  end

  return vim.fn['compe#complete']()
end

map('i', '<TAB>', 'v:completion.tab_completion()', { expr = true, noremap = false })

-- commands
vim.cmd('colo dracula')
