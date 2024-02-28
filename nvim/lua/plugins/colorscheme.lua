local colorscheme = {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				on_colors = function(colors)
					colors.comment = "#888fac"
				end,
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				highlights = {
					["@comment"] = { fg = "#878d99" },
				},
			})
			require("onedark").load()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		init = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				highlight_overrides = {
					macchiato = function(macchiato)
						return {
							["@comment"] = { fg = macchiato.overlay0, style = { "italic" } },
							["@markup.link.label.markdown_inline"] = { fg = macchiato.green },
							["@markup.link.url.markdown_inline"] = {
								fg = macchiato.blue,
								style = { "italic", "underline" },
							},
						}
					end,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

math.randomseed(vim.loop.now())
return colorscheme[math.random(#colorscheme)]
