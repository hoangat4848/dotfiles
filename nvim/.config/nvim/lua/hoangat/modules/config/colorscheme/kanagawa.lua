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
  transparent = false, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  globalStatus = true, -- adjust window separators highlight for laststatus=3
  colors = {},
  overrides = overrides,
}

-- setup must be called before loading
vim.cmd "colorscheme kanagawa"

vim.cmd "hi FocusedSymbol guibg=#FFA066 guifg=#16161D gui=italic,bold"
