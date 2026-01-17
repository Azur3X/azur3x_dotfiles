return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    lazy = false,
    config = function()
      require('distant'):setup {
        -- Optional: configure settings
        ['*'] = {
          -- Use SSH by default
          ssh = {
            -- Can add default SSH options here
          }
        }
      }
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "haskell",
        "c",
        "cpp",
        "python",
        "bash",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
  },
}
