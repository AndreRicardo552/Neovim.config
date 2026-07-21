return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-mini/mini.icons", -- Carrega os ícones antes
	event = "VeryLazy", -- Carrega o plugin logo após o boot para não atrasar a inicialização
	opts = {
		options = {
			mode = "buffers", -- Mostra os buffers abertos como abas
			separator_style = "slant", -- Estilo cyberpunk inclinado nas divisórias (combina muito com o Tokyo Night)
			show_buffer_close_icons = true,
			show_close_icon = false,
			diagnostics = "nvim_lsp", -- Se o LSP apontar erro no arquivo, um ícone de alerta aparece na aba!
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer", -- Texto exibido acima da sidebar
					text_align = "left",
					separator = true,
				},
			},
		},
	},
}
