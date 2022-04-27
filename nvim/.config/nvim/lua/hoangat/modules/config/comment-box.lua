local cb = safe_require "comment-box"
if not cb then
  return
end

cb.setup {
  doc_width = 80, -- width of the document
  box_width = 70, -- width of the boxes
  borders = { -- symbols used to draw a box
    top = "─",
    bottom = "─",
    left = "│",
    right = "│",
    top_left = "╭",
    top_right = "╮",
    bottom_left = "╰",
    bottom_right = "╯",
  },
  line_width = 70, -- width of the lines
  line = { -- symbols used to draw a line
    line = "─",
    line_start = "─",
    line_end = "─",
  },
  outer_blank_lines = false, -- insert a blank line above and below the box
  inner_blank_lines = false, -- insert a blank line above and below the text
  line_blank_line_above = false, -- insert a blank line above the line
  line_blank_line_below = false, -- insert a blank line below the line
}
-- ──────────────────────────────────────────────────────────────────────

local keymap = vim.keymap.set

-- left aligned fixed size box with left aligned text
keymap({ "n", "v" }, "<Leader>/b", function()
  cb.lbox(10)
end, {})
keymap({ "n", "v" }, "<Leader>/a", function()
  cb.albox(10)
end, {})
-- centered adapted box with centered text
keymap({ "n", "v" }, "<Leader>/c", function()
  cb.accbox(10)
end, {})

-- centered line
keymap("n", "<Leader>/l", cb.cline, {})
