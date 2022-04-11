local lsp = vim.lsp
local handlers = vim.lsp.handlers

-- lsp.set_log_level "trace"

handlers['textDocument/hover'] = lsp.with(handlers.hover, { border = 'single' })
handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, { border = 'single' })
