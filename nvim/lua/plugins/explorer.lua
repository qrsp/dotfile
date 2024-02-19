return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        delete_to_trash = true,
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<F2>" },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = false,
        view = {
          number = true,
          relativenumber = true,
        },
        ui = {
          confirm = {
            trash = false,
          },
        },
      })
      vim.keymap.set("n", "<F2>", "<CMD>NvimTreeToggle<CR>", { desc = "Open parent directory" })
    end,
  },
}
