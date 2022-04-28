return {
  on_new_config = function(config, root_dir)
    config.cmd = vim.list_extend(config.cmd, { '-fqbn', 'arduino:avr:uno' })
  end,
}
