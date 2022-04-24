local npairs = safe_require("nvim-autopairs")
if not npairs then
	return
end

npairs.setup({
	check_ts = true, -- check treesitter working
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "ErrorMsg",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = safe_require("cmp")
if not cmp then
	return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
