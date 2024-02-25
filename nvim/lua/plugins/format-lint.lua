-- to check linter
vim.diagnostic.config({ virtual_text = { source = true, }, })
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cond = function ()
      return vim.fn.executable('pip') and vim.fn.executable("npm")
    end,
    config = function ()
      require('mason-tool-installer').setup {
        ensure_installed = {
          "stylua",
          -- pip
          "sqlfluff",
          -- npm
          "markdownlint",
          "prettierd",
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function ()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sql = {"sqlfluff" },
          markdown = { "markdownlint", "injected" },
          javascript = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          html = { "prettierd" },
          ["_"] = { "trim_whitespace" },
        },

        formatters = {
          markdownlint = {
            prepend_args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint.jsonc" },
          },
        },

      })
      vim.api.nvim_create_user_command("Conform", function() require("conform").format() end, {})
    end
  },
  {
    "mfussenegger/nvim-lint",
    config = function ()
      require('lint').linters_by_ft = {
        sql = {"sqlfluff" },
        markdown = { "markdownlint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })

      local sqlfluff = require('lint').linters.sqlfluff
      sqlfluff.args = {
        "lint", "--format=json",
        "--dialect=ansi",
        "-",
      }
      sqlfluff.stdin = true

      local markdownlint = require('lint').linters.markdownlint
      markdownlint.args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint.jsonc" }
    end
  }
}
