local indent_blankline = safe_require "indent_blankline"
if not indent_blankline then
  return
end

-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

indent_blankline.setup {
  char = "▏",
  filetype_exclude = {
    "startify",
    "dashboard",
    "dotooagenda",
    "log",
    "fugitive",
    "gitcommit",
    "packer",
    "vimwiki",
    "markdown",
    "json",
    "txt",
    "vista",
    "help",
    "todoist",
    "NvimTree",
    "peekaboo",
    "git",
    "TelescopePrompt",
    "undotree",
    "flutterToolsOutline",
    "", -- for all buffers without a file type
  },
  buftype_exclude = { "terminal", "nofile" },
  -- show_end_of_line = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  show_current_context = true,
  show_current_context_start = false,
  -- char_list = { "|", "¦", "┆", "┊" },
  space_char = " ",
  space_char_blankline = " ",
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
    "selector",
  },
}
