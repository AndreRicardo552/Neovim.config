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
vim.opt.cursorlineopt = "number"
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "",
	foldsep = " ",
	foldclose = "",
}
vim.opt.splitkeep = "screen"

-- Configuração Global (Bom para C, C#, Markdown)
vim.opt.expandtab = false -- Transforma Tab em espaços
vim.opt.shiftwidth = 4 -- Tamanho do Tab = 4 espaços
vim.opt.tabstop = 4 -- Tamanho do Tab visual = 4 espaços

-- File config
vim.o.undofile = true
