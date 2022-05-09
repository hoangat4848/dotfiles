-- Check nvim-lsp-installer installed or not
local lsp_installer = safe_require "nvim-lsp-installer"
if not lsp_installer then
  return
end

local servers = { "cssls", "html", "ember", "emmet_ls", "jsonls", "sumneko_lua", "tailwindcss", "tsserver", "eslint" }

-- Auto install needed servers
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    server:install()
  end
end

local settings = require(CONFIG_PATH .. "lsp.settings")

-- For each server pass opts to setup function.
lsp_installer.on_server_ready(function(server)
  -- Check if there's specific settings or not.
  local opts = settings[server.name] or {}
  -- General options
  opts.on_attach = require(CONFIG_PATH .. "lsp.handlers").on_attach
  opts.capabilities = require(CONFIG_PATH .. "lsp.handlers").capabilities

  -- This setup() function is exactly the same as lspconfig's setup function.
  server:setup(opts)
end)
