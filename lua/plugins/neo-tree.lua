return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.icons",
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
			use_libuv_file_watcher = true,

			default_component_configs = {
				name = {
					use_git_status_colors = true,
				},
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "󰉋",
					folder_open = "󰝰",
					folder_empty = "󰉖",
					default = "",
				},
			},

			window = {
				width = 30,
				position = "left",
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
				bind_to_cwd = false,
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				window = {
					mappings = {
						["<space>"] = "toggle_node",
					},
				},
				hijack_netrw_behavior = "open_current",
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
}
