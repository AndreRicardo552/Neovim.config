return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			-- Mapeamento das linguagens que você vai usar:
			formatters_by_ft = {
				-- 1. Ecossistema .NET / C#
				cs = { "csharpier" }, -- Arquivos de código C# (.cs)
				fsharp = { "fantomas" },
				xml = { "xmlformatter" }, -- Muito útil para arquivos .csproj ou .axaml

				-- 2. Configurações e Scripts do Editor
				lua = { "stylua" }, -- Para formatar os arquivos do próprio Neovim
				sh = { "shfmt" }, -- Scripts shell (.sh / Bash)

				-- 3. Ecossistema Web & Frontend (Se precisar mexer em APIs/Web)
				-- A flag 'stop_after_first = true' testa o mais rápido instalado e para nele
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },

				-- C e C++
				cmake = { "cmake_format" },
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- python
				python = {},

				-- 4. Formatação de fallback global
				-- Aplica em qualquer tipo de arquivo não listado acima para limpar o código
				["_"] = { "trim_whitespace", "trim_newlines" },
			},

			format_on_save = {
				timeout_ms = 1000, -- C# pode precisar de mais tempo (1s) em arquivos grandes
				lsp_format = "fallback", -- Se o CSharpier sumir, o Roslyn tenta formatar
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
		config = function()
			local lint = require("lint")

			-- Define linters by file type
			lint.linters_by_ft = {
				-- Linters específicos por linguagem
				cmake = { "cmakelint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				json = { "jsonlint" },
				lua = { "luacheck" },
				markdown = { "markdownlint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },

				-- Linters globais/genéricos
				-- O "*" aplica o linter em qualquer tipo de arquivo (global)
				["*"] = { "codespell" },
			}

			-- Create an autocommand to trigger linting automatically
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run linter if nvim-lint is available
					lint.try_lint()
				end,
			})
		end,
	},
}
