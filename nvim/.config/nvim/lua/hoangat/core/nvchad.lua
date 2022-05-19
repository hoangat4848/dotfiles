_G.nvchad = {}

vim.g.nvchad_theme = "everforest"

nvchad.load_config = function()
  local conf = {
    ui = {
      hl_override = {},
      changed_themes = {},
      theme_toggle = { "onedark", "one_light" },
      theme = "onedark", -- default theme
      transparency = false,
    },
  }

  return conf
end
