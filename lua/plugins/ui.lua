return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,

		config = function()
			require("kanagawa").setup({
				compile = true,
				transparent = false,
				dimInactive = true,
				theme = "wave",
				background = {
					dark = "wave",
					light = "lotus",
				},
				themes = {
					wave = {
						special = "#7fbbb3",
					},
				},

				overrides = function(colors)
					return {
						["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
						["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
						["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
						["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
						["@markup.list.markdown"] = { link = "Function" }, -- + list
						["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
						["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,

		build = function()
			vim.cmd("KanagawaCompile")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "snacks_dashboard", "neo-tree", "oil" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-mini/mini.icons", -- Carrega os ícones antes
		event = "VeryLazy", -- Carrega o plugin logo após o boot para não atrasar a inicialização
		opts = {
			options = {
				mode = "buffers", -- Mostra os buffers abertos como abas
				separator_style = "thin",
				numbers = "ordinal",
				indicator = { style = "icon", icon = "▎" },
				show_buffer_close_icons = true,
				show_close_icon = false,
				diagnostics = "nvim_lsp", -- Se o LSP apontar erro no arquivo, um ícone de alerta aparece na aba!
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer", -- Texto exibido acima da sidebar
						text_align = "left",
						separator = true,
						padding = 1,
					},
				},
			},
		},
	},
	{
		"nvim-mini/mini.icons",
		version = "*",
		opts = {},
		config = function()
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
