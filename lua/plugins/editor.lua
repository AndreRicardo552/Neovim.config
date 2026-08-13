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
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = {
				"icon",
				"size",
			},
		},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		lazy = false,

		config = function(_, opts)
			require("oil").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = false },
			indent = {
				enabled = true,
				only_scope = true,
				exclude = {
					filetypes = {
						"neo-tree",
						"neo-tree-popup",
						"oil",
						"notify",
						"toggleterm",
						"lazy",
						"mason",
					},
					buftypes = {
						"nofile",
						"terminal",
						"prompt",
					},
				},
			},
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			terminal = {
				enabled = true,
				shell = "bash",
				win = {
					style = "terminal",
					position = "bottom",
					height = 0.4,
				},
			},
		},

		keys = {
			-- 🔍 Atalhos essenciais para o Buscador (Picker)
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Buscar Arquivos",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Buscar Texto (Grep)",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Listar Arquivos Abertos",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Arquivos Recentes",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Buscar Símbolos (LSP)",
			},

			-- 🪟 Atalho útil para fechar abas com segurança usando o buffer core do Snacks
			{
				"<leader>x",
				function()
					Snacks.bufdelete()
				end,
				desc = "Fechar Aba Sem Quebrar Janela",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
