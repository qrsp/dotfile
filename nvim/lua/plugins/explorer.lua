return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				delete_to_trash = true,

        -- oil-vcs-status
        win_options = {
            signcolumn = "number",
        },
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
  { "SirZenith/oil-vcs-status" },
	{
		"nvim-tree/nvim-tree.lua",
		keys = { "<F2>" },
		config = function()
			require("nvim-tree").setup({
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
