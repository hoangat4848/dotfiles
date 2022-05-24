_G.nvchad = {}

vim.g.nvchad_theme = "gruvbox"

nvchad.load_config = function()
  local conf = {
    ui = {
      hl_override = {
        -- CursorLine = {
        --   bg = "one_bg",
        -- },
        LspReferenceText = {
          bg = "one_bg2",
          fg = "none",
        },
        LspReferenceWrite = {
          bg = "one_bg2",
          fg = "none",
        },
        LspReferenceRead = {
          bg = "one_bg2",
          fg = "none",
        },
        FloatBorder = {
          fg = "darker_black",
          bg = "darker_black",
        },
        HarpoonBorder = {
          fg = "darker_black",
          bg = "darker_black",
        },
        HarpoonWindow = {
          bg = "darker_black",
        },
      },
      changed_themes = {},
      theme_toggle = { "onedark", "one_light" },
      theme = "tokyodark", -- default theme
      transparency = false,
    },
  }

  return conf
end
