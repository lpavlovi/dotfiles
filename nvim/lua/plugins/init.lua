local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(
  function(use)
    -- self managing package manager
    use 'wbthomason/packer.nvim'
    -- use 'jose-elias-alvarez/null-ls.nvim'
    use 'nvim-lua/plenary.nvim'

    -- must haves
    use 'tpope/vim-surround'
    use 'scrooloose/nerdtree'

    use {
      'romgrk/barbar.nvim',
      requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- colorschemes
    use {'dracula/vim', as = 'dracula'}
    use 'drewtempelmeyer/palenight.vim'
    use 'lifepillar/vim-solarized8'
    use 'tomasr/molokai'


    -- new features!
    use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
      config=require'plugins.lsp',
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      requires = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
      },
      config = require'plugins.telescope'
    }

    if packer_bootstrap then
      require('packer').sync()
    end

  end
)

