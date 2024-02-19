return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    cond = vim.fn.executable('gcc'),
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    ---@type TSConfig
    opts = {
      highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", },
    },
    cmd = { "TSContextToggle" },
    config = function()
      require("treesitter-context").setup({
        enable = false
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", },
    },
  },
}
