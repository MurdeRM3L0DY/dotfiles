local lspconfig = require 'lspconfig'
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

-- local configs = require 'lspconfig.configs'
-- local util = require 'lspconfig.util'
-- configs['luahelper'] = {
--   default_config = {
--     cmd = { '/home/nemesis/Downloads/linuxlualsp', '-mode', '1' },
--     filetypes = { 'lua' },
--     root_dir = util.find_git_ancestor,
--     single_file_support = true,
--   },
--   docs = {
--     package_json = 'https://raw.githubusercontent.com/Tencent/LuaHelper/master/luahelper-vscode/package.json',
--     description = [[
-- https://github.com/Tencent/LuaHelper
-- Lua language server.
--     ]],
--     default_config = {
--       root_dir = [[root_pattern(".git") or bufdir]],
--     },
--   },
-- }
--
-- lspconfig['luahelper'].setup(make_client {})

-- lspconfig['sumneko_lua'].setup(client_config {
--   cmd = { '/home/nemesis/dev/repos/lua-language-server/bin/lua-language-server' },
--   settings = {
--     Lua = {
--       runtime = {
--         path = { 'lua/?.lua', 'lua/?/init.lua' },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       completion = {
--         showWord = 'Disable',
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })

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
