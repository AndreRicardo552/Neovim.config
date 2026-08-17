<<<<<<< HEAD
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "pt", "en" }
	end,
})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

=======
>>>>>>> 1826e8c2e143433014b08f2e372b7f67294cdf0a
require("config.lazy")
