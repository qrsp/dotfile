local colorscheme = {
	{
		"folke/tokyonight.nvim",
		cond = false,
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
		cond = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
        -- style = 'cool',
				highlights = {
					["@comment"] = { fg = "#878d99" },
				},
			})
			require("onedark").load()
		end,
	},
	{
		"catppuccin/nvim",
		cond = false,
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
	{
		"sainnhe/sonokai",
		cond = false,
    config = function ()
      local styless = { 'default', 'atlantis', 'andromeda', 'maia'}
      vim.g.sonokai_style = styless[math.random(5)]
      vim.g.sonokai_better_performance = 1
			vim.cmd.colorscheme("sonokai")
    end
	},
}

math.randomseed(vim.loop.now())
colorscheme[math.random(#colorscheme)]["cond"] = true
return colorscheme
