local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config {
    virtual_text = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = {
      severity = vim.diagnostic.severity.ERROR,
    },
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- local function lsp_highlight_document(client)
-- 	-- Set autocommands conditional on server_capabilities
-- 	if client.resolved_capabilities.document_highlight then
-- 		vim.api.nvim_exec(
-- 			[[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
-- 			false
-- 		)
-- 	end
-- end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
  end

  require(CONFIG_PATH .. "lsp.lsp-keymaps").lsp_keymaps(bufnr)
  -- lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)

  local lsp_signature = safe_require "lsp_signature"
  if lsp_signature then
    lsp_signature.on_attach()
  end

  local illuminate = safe_require "illuminate"
  if illuminate then
    illuminate.on_attach(client)
  end

  if client.name == "tsserver" then
    local ts_utils = safe_require "nvim-lsp-ts-utils"
    if ts_utils then
      ts_utils.setup {}
      ts_utils.setup_client(client)
    end
  end

  -- require(CONFIG_PATH .. "lsp.lsp-signature")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = safe_require "cmp_nvim_lsp"
if cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

M.capabilities = capabilities

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      au!
      au BufWritePre *.js,*.jsx,*.ts,*.tsx EslintFixAll
      au BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 2000)
    augroup end
  ]]
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
    vim.notify "Enabled format on save"
  else
    vim.cmd "au! format_on_save"
    vim.notify "Disabled format on save"
  end
end

local diagnostic_show = true
function M.toggle_virtual_text()
  if diagnostic_show then
    vim.diagnostic.hide()
    diagnostic_show = false
  else
    vim.diagnostic.show()
    diagnostic_show = true
  end
end

vim.cmd [[command! LspToggleAutoFormat execute 'lua require(CONFIG_PATH .. "lsp.handlers").toggle_format_on_save()']]
vim.cmd [[command! LspToggleVirtualText execute 'lua require(CONFIG_PATH .. "lsp.handlers").toggle_virtual_text()']]

return M
