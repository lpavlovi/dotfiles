vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
  function(use)
    -- self managing package manager
    use 'wbthomason/packer.nvim'
    -- use 'jose-elias-alvarez/null-ls.nvim'

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
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-lua/plenary.nvim'
    use 'glepnir/lspsaga.nvim'
  end
)
