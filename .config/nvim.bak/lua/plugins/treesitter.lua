local present, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
else
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
