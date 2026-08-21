return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			-- 1. Configuração do LspAttach (Mapeamentos e Autocomandos)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("ConfiguracaoLSPUniversal", { clear = true }),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					-- Atalhos Nativos / Customizados
					opts.desc = "LSP: Ir para Definição (F12)"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

					opts.desc = "LSP: Mostrar Documentação/Hover"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "LSP: Renomear Variável"
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "LSP: Ações de Código"
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					-- Integração Fluida com o SNACKS.NVIM
					opts.desc = "Snacks: Buscar Referências da Função"
					vim.keymap.set("n", "gr", function()
						Snacks.picker.lsp_references()
					end, opts)

					opts.desc = "Snacks: Buscar Definições do Arquivo"
					vim.keymap.set("n", "gI", function()
						Snacks.picker.lsp_implementations()
					end, opts)

					-- Ativar Inlay Hints se o servidor suportar
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client:supports_method("textDocument/inlayHint", ev.buf) then
						opts.desc = "[T]oggle Inlay [H]ints"
						vim.keymap.set("n", "<leader>th", function()
							local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
							vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = ev.buf })
						end, opts)
					end
				end,
			})

			-- Configuração da interface de Diagnósticos (Erros, Avisos, etc.)
			vim.diagnostic.config({
				-- Atualiza os diagnósticos enquanto você digita no modo insert
				update_in_insert = false,

				-- Configuração da Sign Column (a coluna à esquerda)
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ", -- Ícone de Erro
						[vim.diagnostic.severity.WARN] = " ", -- Ícone de Aviso
						[vim.diagnostic.severity.INFO] = " ", -- Ícone de Informação
						[vim.diagnostic.severity.HINT] = "󰌵", -- Ícone de Dica
					},
				},

				-- Configuração do texto virtual (aquela mensagem de erro no fim da linha)
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●", -- Pode trocar por outro ícone se preferir
				},

				-- Sublinhado no código onde está o erro
				underline = true,
			})

			-- 2. Configuração do Mason Tool Installer
			require("mason-tool-installer").setup({
				ensure_installed = {
					"cmakelint",
					"cmakelang",
					"netcoredbg",
					"bash-debug-adapter",
					"angular-language-server",
					"bash-language-server",
					"clangd",
					"css-lsp",
					"html-lsp",
					"lua-language-server",
					"neocmakelsp",
					"typescript-language-server",
					"vim-language-server",
					"yaml-language-server",
					"clang-format",
					"codespell",
					"csharpier",
					"eslint_d",
					"jsonlint",
					"luacheck",
					"markdownlint",
					"prettier",
					"shellcheck",
					"shfmt",
					"stylua",
					"typos-lsp",
				},
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
			})

			-- 3. Lista de servidores e capacidades (Capabilities)
			local original_capabilities = vim.lsp.protocol.make_client_capabilities()
			original_capabilities.workspace = original_capabilities.workspace or {}
			original_capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = true,
			}
			local default_capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

			local servers = {
				angularls = {},
				bashls = {},
				clangd = {},
				cssls = {},
				html = {},
				lua_ls = {},
				neocmake = {},
				ts_ls = {},
				typos_lsp = {},
				vimls = {},
				yamlls = {},
			}

			-- 4. Inicialização dos servidores de forma segura
			for name, server_config in pairs(servers) do
				-- Injeta as capacidades baseadas no seu motor de completion
				server_config.capabilities =
					vim.tbl_deep_extend("force", {}, default_capabilities, server_config.capabilities or {})

				-- Usando pcall para tratar falhas de inicialização de LSPs específicos,
				-- corrigindo a intenção original do bloco "if not status"
				local ok, err = pcall(function()
					vim.lsp.config(name, server_config)
					vim.lsp.enable(name)
				end)

				if not ok then
					vim.schedule(function()
						vim.api.nvim_echo(
							{ { "Erro no Setup do LSP [" .. name .. "]: " .. tostring(err), "ErrorMsg" } },
							true,
							{}
						)
					end)
				end
			end
		end,
	},
	{
		"seblj/roslyn.nvim",
		ft = { "cs", "razor" },
		opts = function()
			return {
				config = {
					capabilities = default_capabilities,
					settings = {
						["csharp|inlay_hints"] = {
							csharp_enable_inlay_hints_for_implicit_object_creation = true,
							csharp_enable_inlay_hints_for_implicit_variable_types = true,
							csharp_enable_inlay_hints_for_lambda_parameter_types = true,
							csharp_enable_inlay_hints_for_types = true,
						},
						["csharp|symbol_search"] = {
							dotnet_search_reference_assemblies = true,
						},
					},
				},
				exe = {
					"roslyn-language-server",
				},
				broad_search = true,
			}
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"windwp/nvim-autopairs",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				-- Mostra o texto fantasma cinza estilo Copilot/VS Code
				ghost_text = { enabled = true },

				-- Menu flutuante de sugestões
				menu = {
					draw = {
						-- Organiza as colunas: Ícone | Nome da sugestão | Tipo (Method, Variable, etc)
						columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 } },
					},
				},

				-- Janela de Documentação (Mostra o "Hover" do código ao navegar pelas opções)
				documentation = {
					auto_show = true, -- Mostra automaticamente ao navegar
					auto_show_delay_ms = 200, -- Pequeno delay para não poluir a tela ao passar rápido
					window = { border = "rounded" },
				},
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`

			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
