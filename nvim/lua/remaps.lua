local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- window
map({ "n", "x" }, "<S-w>", "<C-w>", { desc = "window command mode" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "next buffer", noremap = true })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "previous buffer", noremap = true })
map({ "n", "x" }, "<leader>w", ":w<cr>", { desc = "write buffer" })
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "close current buffer" })

-- files
map("n", "<C-s>", "<cmd>w<CR>", { desc = "save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "copy entire file to clipboard" })

-- clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without yanking" })

-- movement
map({ "n", "x" }, "<C-d>", "<C-d>zz")
map({ "n", "x" }, "<C-u>", "<C-u>zz")
map({ "n", "x" }, "U", vim.cmd.redo, { desc = "redo" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
map("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
-- map("n", "Q", "<nop>", { desc = "disable Ex mode" })
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "previous quickfix item" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "clear search highlights" })

-- Swap : and ; functionality
vim.keymap.set({ "n", "x" }, ";", ":", { noremap = true, desc = "Enter command mode" })
vim.keymap.set({ "n", "x" }, ":", ";", { noremap = true, desc = "Repeat last f/F/t/T" })

-- run task

-- vim.keymap.set("n", "<leader>r", function()
-- 	local ext = vim.fn.expand("%:e")
-- 	local output
-- 	if ext == "py" then
-- 		output = vim.fn.system("pytest main.py")
-- 		-- vim.notify(output, vim.log.levels.INFO, { title = "pytest output" })
-- 	else
-- 		output = vim.fn.system("task")
-- 		-- vim.notify(output, vim.log.levels.INFO, { title = "task output" })
-- 	end
-- end, { silent = false, desc = "Run pytest or task based on file type" })
