local M = {}

M.setup = function()
	local null_ls = safe_require("null-ls")
	if not null_ls then
		return
	end

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		sources = {
			formatting.stylua,
			formatting.prettierd,
			-- diagnostics.eslint,
		},
	})
end

return M
