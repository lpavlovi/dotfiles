vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'dracula/vim', as = 'dracula'}
end)
