local present, luasnip = pcall(require, "luasnip")
if not present then
  return
end
print("setting up luasnip")

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
require("luasnip/loaders/from_vscode").load()
