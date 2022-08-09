local present, lualine = pcall(require, "lualine")
if not present then
  return
else
  lualine.setup()
end
