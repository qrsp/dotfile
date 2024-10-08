return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		lazy = true,
		config = function()
			vim.g.mkdp_auto_close = true
			vim.g.mkdp_refresh_slow = true
			vim.g.mkdp_open_to_the_world = false
			vim.g.mkdp_open_ip = "127.0.0.1"
			vim.g.mkdp_port = "8888"
			vim.g.mkdp_browser = ""
			vim.g.mkdp_echo_preview_url = true
			vim.g.mkdp_page_title = "${name}"
		end,
	},
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Mandatory
        'nvim-tree/nvim-web-devicons', -- Optional but recommended
    },
  },
}
