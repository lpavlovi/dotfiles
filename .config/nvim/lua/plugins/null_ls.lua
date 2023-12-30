local present, null_ls = pcall(require, "null-ls")
if not present then
  return
else
  null_ls.setup({
    sources = {
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.formatting.prettier.with({
        filetypes = {
          "javascript",
          "typescript",
          "typescriptreact",
          "css",
          "scss",
          "html",
          "json",
          "yaml",
          "markdown",
          "graphql",
          "md",
          "txt",
        },
        only_local = "node_modules/.bin",

      }),
      -- null_ls.builtins.completion.spell,
    },
  })
end
