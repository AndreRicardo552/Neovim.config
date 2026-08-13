return {
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		opts = {},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			user_default_options = {
				tailwind = true,
				css = true,
				names = false,
			},
		},
	},
}
