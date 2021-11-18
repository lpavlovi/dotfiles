local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  print("Cloning packer")
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd("packadd packer.nvim")
local packer = require'packer'
local use = packer.use

return packer.startup(
function()
  -- self managing package manager
  use {'wbthomason/packer.nvim', event = "VimEnter"}

  use 'nvim-lua/plenary.nvim'

  use {'kyazdani42/nvim-web-devicons'}

  -- must haves
  use 'tpope/vim-surround'
  use 'scrooloose/nerdtree'

  -- colorschemes
  use {'dracula/vim', as = 'dracula'}
  use 'drewtempelmeyer/palenight.vim'
  use 'lifepillar/vim-solarized8'
  use 'tomasr/molokai'

  -- new features!
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    config = "require'plugins.telescope'",
  }

  use { 'williamboman/nvim-lsp-installer', config="require'plugins.lsp'" }

  -- Sync packer if we ran bootstrapping code (top of the file)
  -- on initializing neovim
  if packer_bootstrap then
    packer.sync()
  end
end
)

