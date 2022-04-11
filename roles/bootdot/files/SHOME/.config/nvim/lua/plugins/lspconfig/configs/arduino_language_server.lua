---@param server Server
---@return table
return function(server)
  return {
    on_new_config = function(config, root_dir)
      local cmd = server:get_default_options().cmd
      config.cmd = vim.list_extend(cmd, { '-fqbn', 'arduino:avr:uno' })
    end,
  }
end
