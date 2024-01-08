return {
  "nvim-treesitter/nvim-treesitter",
  config=function ()
    local treesitter_configs = require("nvim-treesitter.configs")
    treesitter_configs.setup {
      highlight = {
        enable = false,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "tsx",
        "typescript",
        "javascript",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "python",
        "fennel",
        "lua",
      },
    }
  end
}
