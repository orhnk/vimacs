local M = {}

M.extern = function(cmd, opts)
  -- Example:
  --  extern("vim", "vertical")
  --  $ vim;exit # -> quit right after vim exits
  --  so the whole UI is rendered as in terminal.
  --  and killed when the terminal is closed.
  require("nvterm.terminal").send(cmd .. ";exit", opts)
end

return M
