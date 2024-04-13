local augroup = require('utils.augroup')

local M = {}

M.AUGROUP = augroup('LSP_AUGROUP', { clear = true })

---setup lsp server
---@param filetypes string | string[]
---@param cb fun(ctx: table): table|nil
function M.setup(filetypes, cb)
  M.AUGROUP(function(au)
    au.create('FileType', {
      pattern = filetypes,
      callback = function(ctx)
        local cfg, opts = cb(ctx)
        if cfg then
          local root_markers = cfg.root_markers
          cfg.root_markers = nil

          if not cfg.root_dir then
            if root_markers then
              local match = vim.fs.find(root_markers, { upward = true })[1]
              -- don't start language server if root_markers were not found
              if not match then
                return
              end
              cfg.root_dir = vim.fs.dirname(match)
            else
              -- default to cwd if root_markers were not specified
              cfg.root_dir = vim.loop.cwd()
            end
          else
            if type(cfg.root_dir) == 'function' then
              cfg.root_dir = cfg.root_dir(ctx.file)
            end
          end

          cfg.filetypes = filetypes

          vim.lsp.start(
            require('config.lsp').make_client_config(cfg),
            { bufnr = ctx.buf, reuse_client = opts.reuse_client }
          )
        end
      end,
    })
  end)
end

---LspAttach
---@param cb fun(client: lsp.Client, bufnr: number)
function M.on_attach(cb)
  M.AUGROUP(function(au)
    au.create('LspAttach', {
      callback = function(ctx)
        local client = vim.lsp.get_client_by_id(ctx.data.client_id)
        if client then
          cb(client, ctx.buf)
        end
      end,
    })
  end)
end

return setmetatable(M, {})
