return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim", -- Gerencia o download dos adaptadores via Mason
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Garante a instalacao dos depuradores necessarios pelo Mason
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "netcoredbg", "js-debug-adapter", "debugpy" },
				automatic_installation = true,
			})

			dapui.setup()

			-- 1. BASE UNIVERSAL: O Terminal TTY Unificado do Neovim
			dap.defaults.fallback.terminal_win_cmd = "belowright 12new"

			-- Automacao da interface visual DAP UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- =====================================================================
			-- 2. MATRIZ DE CONFIGURAÇÕES MULTI-LINGUAGEM
			-- =====================================================================

			-- ---------------------------------------------------------------------
			-- C / C++ / RUST (codelldb)
			-- ---------------------------------------------------------------------
			local codelldb_config = {
				{
					name = "Executar C/C++/Rust (Terminal Interativo)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/build/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					runInTerminal = true, -- Chave TTY para codelldb
				},
			}
			dap.configurations.c = codelldb_config
			dap.configurations.cpp = codelldb_config
			dap.configurations.rust = codelldb_config

			-- ---------------------------------------------------------------------
			-- C# (.NET / netcoredbg)
			-- ---------------------------------------------------------------------
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Executar C# (Terminal Interativo)",
					request = "launch",
					program = function()
						return vim.fn.input("Caminho da DLL (.dll): ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
					end,
					cwd = "${workspaceFolder}",
					console = "integratedTerminal", -- Chave TTY para .NET coreclr
				},
			}

			-- ---------------------------------------------------------------------
			-- JAVASCRIPT / TYPESCRIPT (js-debug-adapter / Node)
			-- ---------------------------------------------------------------------
			local js_config = {
				{
					type = "pwa-node",
					name = "Executar Node/JS/TS (Terminal Interativo)",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal", -- Chave TTY para Node
				},
			}
			dap.configurations.javascript = js_config
			dap.configurations.typescript = js_config

			-- ---------------------------------------------------------------------
			-- PYTHON (debugpy)
			-- ---------------------------------------------------------------------
			dap.configurations.python = {
				{
					type = "python",
					name = "Executar Python (Terminal Interativo)",
					request = "launch",
					program = "${file}",
					console = "integratedTerminal", -- Chave TTY para Python
				},
			}
		end,
	},
	{
		"Civitasv/cmake-tools.nvim",
		ft = { "c", "cpp", "objc", "objcpp", "cuda" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			cmake_build_directory = "build",
			-- Garante a geração do compile_commands.json para o clangd/LSP funcionar perfeitamente
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_dap_configuration = {
				name = "CMake Debug",
				type = "codelldb", -- Usa o adaptador instalado pelo mason-nvim-dap
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal",
			},
		},
		keys = {
			{ "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
			{ "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
			{ "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
			{ "<leader>cs", "<cmd>CMakeSelectTarget<cr>", desc = "CMake Select Target" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Other neotest dependencies here
			"orjangj/neotest-ctest",
			"nsidorenco/neotest-vstest",
		},
		config = function()
			-- Optional, but recommended, if you have enabled neotest's diagnostic option
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Convert newlines, tabs and whitespaces into a single whitespace
						-- for improved virtual text readability
						local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				adapters = {
					-- Load with default config
					require("neotest-ctest").setup({}),
					require("neotest-vstest"),
				},
			})
		end,
	},
}
