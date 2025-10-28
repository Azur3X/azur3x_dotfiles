return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    -- Directory where session files are saved
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    -- Options for saving session
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
  keys = {
    {
      "<leader>qs",
      function() require("persistence").load() end,
      desc = "Restore Session"
    },
    {
      "<leader>ql",
      function() require("persistence").load({ last = true }) end,
      desc = "Restore Last Session"
    },
    {
      "<leader>qd",
      function() require("persistence").stop() end,
      desc = "Don't Save Current Session"
    },
  },
}
