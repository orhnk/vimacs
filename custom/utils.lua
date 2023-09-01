local M = {}

M.extern = function(cmd, opts)
  require("nvterm.terminal").send(cmd, opts)
end

return M
