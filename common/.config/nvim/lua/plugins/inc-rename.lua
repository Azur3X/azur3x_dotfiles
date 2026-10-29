return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "LSP: Incremental rename",
    },
  },
  opts = {
    input_buffer_type = "dressing",
  },
}
