-- https://github.com/akinsho/bufferline.nvim

local bufferline = safe_require "bufferline"
if not bufferline then
  return
end
local highlights = {}
if vim.g.colors_name == "rose-pine" then
  highlights = require "rose-pine.plugins.bufferline" or {}
end
--
-- options = {
--    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
--    buffer_close_icon = "",
--    modified_icon = "",
--    close_icon = "",
--    show_close_icon = false,
--    left_trunc_marker = "",
--    right_trunc_marker = "",
--    max_name_length = 14,
--    max_prefix_length = 13,
--    tab_size = 20,
--    show_tab_indicators = true,
--    enforce_regular_tabs = false,
--    view = "multiwindow",
--    show_buffer_close_icons = true,
--    separator_style = "thin",
--    always_show_bufferline = true,
--    diagnostics = false,
--    themable = true,

bufferline.setup {
  highlights = highlights,
  options = {
    numbers = "none",
    -- numbers = function(opts)
    --   return string.format("%s", opts.id) -- :h bufferline-numbers
    -- end,
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    indicator_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thick",
    always_show_bufferline = true,
    themable = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    sort_by = "id",
    diagnostics = false,
    diagnostics_indicator = function(count, level)
      local icon = level:match "error" and " " or " "
      return " " .. icon .. count
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "No Name" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = " File Explorer",
        highlight = "Directory",
        text_align = "left",
        padding = 1,
      },
    },
  },
}

-- vim.cmd "hi BufferLineSeparator guifg=#11121d guibg=NONE"
vim.opt.showtabline = 0
