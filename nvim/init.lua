-- require
--   pip, npm(LSP)
--   gcc(nvim-treesitter)
--   gcc, make(telescope-fzf-native.nvim)
--   ripgrep(telescope.nvim)
--   awk(trim_whitespace)

-- -- --
-- UI --
-- -- --
vim.o.cursorline = true
vim.o.sidescrolloff = 5
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile = true
vim.o.termguicolors = true

vim.o.list = true
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"

--- wrap indent
vim.o.breakindent = true
vim.o.showbreak = "↳"

--- search patterns
vim.o.ignorecase = true
vim.o.smartcase = true

--- edit
vim.o.inccommand = "split" -- Preview substitute
vim.o.whichwrap = "h,l,<,>,~" -- Allow move to the previous/next line
vim.o.fileencodings = "utf-8,cp950,utf-16le"

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.tabstop = 4

--- motion
vim.o.jumpoptions = "stack"

--- function
vim.o.mouse = "a"
vim.o.clipboard = "unnamed,unnamedplus" -- To ALWAYS use the clipboard for ALL operations

--- Provider
if jit.os == "Windows" then
	vim.g.python3_host_prog = "~/venvs/neovim/Scripts/python.exe"
end

-- --- --
-- Map --
-- --- --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n" }, "<Leader>w", "<Cmd>write<CR>")
vim.keymap.set({ "n" }, "<Leader>q", "<Cmd>quit<CR>")
vim.keymap.set({ "n" }, "Q", "<Cmd>qa<CR>")
vim.keymap.set({ "n" }, "<Leader>x", "<Cmd>xa<CR>")

vim.keymap.set({ "n" }, "<Leader>dd", "<Cmd>bdelete<CR>")
vim.keymap.set({ "n" }, "<Leader>zz", "<Cmd>xa!<CR>")
vim.keymap.set({ "n" }, "<Leader>zq", "<Cmd>qa!<CR>")

--- edit
vim.keymap.set({ "i" }, "jk", "<Esc>")
vim.keymap.set({ "i" }, "kj", "<Esc>")
vim.keymap.set({ "i" }, "<A-o>", "<C-o>o")
vim.keymap.set({ "i" }, "<A-O>", "<C-o>O")
-- Avoid inputting unintended characters on Windows by using glazeWM
vim.keymap.set({ "i" }, "<F20>", "<NOP>")

vim.keymap.set({ "v" }, "I", function()
	if vim.api.nvim_get_mode().mode == "V" then
		return "<C-v>^o^I"
	else
		return "I"
	end
end, { expr = true })
vim.keymap.set({ "v" }, "A", function()
	if vim.api.nvim_get_mode().mode == "V" then
		return "<C-v>0o$A"
	else
		return "A"
	end
end, { expr = true })

--- motion
vim.keymap.set({ "n" }, "<up>", "<c-u>")
vim.keymap.set({ "n" }, "<down>", "<c-d>")

--- windows
---- jump between windows
vim.keymap.set({ "n" }, "<A-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<A-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<A-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<A-l>", "<C-w>l")
vim.keymap.set({ "i", "t" }, "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set({ "i", "t" }, "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set({ "i", "t" }, "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set({ "i", "t" }, "<A-l>", "<C-\\><C-N><C-w>l")

--- terminal
vim.keymap.set({ "t" }, "<Esc>", "<C-\\><C-n>")

---- move window to new tab
vim.keymap.set({ "n" }, "<A-t>", "<C-w>T")

---- tab
vim.keymap.set({ "n" }, "<leader>l", "gt")
vim.keymap.set({ "n" }, "<leader>h", "gT")

-- ------- --
-- Autocmd --
-- ------- --
local indent_group = vim.api.nvim_create_augroup("Indent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.o.shiftwidth = 2
		vim.o.tabstop = 2
	end,
	group = indent_group,
	pattern = "lua",
})

-- ---- --
-- Lazy --
-- ---- --

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"tris203/hawtkeys.nvim",
		cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("hawtkeys").setup({})
		end,
	},
	{
		"bfredl/nvim-luadev",
		cmd = "Luadev",
	},
	{
		"kevinhwang91/nvim-bqf",
	},
	{
		"echasnovski/mini.align",
		version = false,
		config = function()
			require("mini.align").setup({
				modifiers = {
					["|"] = function(steps, opts)
						opts.split_pattern = "|"
						table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
						opts.justify_side = "center"
						opts.merge_delimiter = " "
					end,
				},
			})
		end,
	},
	{
		"gennaro-tedesco/nvim-jqx",
		cmd = "JqxList",
		ft = { "json", "yaml" },
	},
	{
		"echasnovski/mini.trailspace",
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	{ "jghauser/follow-md-links.nvim" },
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "tpope/vim-unimpaired" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "farmergreg/vim-lastplace" },
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- Disable highlight automatic
	{ "romainl/vim-cool" },
	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<F1>", "<Cmd>ZenMode<CR>" },
		},
		opts = {
			plugins = {
				twilight = { enabled = false },
			},
		},
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local undotree = require("undotree")
			undotree.setup({
				window = {
					winblend = 0,
				},
			})
		end,
		keys = {
			{ "<F4>", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{ import = "plugins" },
}, {})
