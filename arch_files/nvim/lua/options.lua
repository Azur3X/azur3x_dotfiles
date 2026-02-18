require "nvchad.options"

-- add yours here!
vim.env.LANG = "en_US.UTF-8"

local o = vim.o

-- Tab settings
o.tabstop = 4      -- Number of spaces a <Tab> character displays as
o.shiftwidth = 4   -- Number of spaces for each indent level
o.softtabstop = 4  -- Number of spaces for <Tab> in insert mode
o.expandtab = true -- Convert tabs to spaces

-- o.cursorlineopt ='both' -- to enable cursorline!
