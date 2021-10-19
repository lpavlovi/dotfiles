local o = vim.o
local wo = vim.wo
local bo = vim.bo

local map = vim.api.nvim_set_keymap

-- set up packer
require("plugins")

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
-- ... snip ...

-- window-local options
wo.number = false
wo.wrap = false

-- buffer-local options
bo.expandtab = true
bo.shiftwidth = 2
bo.tabstop = 2

-- mapping
-- Example usage:
--   map( mode, mappable key, behaviour, options )
map('n', ',/', ':noh<CR>', {})

-- commands
cmds = {
  [[ command! Scratch lua require('tools').makeScratch() ]]
}
vim.cmd(cmds[1])

