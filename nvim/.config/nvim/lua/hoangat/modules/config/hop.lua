local hop = safe_require "hop"
if not hop then
  return
end

hop.setup {}

-- local map = function(mode, lhs, rhs, opts)
--   vim.keymap.set(mode, lhs, rhs, opts or { noremap = true, silent = true })
-- end

-- map({ "n", "v", "x" }, "<leader><leader>j", "<cmd>HopLineAC<cr>")
-- map({ "n", "v", "x" }, "<leader><leader>k", "<cmd>HopLineBC<cr>")
-- map({ "n", "v", "x" }, "<leader><leader>l", "<cmd>HopWordAC<cr>")
-- map({ "n", "v", "x" }, "<leader><leader>h", "<cmd>HopWordBC<cr>")

-- local hop_colors = {
--   ["rose-pine"] = "#eb6f92",
--   kanagawa = { waveRed = "#E46876", peachRed = "#FF5D62" },
-- }

-- HopNextKey
vim.cmd [[
  hi HopNextKey guifg = #FFA066 gui=bold
  hi HopNextKey1 guifg = #FFA066 gui=bold
  hi HopNextKey2 guifg = #FFA066 gui=bold
]]
