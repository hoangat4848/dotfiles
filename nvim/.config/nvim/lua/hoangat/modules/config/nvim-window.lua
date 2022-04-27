local nvim_window = safe_require "nvim-window"
if not nvim_window then
  return
end

nvim_window.setup {
  -- The characters available for hinting windows.
  chars = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },

  -- A group to use for overwriting the Normal highlight group in the floating
  -- window. This can be used to change the background color.
  normal_hl = "Normal",

  -- The highlight group to apply to the line that contains the hint characters.
  -- This is used to make them stand out more.
  hint_hl = "Bold",

  -- The border style to use for the floating window.
  border = "single",
}
