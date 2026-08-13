return {
	{
		"nvim-mini/mini.ai",
		version = "*",
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		opts = {
			preview = {
				icon_provider = "mini", -- "mini" or "devicons"
			},
		},

		config = function(_, opts)
			require("markview").setup(opts)
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- Usa Treesitter para checar contextos (evita fechar dentro de strings/comentários)
				map_cr = false, -- Desabilita o mapeamento padrão do Enter para não conflitar com o Blink
			})
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
}
