return {
  -- prerequisites for Neotree
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",

  -- must have - util
  "tpope/vim-surround",

  -- must have - colorscheme
  {
    "tomasr/molokai",
    config = function()
      vim.cmd([[
        colorscheme molokai
      ]])
    end,
  },
  {
    "lifepillar/vim-solarized8",
    config = function()
      -- vim.cmd([[
      --   colorscheme solarized8_high
      --   set background=light
      -- ]])
    end,
  },

  "kyazdani42/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },

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
  {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require("plugins.telescope")
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      for _, entry in ipairs(require("plugins.which_key")) do
        local mapping, opts = entry[1], entry[2]
        wk.register(mapping, opts)
      end
    end,
  },
}
