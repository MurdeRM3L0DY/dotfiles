local jdtls = require 'jdtls'
local keymap = require 'utils.keymap'
local augroup = require 'utils.augroup'

local JDTLS_AUGROUP = augroup('JDTLS_AUGROUP', { clear = true })

local config = {}

config.flags = {
  allow_incremental_sync = true,
}

config.settings = {
  -- ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
  -- ['java.format.settings.profile'] = "GoogleStyle",
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className} { ${member.name()}=${member.value}, ${otherMembers} }',
      },
    },
    configuration = {
      runtimes = {
        {
          name = 'JavaSE-11',
          path = ('%s/.zi/polaris/sdkman/candidates/java/11.0.12-open/'):format(os.getenv 'HOME'),
        },
        {
          name = 'JavaSE-18',
          path = ('%s/.zi/polaris/sdkman/candidates/java/18-open/'):format(os.getenv 'HOME'),
        },
      },
    },
  },
}

config.root_dir = jdtls.setup.find_root { 'gradlew', 'pom.xml' }

config.on_attach = function(_, bufnr)
  jdtls.setup.add_commands()

  local opts = { buffer = bufnr }

  keymap.set('n', '<A-o>', function()
    jdtls.organize_imports()
  end, opts)
  keymap.set('n', 'crc', function()
    jdtls.extract_constant()
  end, opts)
  keymap.set('n', 'crv', function()
    jdtls.extract_variable()
  end, opts)

  keymap.set('v', 'crc', "<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>", opts)
  keymap.set('v', 'crv', "<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>", opts)
  keymap.set('v', 'crm', "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>", opts)
end

config.on_init = function(client, _)
  client.notify('workspace/didChangeConfiguration', { settings = config.settings })
end

-- local jar_patterns = {
--     '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
--     '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
--     '/dev/microsoft/vscode-java-test/server/*.jar',
-- }

-- local bundles = {}
-- for _, jar_pattern in ipairs(jar_patterns) do
--   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
--     if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
--       table.insert(bundles, bundle)
--     end
--   end
-- end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
  -- bundles = bundles
  extendedClientCapabilities = extendedClientCapabilities,
}

local ok, jdtls_server = require('nvim-lsp-installer.servers').get_server 'jdtls'
if ok then
  config.cmd = jdtls_server:get_default_options().cmd

  JDTLS_AUGROUP(function(au)
    au.create({ 'FileType' }, {
      pattern = 'java',
      callback = function(match)
        jdtls.start_or_attach(require('lsp.config').make_config(config))
      end,
    })
  end)
end
