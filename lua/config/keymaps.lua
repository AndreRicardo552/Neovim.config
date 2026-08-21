vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

vim.keymap.set("n", "<C-space>", function()
	-- Abre o modo visual e aciona a expansão do nó do Treesitter imediatamente
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("van", true, false, true), "m", false)
end, { desc = "Treesitter: Iniciar Seleção Incremental" })

-- 2. No Modo Visual: Ctrl+Espaço expande o bloco (Simula o 'an' nativo)
vim.keymap.set("x", "<C-space>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("an", true, false, true), "x", false)
end, { desc = "Treesitter: Expandir Seleção" })

-- 3. No Modo Visual: Backspace contrai o bloco (Simula o 'in' nativo)
vim.keymap.set("x", "<BS>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("in", true, false, true), "x", false)
end, { desc = "Treesitter: Contrair Seleção" })

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar arquivo" })

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Fechar" })

-- Navegar entre as abas (buffers) mantendo o Tab livre para o Blink
vim.keymap.set("n", "<C-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Próxima Aba" })
vim.keymap.set("n", "<C-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Aba Anterior" })

-- Toggle seguro para o Terminal (Modo Normal e Modo Terminal sem sequestrar o espaço):
vim.keymap.set("n", "<leader>/", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<C-/>", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })

-- Elimina a disputa do prefixo gr no Neovim 0.12+
pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "gri")
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "grt")
pcall(vim.keymap.del, "n", "grx")
pcall(vim.keymap.del, "n", "grn")
