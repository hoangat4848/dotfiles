_G.nvchad = {}

vim.g.nvchad_theme = "gruvbox"

nvchad.load_config = function()
  local conf = {
    ui = {
      hl_override = {
        CursorLine = {
          bg = "one_bg",
        },
        LspReferenceText = {
          bg = "one_bg",
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
