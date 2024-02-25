-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', ',d', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', ',wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', ',wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', ',wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', ',D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', ',rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, ',ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', ',f', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.api.nvim_buf_create_user_command(0, 'Format', function() vim.lsp.buf.format { async = true } end, {})
  end,
})


return {
  { 'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/nvim-cmp"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      local lspconfig = require('lspconfig')

      lspconfig.pyright.setup {}

      local on_attach = function(client, bufnr)
        if client.name == 'ruff_lsp' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end

      require('lspconfig').ruff_lsp.setup {
        on_attach = on_attach,
      }


      -- for Neovim
      -- [lua_ls config.md](https://github.com/LuaLS/lua-language-server/blob/master/doc/en-us/config.md)
      require'lspconfig'.lua_ls.setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  version = 'LuaJIT'
                },
                workspace = {
                  checkThirdParty = "Disable",
                  library = {
                    vim.env.VIMRUNTIME
                  }
                }
              }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end
      }

      -- PHP --
      -- Need .git or composer.json to find root_dir
      lspconfig.intelephense.setup {}

      -- After run `composer init`
      -- `composer install` to create composer.lock
      -- `~/AppData/Local/nvim-data/mason/bin/psalm.cmd --init` to create psalm.xml
      lspconfig.psalm.setup {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/psalm-language-server.cmd" },
      }
    end
  },
  { "folke/neodev.nvim", opts = {} },
  { "williamboman/mason.nvim",
    cmd = "Mason",
    config = function ()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cond = function ()
      return vim.fn.executable('pip') and vim.fn.executable("npm")
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig'
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        -- pip
        "pylsp",
        "ruff_lsp",
        -- npm
        "pyright",
        "intelephense",
        -- "psalm", -- install manually
      },
    }
  },
  {
    "hedyhli/outline.nvim",
    keys = {
      { '<F3>', '<Cmd>Outline<CR>', "Toggle Outline" }
    },
    config = function()
      require("outline").setup {
        outline_items = {
          show_symbol_lineno = true,
          show_symbol_details = false,
        },
        outline_window = {
          show_cursorline = true,
          hide_cursor = true,
        }
      }
    end,
  },
  {
    "dnlhc/glance.nvim",
    cmd = { "Glance" }
  },
}
