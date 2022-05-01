local pretty_fold = safe_require "pretty-fold"
if not pretty_fold then
  return
end

pretty_fold.setup {
  keep_indentation = false,
  fill_char = "━",
  sections = {
    left = {
      "━ ",
      function()
        return string.rep("*", vim.v.foldlevel)
      end,
      " ━┫",
      "content",
      "┣",
    },
    right = {
      "┫ ",
      "number_of_folded_lines",
      ": ",
      "percentage",
      " ┣━━",
    },
  },
}

require("pretty-fold.preview").setup { key = "l" }
