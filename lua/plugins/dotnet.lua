return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		ft = { "cs", "fsharp" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim",
		},
		opts = {
			-- Desativa o LSP embutido do easy-dotnet para evitar duplicidade com o roslyn.nvim
			lsp = {
				enabled = false,
			},
			picker = "snacks",
			terminal = function(path, action, args)
				local commands = {
					run = function()
						return string.format("dotnet run --project %s %s", path, args or "")
					end,
					test = function()
						return string.format("dotnet test %s %s", path, args or "")
					end,
					restore = function()
						return string.format("dotnet restore %s %s", path, args or "")
					end,
					build = function()
						return string.format("dotnet build %s %s", path, args or "")
					end,
				}
				local command = commands[action]() .. "\r"
				vim.cmd("vsplit term://" .. command)
			end,
			secrets = {
				path = vim.fn.expand("~/.microsoft/usersecrets"),
			},
			dap = {
				adapter = {
					type = "executable",
					command = "netcoredbg",
					args = { "--interpreter=vsdap" },
				},
			},
		},
		config = function(_, opts)
			local dotnet = require("easy-dotnet")
			dotnet.setup(opts)

			local map = vim.keymap.set
			map("n", "<leader>dr", function()
				dotnet.run()
			end, { silent = true, desc = ".NET: Run" })
			map("n", "<leader>db", function()
				dotnet.build_solution_quickfix()
			end, { silent = true, desc = ".NET: Build (Quickfix)" })
			map("n", "<leader>dt", function()
				dotnet.test_solution()
			end, { silent = true, desc = ".NET: Test Solution" })
			map("n", "<leader>dd", function()
				dotnet.debug()
			end, { silent = true, desc = ".NET: Debug Picker" })
			map("n", "<leader>dw", function()
				dotnet.watch()
			end, { silent = true, desc = ".NET: Watch Project" })
		end,
	},
}
