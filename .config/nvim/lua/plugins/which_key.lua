-- return {
--   "folke/which-key.nvim",
--   event = "VeryLazy",
--   init = function()
--     vim.o.timeout = true
--     vim.o.timeoutlen = 300
--   end,
--   config = function()
--     local wk = require("which-key")
--     for _, entry in ipairs(require("core.keymapping")) do
--       local mapping, opts = entry[1], entry[2]
--       wk.register(mapping, opts)
--     end
--   end,
-- }
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
