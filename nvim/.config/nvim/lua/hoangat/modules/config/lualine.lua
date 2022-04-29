-- https://github.com/nvim-lualine/lualine.nvim

local lualine = safe_require "lualine"
if not lualine then
  return
end

local gps = safe_require "nvim-gps"
if not gps then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

--local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  cond = hide_in_width,
}

local modes = {
  NORMAL = "⊂(◉‿◉)つ",
  INSERT = "ᕙ(⇀‸↼‶)ᕗ",
  VISUAL = "ᕦ(ò_óˇ)ᕤ",
  ["V-LINE"] = "ԅ(≖‿≖ԅ) ",
  ["V-BLOCK"] = "ᕙ(ಥ﹏ಥ)7",
  COMMAND = " (⊙.☉)7 ",
  REPLACE = "ლ(ಠ_ಠ ლ)",
}

local mode = {
  "mode",
  fmt = function(str)
    return modes[str]
  end,
}

-- local filetype = {
--   "filetype",
--   icons_enabled = false,
--   icon = nil,
-- }

-- -- cool function for progress
-- local progress = function()
--   local current_line = vim.fn.line "."
--   local total_lines = vim.fn.line "$"
--   local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
--   local line_ratio = current_line / total_lines
--   local index = math.ceil(line_ratio * #chars)
--   return chars[index]
-- end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local nvim_gps = function()
  local gps_location = gps.get_location()
  if gps_location == "error" then
    return ""
  else
    return gps.get_location()
  end
end

vim.opt.laststatus = 3

lualine.setup {
  options = {
    icons_enabled = true,
    theme = vim.g.colors_name or "auto",
    -- theme = "solarized_dark",
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    -- disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    -- lualine_a = { "mode" },
    lualine_a = { mode },
    lualine_b = {
      {
        "branch",
        icons_enabled = true,
        icon = "",
      },
    },

    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      {
        nvim_gps,
        cond = hide_in_width,
        -- color = { fg = "#859900" }  -- Solarized
        color = { fg = "#D27E99" }, -- kanagawa
      },
    },

    -- lualine_x = { diagnostics, diff, spaces, "encoding", "fileformat", "filetype" },
    lualine_x = { diagnostics, diff, spaces, "encoding", "fileformat", "filetype" },

    lualine_y = { "progress" },

    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "nvim-tree", "toggleterm", "quickfix", "symbols-outline" },
}
