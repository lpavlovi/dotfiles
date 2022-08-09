local present, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
else
  treesitter_configs.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "yaml",
    "html",
    "scss",
    "python",
    "fennel",
    "lua",
  },
}
end
