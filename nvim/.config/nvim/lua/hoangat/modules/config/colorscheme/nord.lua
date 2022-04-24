-- https://github.com/shaunsingh/nord.nvim

local nord = safe_require "nord"
if not nord then
  return
end

nord.set()
