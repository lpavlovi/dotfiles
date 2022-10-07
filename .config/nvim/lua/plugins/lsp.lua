local function on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
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
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment") 
        and not context.in_syntax_group("Comment")
      end
    end,
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
      ['<C-n>'] = {
        c = function(fallback)
          local cmp = require('cmp')
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ['<C-p>'] = {
        c = function(fallback)
          local cmp = require('cmp')
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
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
      { name = 'vsnip' },
      { name = 'calc' },
    }
  })
end

local function setup_lsp_servers()
  local lspconfig = require'lspconfig'
  local util = require'lspconfig.util'
  local nvim_cmp = require'cmp_nvim_lsp'
  local lsp_installer = require'nvim-lsp-installer'
  local capabilities = nvim_cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local cwd_path = vim.fn.getcwd()
  local root_project_path = util.root_pattern(".git")(cwd_path)
  local node_modules_bin_path = "node_modules/.bin"

  lsp_installer.setup {}
  lspconfig.pyright.setup{
      on_attach = on_attach,
      capabilities = capabilities,
  }
  lspconfig.tsserver.setup{
      on_attach = on_attach,
      capabilities = capabilities,
  }
  lspconfig.clojure_lsp.setup{
      on_attach = on_attach,
      capabilities = capabilities,
  }  lspconfig.jdtls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
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


