return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- Mapeamento das linguagens que você vai usar:
		formatters_by_ft = {
			-- 1. Ecossistema .NET / C#
			cs = { "csharpier" }, -- Arquivos de código C# (.cs)
			xml = { "xmlformatter" }, -- Muito útil para arquivos .csproj ou .axaml

			-- 2. Configurações e Scripts do Editor
			lua = { "stylua" }, -- Para formatar os arquivos do próprio Neovim
			sh = { "shfmt" }, -- Scripts shell (.sh / Bash)

			-- 3. Ecossistema Web & Frontend (Se precisar mexer em APIs/Web)
			-- A flag 'stop_after_first = true' testa o mais rápido instalado e para nele
			javascript = { "prettier", "prettierd", stop_after_first = true },
			typescript = { "prettier", "prettierd", stop_after_first = true },
			json = { "prettier", "prettierd", stop_after_first = true },
			html = { "prettier", "prettierd", stop_after_first = true },
			css = { "prettier", "prettierd", stop_after_first = true },

			-- 4. Formatação de fallback global
			-- Aplica em qualquer tipo de arquivo não listado acima para limpar o código
			["_"] = { "trim_whitespace", "trim_newlines" },
		},

		format_on_save = {
			timeout_ms = 1000, -- C# pode precisar de mais tempo (1s) em arquivos grandes
			lsp_format = "fallback", -- Se o CSharpier sumir, o Roslyn tenta formatar
		},
	},
}
