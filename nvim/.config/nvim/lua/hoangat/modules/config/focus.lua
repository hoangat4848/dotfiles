local focus = safe_require "focus"
if not focus then
  return
end

focus.setup {
  excluded_filetypes = { "toggleterm", "NvimTree" },
  cursorline = false,
  signcolumn = false,
  absolutenumber_unfocussed = true,
  winhighlight = false,
}
