local M = {}

local wk = require "which-key"

M.prefixes = function()
  -- TODO: Rewise this frequently
  -- WhichKey prefixes:
  wk.register {
    ["<leader>"] = {
      a = { name = "+AI" },
      b = { name = "+Buffer" },
      c = { name = "+Code" },
      cm = { name = "+Markdown" },
      cp = { name = "+Cpp" },
      cx = { name = "+Cargo.toml" },
      d = { name = "+Debug" },
      e = { name = "+Edit" },
      f = { name = "+Find" },
      g = { name = "+Git" },
      h = { name = "+Horizontal" },
      j = { name = "+Join" },
      k = { name = "+Color" },
      l = { name = "+LSP" },
      m = { name = "+MiniMap" },
      o = { name = "+Open" },
      p = { name = "+Paste" },
      r = { name = "+Run" },
      s = { name = "+Surf" },
      t = { name = "+Test" },
      u = { name = "+Update" },
      v = { name = "+Vertical" },
      w = { name = "+Workspace" },
      x = { name = "+Other" },
    },
  }
end

return M
