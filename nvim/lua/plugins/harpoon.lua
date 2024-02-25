return {
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   init = function ()
  --     local harpoon = require("harpoon")
  --
  --     -- REQUIRED
  --     harpoon:setup()
  --     -- REQUIRED
  --
  --     vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
  --     vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  --
  --     vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
  --     vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
  --     vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
  --     vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)
  --   end
  -- },
  {
    "j-morano/buffer_manager.nvim",
    config = function ()
      local opts = {noremap = true}
      local map = vim.keymap.set
      -- Setup
      require("buffer_manager").setup({
        select_menu_item_commands = {
          v = {
            key = "<C-v>",
            command = "vsplit"
          },
          h = {
            key = "<C-h>",
            command = "split"
          }
        },
        short_term_names = true,
      })
      -- Navigate buffers bypassing the menu
      local bmui = require("buffer_manager.ui")
      local keys = '1234567890'
      for i = 1, #keys do
        local key = keys:sub(i,i)
        map(
          'n',
          string.format('<leader>%s', key),
          function () bmui.nav_file(i) end,
          opts
        )
      end
      map({ 't', 'n' }, '<M-Space>', bmui.toggle_quick_menu, opts)
    end
  }
}
