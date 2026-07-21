return {
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
}
