-- Wallpaper hues (volcano/eruption) lifted to readable luminance for syntax.
-- Dark tones reserved for UI chrome only.
-- All dim elements lifted significantly to account for 0.9 kitty transparency.

local M = {}

M.base_30 = {
  white         = "#d0d0d0",
  darker_black  = "#070509",
  black         = "#0d090e",  -- nvim bg
  black2        = "#130d14",
  one_bg        = "#1a1015",
  one_bg2       = "#221520",
  one_bg3       = "#2a1a28",
  grey          = "#3d2535",
  grey_fg       = "#5a3a4a",
  grey_fg2      = "#6a4a5a",
  light_grey    = "#c49aaa",  -- line numbers
  red           = "#e83a1a",
  baby_pink     = "#ff5533",
  pink          = "#ff7755",
  line          = "#1a1015",
  green         = "#c4845a",
  vibrant_green = "#d49060",
  nord_blue     = "#884422",
  blue          = "#aa5533",
  yellow        = "#ff9933",
  sun           = "#ffbb55",
  purple        = "#2a0f2a",
  dark_purple   = "#1a081a",
  teal          = "#773344",
  orange        = "#ff6600",
  cyan          = "#ffaa44",
  statusline_bg = "#0f080f",
  lightbg       = "#1a1015",
  pmenu_bg      = "#8b0000",
  folder_bg     = "#e83a1a",
  lavender      = "#d0d0d0",
}

M.base_16 = {
  base00 = "#0d090e",  -- background
  base01 = "#130d14",
  base02 = "#1a1015",
  base03 = "#2a1a28",
  base04 = "#c49aaa",  -- comments
  base05 = "#d0d0d0",  -- foreground: silver
  base06 = "#e8e8e8",
  base07 = "#f5f5f5",
  base08 = "#d0d0d0",  -- variables/identifiers: silver
  base09 = "#ff9933",  -- integers, constants: orange-gold
  base0A = "#ff5533",  -- classes, attributes: hot red-orange
  base0B = "#c4845a",  -- strings: warm ember ochre
  base0C = "#ffcc55",  -- escape chars, regex: bright gold
  base0D = "#ffaa44",  -- functions: amber
  base0E = "#e83a1a",  -- keywords: vivid crimson
  base0F = "#881100",  -- deprecated: dark blood red
}

M.polish_hl = {
  defaults = {
    LineNr       = { fg = "#c49aaa" },
    LineNrAbove  = { fg = "#c49aaa" },
    LineNrBelow  = { fg = "#c49aaa" },
    CursorLineNr = { fg = "#ffaa44", bold = true },
    Comment      = { fg = "#c49aaa", italic = true },
  },
  treesitter = {
    ["@comment"] = { fg = "#c49aaa", italic = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "azur3x")

return M
