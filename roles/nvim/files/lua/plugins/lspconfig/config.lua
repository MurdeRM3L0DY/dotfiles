local client_config = require('lsp.config').client_config

---LSP setup
---@param server_name string
---@param opts table | fun(server: Server)
local lsp_setup = function(server_name, opts)
  local ok, server = require('nvim-lsp-installer.servers').get_server(server_name)
  if ok then
    if type(opts) == 'function' then
      opts = opts(server)
    end
    server:on_ready(function()
      server:setup(client_config(opts or {}))
    end)
    if not server:is_installed() then
      server:install()
    end
  end
end

lsp_setup('sumneko_lua', require 'plugins.lspconfig.configs.sumneko')
lsp_setup('tsserver', require 'plugins.lspconfig.configs.tsserver')
lsp_setup('arduino_language_server', require 'plugins.lspconfig.configs.arduino_language_server')
lsp_setup('cssls', {})
lsp_setup('tailwindcss', {})
lsp_setup('eslint', {})
lsp_setup('pylsp', {})
lsp_setup('solidity_ls', {})
lsp_setup('gopls', {})
lsp_setup('texlab', {})
lsp_setup('jsonls', require 'plugins.lspconfig.configs.jsonls')
lsp_setup('ltex', {})
lsp_setup('yamlls', {})
lsp_setup('ansiblels', {})
