return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.icons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself

		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
		},
		opts = {

			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,

			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},

			window = {
				width = 30,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["<cr>"] = "open",
					["v"] = "open_vsplit",
					["s"] = "open_split",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["q"] = "close_window",
				},
			},

			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				hijack_netrw_behavior = "open_current",
			},
			config = function(_, opts)
				require("neo-tree").setup(opts)
			end,
		},
	},
}
