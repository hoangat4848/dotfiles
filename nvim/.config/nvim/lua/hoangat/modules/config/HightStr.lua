local high_str = safe_require "high-str"
if not high_str then
  return
end

high_str.setup {
  verbosity = 0,
  saving_path = "/tmp/highstr/",
  highlight_colors = {
    -- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
    color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
    color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
    color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
    color_3 = { "#8A2BE2", "smart" }, -- Proton purple
    color_4 = { "#FF4500", "smart" }, -- Orange red
    color_5 = { "#008000", "smart" }, -- Office green
    color_6 = { "#0000FF", "smart" }, -- Just blue
    color_7 = { "#FFC0CB", "smart" }, -- Blush pink
    color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
    color_9 = { "#7d5c34", "smart" }, -- Fallow brown
  },
}

vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 0<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 2<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 3<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 4<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 5<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 6<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 7<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 8<CR>")
vim.keymap.set("v", "<leader>/1", ":<C-u>HSHighlight 9<CR>")
vim.keymap.set("v", "<leader>/d", ":<C-u>HSRmHighlight<CR>")
