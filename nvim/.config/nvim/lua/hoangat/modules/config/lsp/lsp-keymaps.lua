local M = {}

-- These mappings only work when LSP attached to buffer
M.lsp_keymaps = function(bufnr)
	local function map(buf_num, key, cmd)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(buf_num, "n", key, "<cmd>lua " .. cmd .. "<CR>", opts)
	end

	map(bufnr, "gD", "vim.lsp.buf.declaration()")
	map(bufnr, "gd", "vim.lsp.buf.definition()")
	map(bufnr, "gt", "vim.lsp.buf.type_definition()")
	map(bufnr, "gi", "vim.lsp.buf.implementation()")
	map(bufnr, "gr", "vim.lsp.buf.references()")
	map(bufnr, "K", "vim.lsp.buf.hover()")
	map(bufnr, "<C-k>", "vim.lsp.buf.signature_help()")
	-- map(bufnr, "<leader>rn", "require('renamer').rename()")
	map(bufnr, "<leader>rn", "vim.lsp.buf.rename()")
	map(bufnr, "<leader>ca", "vim.lsp.buf.code_action()")
	map(bufnr, "gl", 'vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })')
	map(bufnr, "<leader>dp", 'vim.diagnostic.goto_prev({ border = "rounded" })')
	map(bufnr, "<leader>dn", 'vim.diagnostic.goto_next({ border = "rounded" })')
	map(bufnr, "<leader>df", "vim.diagnostic.open_float()")
	map(bufnr, "<leader>dl", "vim.diagnostic.setloclist()")
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

return M
