return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		sync_install = false,
		indent = { enable = true }, ---@type lazyvim.TSFeat
		highlight = { enable = true }, ---@type lazyvim.TSFeat
		folds = { enable = true }, ---@type lazyvim.TSFeat
		auto_install = true,
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vin",
			"vimdoc",
			"xml",
			"yaml",
		},
	},

	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
	end,
}
