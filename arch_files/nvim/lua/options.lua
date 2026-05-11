require "nvchad.options"

-- add yours here!
vim.env.LANG = "en_US.UTF-8"

local o = vim.o

-- Tab settings
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-- Display
o.relativenumber = true
o.scrolloff = 8
o.colorcolumn = "80"

vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = 0,
}

vim.ui.open = function(path)
  vim.fn.jobstart({"xdg-open", path}, {detach = true})
end
-- o.cursorlineopt ='both' -- to enable cursorline!
