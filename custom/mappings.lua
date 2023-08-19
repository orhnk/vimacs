---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- ["<C-BS>"] = { "<C-w>", "Delete Whole word", opts = { nowait = true } },
  },
}

M.update = {
  n = {
    ["<leader>uu"] = { ":NvChadUpdate<CR>", "Update NvChad UI" },
  },
}

M.lazy = {
  n = {
    ["<leader>ll"] = { ":Lazy<CR>", "Open Plugin Manager" },
  },
}

M.mason = {
  n = {
    ["<leader>mi"] = { ":Mason<CR>", "Open LSP Installer" },
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
