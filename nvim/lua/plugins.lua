vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
  function(use)
    -- self managing package manager
    use 'wbthomason/packer.nvim'
    -- use 'jose-elias-alvarez/null-ls.nvim'
    use 'nvim-lua/plenary.nvim'

    -- must haves
    use 'tpope/vim-surround'
    use 'scrooloose/nerdtree'
    use 'bling/vim-airline'

    -- colorschemes
    use {'dracula/vim', as = 'dracula'}
    use 'drewtempelmeyer/palenight.vim'
    use 'lifepillar/vim-solarized8'
    use 'tomasr/molokai'


    -- new features!
    use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'glepnir/lspsaga.nvim'
    use 'nvim-telescope/telescope.nvim'
  end
)
