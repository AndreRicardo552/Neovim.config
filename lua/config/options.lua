-- nvim config
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Editor config
vim.opt.number = true
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"

-- Configuração Global (Bom para C, C#, Markdown)
vim.opt.expandtab = false -- Transforma Tab em espaços
vim.opt.shiftwidth = 4 -- Tamanho do Tab = 4 espaços
vim.opt.tabstop = 4 -- Tamanho do Tab visual = 4 espaços

-- A SALVAÇÃO DO MAKEFILE: Regra de exceção automática
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false -- NÃO transforma Tab em espaços dentro de Makefiles
		vim.opt_local.tabstop = 4 -- Mantém o alinhamento visual em 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- File config
vim.o.undofile = true
