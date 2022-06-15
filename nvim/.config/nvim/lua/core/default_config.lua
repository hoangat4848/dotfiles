-- IMPORTANT NOTE : This is default config, so dont change anything here.
-- chadrc overrides this file

local M = {}

M.options = {

  -- load your options here or load module with options1
  user = function() end,

  nvChad = {
    -- updater
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

---- UI -----

M.ui = {
  hl_override = {
    -- GitSignsAdd = {
    --   bg = "black",
    -- },
    -- GitSignsChange = {
    --   bg = "black",
    -- },
    -- GitSignsDelete = {
    --   bg = "black",
    -- },
    -- SignColumn = {
    --   bg = "black",
    -- },
    -- FoldColumn = {
    --   bg = "black",
    -- },
    Comment = {
      italic = true,
    },
    ContextVt = {
      fg = "one_bg3",
    },
    AlphaHeader = {
      fg = "red",
      bold = true,
    },
    FocusedSymbol = {
      bg = "red",
      fg = "black",
    },
    TSNodeKey = {
      fg = "green",
    },
    TSNodeUnmatched = {
      fg = "grey",
    },
    -- CursorLine = {
    --   bg = "one_bg",
    -- },
    MatchWord = {
      fg = "none",
    },
    LspReferenceText = {
      bg = "one_bg",
      fg = "none",
    },
    LspReferenceWrite = {
      bg = "one_bg",
      fg = "none",
    },
    LspReferenceRead = {
      bg = "one_bg",
      fg = "none",
    },
    -- FloatBorder = {
    --   fg = "darker_black",
    --   bg = "darker_black",
    -- },
    -- HarpoonBorder = {
    --   fg = "darker_black",
    --   bg = "darker_black",
    -- },
    -- HarpoonWindow = {
    --   bg = "darker_black",
    -- },
  },
  changed_themes = {},
  theme_toggle = { "gatekeeper", "one_light" },
  theme = "gatekeeper", -- default theme
  transparency = false,
}

M.plugins = {
  override = {},
  remove = {},

  options = {
    lspconfig = {
      setup_lspconf = "", -- path of lspconfig file
    },
    statusline = {
      separator_style = "block", -- default/round/block
      config = "%!v:lua.require'ui.statusline'.run()",
    },
  },

  -- add, modify, remove plugins
  user = {},
}

return M
