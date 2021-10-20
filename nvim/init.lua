local o = vim.o
local wo = vim.wo
local bo = vim.bo

local map = vim.api.nvim_set_keymap

-- set up packer
require("plugins")

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  print("did attach")
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
nvim_lsp.pyright.setup {
  on_attach = on_attach,
  cmd = {"/Users/lukap/.local/share/nvim/lsp_servers/python/node_modules/.bin/pyright-langserver", "--stdio"},
  flags = {
    debounce_text_changes = 150,
  }
}

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

-- commands
vim.cmd('colo dracula')
