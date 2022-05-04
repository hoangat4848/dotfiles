local M = {}

M.setup = function()
  local null_ls = safe_require "null-ls"
  if not null_ls then
    return
  end

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    sources = {
      formatting.stylua,
      formatting.prettier.with {
        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      },
    },
    -- on_attach = function(client)
    --   if client.server_capabilities.document_formatting then
    --     -- auto format on save (not asynchronous)
    --     local LspFormattingGrp = vim.api.nvim_create_augroup("LspFormattingGrp", { clear = true })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       command = "lua vim.lsp.buf.format()",
    --       group = LspFormattingGrp,
    --     })
    --   end
    -- end,
  }
end

return M
