-- https://gIthub.com/nvim-lualine/lualine.nvim

local lualine = safe_require "lualine"
if not lualine then
  return
end

local gps = safe_require "nvim-gps"
if not gps then
  return
end

local nvim_gps = function()
  local gps_location = gps.get_location()
  if gps_location == "error" then
    return ""
  else
    return gps.get_location()
  end
end

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = vim.g.colors_name or "auto",
    disabled_filetypes = { "dashboard", "NvimTree" },
    globalstatus = true,
    -- theme = {
    --   -- We are going to use lualine_c an lualine_x as left and
    --   -- right section. Both are highlighted by c theme .  So we
    --   -- are just setting default looks o statusline
    --   normal = { c = { fg = colors.fg, bg = colors.bg } },
    --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
    -- },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      function()
        return "%="
      end,
      "filename",
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return "▊"
  end,
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ""
  end,
  -- color = function()
  --   -- auto change color according to neovims mode
  --   local mode_color = {
  --     n = "lualine_b_normal",
  --     i = "lualine_b_insert",
  --     v = "lualine_b_visual",
  --     [""] = "lualine_b_visual",
  --     V = "lualine_b_visual",
  --     c = "lualine_b_command",
  --     no = "lualine_b_command",
  --     s = colors.orange,
  --     S = colors.orange,
  --     [""] = colors.orange,
  --     ic = colors.yellow,
  --     R = "lualine_b_replace",
  --     Rv = "lualine_b_replace",
  --     cv = "lualine_b_command",
  --     ce = "lualine_b_command",
  --     r = "lualine_b_replace",
  --     rm = "lualine_b_replace",
  --     ["r?"] = "lualine_b_replace",
  --     ["!"] = "lualine_b_command",
  --     t = "lualine_b_command",
  --   }
  --   return mode_color[vim.fn.mode()]
  -- end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  "filesize",
  cond = conditions.buffer_not_empty,
}

ins_left {
  "filename",
  path = 1,
  shorting_target = 1000,
  -- cond = conditions.buffer_not_empty,
  color = { gui = "bold" },
}

ins_left { "location" }

ins_left { "progress", color = { fg = colors.fg, gui = "bold" } }

ins_left {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  -- diagnostics_color = {
  --   color_error = { fg = colors.red },
  --   color_warn = { fg = colors.yellow },
  --   color_info = { fg = colors.cyan },
  -- },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return "%="
  end,
}

ins_left {
  -- Lsp server name .
  nvim_gps,
  color = { gui = "bold" },
}

-- Add components to right sections
ins_right {
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
}

ins_right {
  "fileformat",
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { gui = "bold" },
}

ins_right {
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
}

ins_right {
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = " ", removed = " " },
  color = { gui = "bold" },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return "▊"
  end,
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
