require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Terminal mappings
map('n', '<leader>th', ':split | terminal<CR>', { desc = 'Terminal horizontal split' })
map('n', '<leader>tv', ':vsplit | terminal<CR>', { desc = 'Terminal vertical split' })

-- Exit terminal mode with double Esc (much better than Ctrl-\ Ctrl-n)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navigate FROM terminal to other windows without exiting terminal mode first
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: move to left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: move to bottom window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: move to top window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: move to right window' })
