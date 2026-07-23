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
			"cmake",
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
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ao"] = "@comment.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	},

	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
	end,
}
