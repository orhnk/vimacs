---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- ["<C-BS>"] = { "<C-w>", "Delete Whole word", opts = { nowait = true } },
  },
}

-- M. = {
--   n = {
--  [""] = { "", "" },
--   },
-- }

-----------------------------------------------------------
-- Github Copilot Bindings
-----------------------------------------------------------
-- M.copilot = {
--   mode_opts = { expr = true },
--   i = {
--     ["<C-h>"] = { 'copilot#Accept("<Left>")', "   copilot accept" },
--   },
-- }
-- more keybinds!

return M
