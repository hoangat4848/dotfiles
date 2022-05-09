local M = {}

M.sumneko_lua = safe_require(CONFIG_PATH .. "lsp.settings.sumneko_lua")
M.jsonls = safe_require(CONFIG_PATH .. "lsp.settings.jsonls")
M.emmet_ls = safe_require(CONFIG_PATH .. "lsp.settings.emmet_ls")
M.html = safe_require(CONFIG_PATH .. "lsp.settings.html")

--jsonls = safe_require('hoangat.module.config.lsp.settings.jsonls'),
-- sumneko_lua = safe_require('hoangat.module.config.lsp.settings.sumneko_lua')

return M
