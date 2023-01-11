-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Setup nvim-cmp.
local function setup_nvim_autocomplete()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp = require'cmp'
  local luasnip = require'luasnip'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ['<C-e>'] = cmp.mapping.abort(),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    window = {
      documentation = cmp.config.window.bordered(),
    },
    -- formatting = {
    --   format = function(entry, item)
    --     local menu_map = {
    --       buffer = '[Buf]',
    --       nvim_lsp = '[LSP]',
    --       nvim_lua = '[API]',
    --       path = '[Path]',
    --       luasnip = '[Snip]',
    --       vsnip = '[Snip]',
    --       conjure = '[Conj]',
    --     }
    --     item.menu = menu_map[entry.source.name] or string.format('[%s]', entry.source.name)
    --     item.kind = vim.lsp.protocol.CompletionItemKind[item.kind]
    --     return item
    --   end,
    -- },
    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'conjure' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'calc' },
    }
  })
end

local function setup_lsp_servers()
  local lspconfig = require'lspconfig'
  local util = require'lspconfig.util'
  local nvim_cmp = require'cmp_nvim_lsp'
  local lsp_installer = require'mason'
  local capabilities = nvim_cmp.default_capabilities()
  local cwd_path = vim.fn.getcwd()
  local home = vim.fn.expand('$HOME')
  local root_project_path = util.root_pattern(".git")(cwd_path)
  local node_modules_bin_path = "node_modules/.bin"

  lsp_installer.setup {}
  lspconfig.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.clojure_lsp.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "clojure" },
  }
  lspconfig.flow.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { util.path.join(root_project_path, node_modules_bin_path, "flow"), "lsp" }
  }
  lspconfig.sumneko_lua.setup{
    on_attach = on_attach,
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  }
end

setup_nvim_autocomplete()
setup_lsp_servers()
