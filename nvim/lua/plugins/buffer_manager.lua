return {
	{
		"j-morano/buffer_manager.nvim",
		config = function()
			local opts = { noremap = true }
			local map = vim.keymap.set
			-- Setup
			require("buffer_manager").setup({
				select_menu_item_commands = {
					v = {
						key = "<C-v>",
						command = "vsplit",
					},
					h = {
						key = "<C-h>",
						command = "split",
					},
				},
				short_term_names = true,
			})
			-- Navigate buffers bypassing the menu
			local bmui = require("buffer_manager.ui")
			local keys = "1234567890"
			for i = 1, #keys do
				local key = keys:sub(i, i)
				map("n", string.format("<leader>%s", key), function()
					bmui.nav_file(i)
				end, opts)
			end
			map({ "t", "n" }, "<leader>b", bmui.toggle_quick_menu, opts)
		end,
	},
}
