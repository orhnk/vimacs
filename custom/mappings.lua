---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- ["<C-BS>"] = { "<C-w>", "Delete Whole word", opts = { nowait = true } },
  },
}

M.disabled = {
  -- default nvim-tree binding for NvChad
  ["<leader>e"] = "",
  ["<C-s>"] = "",
}

-- M.selection = {
--   ["<C-a>"] = { "gg0vG$", mode = "n", desc = "Select Whole Buffer" },
-- }

M.nvimtree = {
  n = {
    ["<leader>ee"] = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
    ["<leader>er"] = { ":NvimTreeRefresh<CR>", "Refresh NvimTree" },
    ["<leader>ef"] = { ":NvimTreeFindFile<CR>", "Find File in NvimTree" },
  },
}

M.snippets = {
  n = {
    ["<leader>es"] = { ":lua require('luasnip.loaders').edit_snippet_files()<CR>", "Edit Snippets" },
  },
}

M.resize = {
  n = {
    -- Conflicts with moveline
    -- ["C-M-j"] = { ":resize -2<CR>", "Resize Window -2" },
    -- ["C-M-k"] = { ":resize +2<CR>", "Resize Window +2" },
    ["H"] = { ":vertical resize +2<cr>", "resize window -2" },
    ["L"] = { ":vertical resize -2<cr>", "resize window +2" },
  },
}

M.config = {
  n = {
    ["<leader>oc"] = { ":next ~/.config/nvim/lua/custom/*.lua<CR>", "Open Editor Configuration" },
  },
}

-- { "  Find Command", "Spc f c", "Telescope builtin" },
M.telescope = {
  n = {
    ["<leader>fs"] = { ":Telescope builtin<CR>", "Find Editor Command" },
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
