local kanagawa = safe_require "kanagawa"
if not kanagawa then
  return
end

local default_colors = require("kanagawa.colors").setup()

local overrides = {
  IndentBlanklineContextChar = { fg = default_colors.surimiOrange },
}

vim.opt.laststatus = 3
vim.opt.fillchars:append {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
}
require("kanagawa").setup { globalStatus = true, ... }

-- Default options:
kanagawa.setup {
  undercurl = true, -- enable undercurls
  commentStyle = "italic",
  functionStyle = "NONE", -- default: NONE
  keywordStyle = "italic",
  statementStyle = "bold",
  typeStyle = "NONE",
  variablebuiltinStyle = "italic",
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = true, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  globalStatus = true, -- adjust window separators highlight for laststatus=3
  colors = {},
  overrides = overrides,
}

-- setup must be called before loading
vim.cmd "colorscheme kanagawa"

local colors = require("kanagawa.colors").setup()

vim.cmd "hi FocusedSymbol guibg=#FFA066 guifg=#16161D gui=italic,bold"

local fg = require("hoangat.core.utils").fg
local fg_bg = require("hoangat.core.utils").fg_bg
local bg = require("hoangat.core.utils").bg

-- Telescope
fg_bg("TelescopeBorder", colors.sumiInk1b, colors.sumiInk1b)
fg_bg("TelescopePromptBorder", colors.sumiInk2, colors.sumiInk2)

fg_bg("TelescopePromptNormal", colors.fujiWhite, colors.sumiInk2)
fg_bg("TelescopePromptPrefix", colors.oniViolet, colors.sumiInk2)

bg("TelescopeNormal", colors.sumiInk1b)

fg_bg("TelescopePromptTitle", colors.sumiInk1, colors.oniViolet)
fg_bg("TelescopePreviewTitle", colors.sumiInk1, colors.autumnRed)
fg_bg("TelescopeResultsTitle", colors.sumiInk1b, colors.sumiInk1b)
fg_bg("TelescopeSelection", colors.surimiOrange, colors.waveBlue1)

-- ToggleTerm
bg("ToggleTerm1NormalFloat", colors.sumiInk1)

-- HopNextKey
vim.cmd [[
  hi HopNextKey guifg = #E6C384 gui=bold
  hi HopNextKey1 guifg = #E6C384 gui=bold
  hi HopNextKey2 guifg = #E6C384 gui=bold


  hi PounceMatch guifg=#1f1f28 guibg=#DCD7BA
  hi PounceGap guifg=#1f1f28 guibg=#727169
  hi PounceAccept guifg=#ffffff guibg=#2D4F67 gui=bold
  hi PounceAcceptBest guifg=#ffffff guibg=#E82424 gui=bold
]]
