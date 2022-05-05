-- https://github.com/danymat/neogen

local neogen = safe_require("neogen")
if not neogen then
  return
end

neogen.setup {
snippet_engine = "luasnip"
}
