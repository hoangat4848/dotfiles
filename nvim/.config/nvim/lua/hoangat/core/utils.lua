function P(v)
  print(vim.inspect(v))
  return v
end

function _G.safe_require(module)
  local status_ok, result = pcall(require, module)
  if not status_ok then
    vim.notify(string.format("Error requiring: %s", module), vim.log.levels.ERROR)
    return status_ok
  end
  return result
end

CONFIG_PATH = "hoangat.modules.config."

local M = {}
local cmd = vim.cmd
-- Highlights functions

-- Define bg color
-- @param group Group
-- @param color Color

M.bg = function(group, col)
  cmd("hi " .. group .. " guibg=" .. col)
end

-- Define fg color
-- @param group Group
-- @param color Color
M.fg = function(group, col)
  cmd("hi " .. group .. " guifg=" .. col)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.fg_bg = function(group, fgcol, bgcol)
  cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

return M
