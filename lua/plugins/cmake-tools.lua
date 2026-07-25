return {
	{
		"Civitasv/cmake-tools.nvim",
		ft = { "c", "cpp", "objc", "objcpp", "cuda" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
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
				termina = "integrated",
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
}
