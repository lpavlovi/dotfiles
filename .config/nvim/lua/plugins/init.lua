local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  print("Cloning packer")
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd("packadd packer.nvim")


local function load_plugins()
  local packer = require'packer'
  return packer.startup(
  function(use)
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
    use 'morhetz/gruvbox'

    -- navigation
    use { "alexghergh/nvim-tmux-navigation", config = "require'plugins.tmux_navigation'" }

    use {
      'hrsh7th/nvim-cmp',
      requires= {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind.nvim',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-vsnip',
      },
      config = "require'plugins.nvim_cmp'",
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = "require'plugins.lualine'"
    }

    use { 'jose-elias-alvarez/null-ls.nvim', config="require'plugins.null_ls'"}

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config="require'plugins.treesitter'"}
    use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      config = "require'plugins.telescope'",
    }

    use { 'williamboman/mason.nvim', config="require'plugins.lsp'" }
    -- Sync packer if we ran bootstrapping code (top of the file)
    -- on initializing neovim
    if packer_bootstrap then
      packer.sync()
    end
  end
  )
end

load_plugins()
