local augroup = function(group, augroup_opts)
  return setmetatable({
    id = vim.api.nvim_create_augroup(
      group,
      vim.tbl_extend('keep', augroup_opts or {}, { clear = true })
    ),
    del = function(self)
      if self.id then
        vim.api.nvim_del_augroup_by_id(self.id)
        self.id = nil
      end
    end,
  }, {
    __call = function(self, callback)
      if self.id then
        callback(function(event, create_opts)
          create_opts.group = self.id
          vim.api.nvim_create_autocmd(event, create_opts)
        end, function(clear_opts)
          clear_opts.group = self.id
          vim.api.nvim_clear_autocmds(clear_opts)
        end)
      end
    end,
  })
end

return augroup
