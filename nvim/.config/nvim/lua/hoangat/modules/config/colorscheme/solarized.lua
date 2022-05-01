vim.g.solarized_italics = 1
vim.g.solarized_visibility = "normal"
vim.g.solarized_diffmode = "normal"
vim.g.solarized_statusline = "high"
vim.g.solarized_termtrans = 1

-- To enable transparency
-- if vim.fn.has "gui_running" == 0 then
--   vim.g.solarized_termtrans = 0
-- else
--   vim.g.solarized_termtrans = 1
-- end

vim.cmd "colorscheme solarized"

local fg = require("hoangat.core.utils").fg
local fg_bg = require("hoangat.core.utils").fg_bg
local bg = require("hoangat.core.utils").bg

if vim.g.solarized_termtrans == 1 then
  bg("GitSignsAdd", "NONE")
  bg("GitSignsChange", "NONE")
  bg("GitSignsDelete", "NONE")
  bg("CursorLine", "#073642")
  bg("CursorLineNr", "#073642")

  bg("LineNr", "NONE")
  vim.cmd [[
    hi illuminatedWord guibg=NONE gui=bold
   ]]
  -- hi LspReference guibg=#839496
  -- hi LspReferenceRead guibg=#053542
  -- hi LspReferenceText guibg=#053542 gui=NONE
  -- hi LspReferenceWrite guibg=#053542
end
