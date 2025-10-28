require "nvchad.autocmds"

-- Add to your existing autocmds.lua
local autocmd = vim.api.nvim_create_autocmd

-- Auto-enter insert mode when switching to terminal
autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd('startinsert')
  end,
  desc = 'Terminal setup: no numbers, auto insert mode'
})

-- Auto insert when entering terminal buffer
autocmd('BufEnter', {
  pattern = 'term://*',
  callback = function()
    vim.cmd('startinsert')
  end,
  desc = 'Auto insert mode when entering terminal'
})
