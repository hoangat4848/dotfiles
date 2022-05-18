vim.g.everforest_disable_italic_comment = 0
local status_ok, _ = pcall(vim.cmd, "colorscheme everforest")
if not status_ok then
  vim.notify "Colorscheme everforest not found"
end
