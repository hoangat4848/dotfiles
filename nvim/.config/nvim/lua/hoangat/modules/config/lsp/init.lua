-- Check if lspconfig installed
local lsp_config = safe_require("lspconfig")
if not lsp_config then
	return
end

require(CONFIG_PATH .. "lsp.lsp-installer-config")
require(CONFIG_PATH .. "lsp.rename-qf")
require(CONFIG_PATH .. "lsp.handlers").setup() -- Diagnostic and keymap
require(CONFIG_PATH .. "lsp.handlers").enable_format_on_save()
require(CONFIG_PATH .. "lsp.null-ls").setup()
--require(CONFIG_PATH .. "lsp.trouble")
