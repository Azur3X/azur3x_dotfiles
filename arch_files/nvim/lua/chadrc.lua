-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 
---@type ChadrcConfig
local M = {}
M.base46 = {
	theme = "onedark",
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local raw = {
  "                     ,_ ,_==▄▂",
  "                  ,  ▂▃▄▄▅▅▅▂▅¾.            /    /",
  "                   ▄▆<´  \"»▓▓▓%\\       / /   / /",
  "                 ,▅7\"     ´>▓▓▓%   /  / > / >/%",
  "                 ▐¶▓       ,»▓▓¾´  /> %/%// /  /",
  "                  ▓▃▅▅▅▃,,▄▅▅▅Æ\\// ///>// />/   /",
  "                 V║«¼.;→ ║<«.,`=// />//%/% / /",
  "               //╠<´ -²,)(▓~\"-╝/¾/ %/>/ />",
  "           / / / ▐% -./▄▃▄▅▐, /7//;//% / /",
  "           / ////`▌▐ %zWv xX▓▇▌//&;% / /",
  "       / / / %//%/¾½´▌▃▄▄▄▄▃▃▐¶\\/& /",
  "         </ /</%/`▓!%▓%╣;╣WY<Y)y&/`\\",
  "     / / %/%//</%//\\i7; ╠N>)VY>7;  \\_",
  "  /   /</ //<///<_/%\\▓  V%W%£)XY  _/%‾\\_,",
  "   / / //%/_,=--^/%/%%\\¾%¶%%}    /%%%%%%;\\,",
  "    %/< /_/ %%%%%;X%%\\%%;,     _/%%%;,     \\",
  "   / / %%%%%%;,    \\%%l%%;// _/%;, dmr",
  " /    %%%;,         <;\\-=-/ /",
  "     ;,                l",
  "        UNIX IS VERY SIMPLE IT JUST NEEDS A",
  "        GENIUS TO UNDERSTAND ITS SIMPLICITY",
}

local max_w = 0
for _, l in ipairs(raw) do
  local w = vim.api.nvim_strwidth(l)
  if w > max_w then max_w = w end
end

local header = {}
for _, l in ipairs(raw) do
  local pad = max_w - vim.api.nvim_strwidth(l)
  table.insert(header, l .. string.rep(" ", pad))
end

M.nvdash = {
  load_on_startup = true,
  header = header,
}

return M
