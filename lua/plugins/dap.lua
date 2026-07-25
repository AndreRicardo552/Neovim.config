return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.defaults.fallback.terminal_win_cmd = "belowright 12split new"

			-- Inicializa a interface visual do DAP
			dapui.setup()

			-- Instala e configura automaticamente o adaptador de depuração (codelldb para C/C++)
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"codelldb", -- C, C++ e Rust
					"netcoredbg", -- C# (.NET)
					"js-debug-adapter", -- JS/TS (Node, Bun, NestJS, Express)
				},
				automatic_installation = true,
				handlers = {
					function(config)
						-- Registra automaticamente os adaptadores instalados pelo Mason no nvim-dap
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- Abre o dap-ui automaticamente ao iniciar o debug e fecha ao finalizar
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		keys = {
			{
				"<leader>dq",
				function()
					require("dapui").close()
				end,
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
		},
	},
}
