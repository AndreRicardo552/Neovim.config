vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "pt", "en" }
	end,
})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.lazy")
