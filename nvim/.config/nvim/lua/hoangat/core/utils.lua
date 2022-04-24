function P(cmd)
  print(vim.inspect(cmd))
end

function _G.safe_require(module)
  local status_ok, result = pcall(require, module)
  if not status_ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return status_ok
  end
  return result
end

CONFIG_PATH = "hoangat.modules.config."
