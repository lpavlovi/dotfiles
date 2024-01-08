return {
  -- prerequisites for Neotree
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",

  -- must have - util
  "tpope/vim-surround",

  -- must have - colorscheme
  "kyazdani42/nvim-web-devicons",

  -- part of the bootstrap
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    }
  },
}
