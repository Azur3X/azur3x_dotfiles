require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Better save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window: Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: Move right" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Window: Increase height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Window: Decrease height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Window: Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Window: Increase width" })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Buffer: Next" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Buffer: Previous" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent: Decrease (stay in visual)" })
map("v", ">", ">gv", { desc = "Indent: Increase (stay in visual)" })

-- Better paste (don't overwrite register)
map("v", "p", '"_dP', { desc = "Paste: Without yanking" })

-- Terminal mappings
map('n', '<leader>th', ':split | terminal<CR>', { desc = 'Terminal: Horizontal split' })
map('n', '<leader>tv', ':vsplit | terminal<CR>', { desc = 'Terminal: Vertical split' })

-- Exit terminal mode with double Esc
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal: Exit insert mode' })

-- Navigate FROM terminal to other windows
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: Move to left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: Move to bottom window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: Move to top window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: Move to right window' })

-- LSP Telescope integration (when in LSP-attached buffer)
map('n', '<leader>ls', ':Telescope lsp_document_symbols<CR>', { desc = 'LSP: Document symbols' })
map('n', '<leader>lw', ':Telescope lsp_dynamic_workspace_symbols<CR>', { desc = 'LSP: Workspace symbols' })
map('n', '<leader>ld', ':Telescope diagnostics<CR>', { desc = 'LSP: Diagnostics' })

-- Quick diagnostic jump to errors/warnings only
map('n', '[e', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Diagnostic: Previous error' })
map('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Diagnostic: Next error' })

-- Clear search highlighting
map('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })
