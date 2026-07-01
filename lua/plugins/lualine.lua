return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim.mini/mini.icons" },
	opts = {
		theme = "tokyonight-moon",
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
