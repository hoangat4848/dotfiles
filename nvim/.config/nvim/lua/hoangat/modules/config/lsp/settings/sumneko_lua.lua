return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" }, -- used this let diagnostics ignore vim variable
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},

	},
}
