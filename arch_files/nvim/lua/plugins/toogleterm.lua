return {
  'akinsho/toggleterm.nvim',
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal float' },
    { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Terminal horizontal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Terminal vertical' },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = '/usr/sbin/fish',
    float_opts = {
      border = 'curved',
      winblend = 0,
    },
  },
}
