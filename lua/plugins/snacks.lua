return {
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
}
