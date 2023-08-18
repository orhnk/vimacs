---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- ["<C-BS>"] = { "<C-w>", "Delete Whole word", opts = { nowait = true } },
  },
}

M.translator = {
  v = {
    ["<leader>tt"] = { ":TranslateW<CR>", "Translate selected test" },
    ["<leader>tc"] = { ":TranslateX<CR>", "Translate & Copy selected text" },
    ["<leader>tr"] = { ":TranslateR<CR>", "Replace text with Translation" },
  },
}

M.emoji = {
  n = {
    ["<leader>fe"] = { ":PickEverything<CR>", "Glyph Picker" }, -- Gigantic Search Base
  },
}

M.compiler = {
  n = {
    ["<leader>rr"] = { ":CompilerOpen<CR>", "Open project runner" },
    ["<leader>rt"] = { ":CompilerToggleResults<CR>", "Toggle project runner window" },
  },
}

M.tests = {
  n = {
    ["<leader>to"] = { ":Neotest summary<CR>", "Open interactive test session" },
    ["<leader>te"] = { ":Neotest run<CR>", "Run tests for the session" },
  },
}

M.task_runner = {
  n = {
    ["<leader>tt"] = { ":OverseerToggle<CR>", "Toggle Task Runner UI" },
    ["<leader>tr"] = { ":OverseerRun<CR>", "Run tasks" },
  },
}

M.minimap = {
  n = {
    ["<leader>mo"] = { "codewindow.toggle_minimap()", "Toggle Minimap" },
    ["<leader>mm"] = { "codewindow.toggle_focus()", "Focus Minimap" },
  },
}

M.move_line = {
  n = {
    ["<C-S-j>"] = { "moveline.down()", "Move line down" },
    ["<C-S-k>"] = { "moveline.up()", "Move line up" },
  },

  v = {
    ["<C-S-j>"] = { "moveline.block_down()", "Move line down" },
    ["<C-S-k>"] = { "moveline.block_up()", "Move line up" },
  },
}

M.pastebin = {
  n = {
    ["<leader>pp"] = { ":PP<CR>", "Send Buffer to Pastebin Client" },
  },
  v = {
    ["<leader>pp"] = { ":PP<CR>", "Send Buffer to Pastebin Client" },
  },
}

M.neogit = {
  n = {
    ["<leader>gg"] = { ":Neogit<CR>", "Open Neogit" },
  },
}

M.gh = {
  n = {
    ["<leader>gh"] = { ":GH<CR>", "Open Github Client" },
  },
}

M.undo = {
  n = {
    ["<leader>tu"] = { ":Telescope undo<CR>", "Open Undo History" },
  },
}

M.symbols = {
  n = {
    ["<leader>ss"] = { ":SymbolsOutline<CR>", "Surf declarations" },
  },
}

M.file_pairs = {
  n = {
    ["<leader>sw"] = { ":lua require('nvim-quick-switcher').toggle('cpp', 'hpp')<CR>", "Surf declarations" },
  },
}

M.refactor = {
  n = {
    ["<leader>ce"] = { ":Refactor extract<CR>", "Extract To Function" },
    ["<leader>cv"] = { ":Refactor extract_var<CR>", "Extract To Variable" },
    ["<leader>cb"] = { ":Refactor extract_block<CR>", "Extract To Block" },
    ["<leader>ct"] = { ":Refactor extract_block_to_file<CR>", "Extract Block To File" },
    ["<leader>cn"] = { ":Refactor refactor_names<CR>", "Refactor names" },
    ["<leader>cf"] = { ":Refactor extract_to_file<CR>", "Extract to file" },
    ["<leader>ci"] = { ":Refactor inline_var<CR>", "Inline Variable" },
  },

  v = {
    ["<leader>ce"] = { ":Refactor extract<CR>", "Extract To Function" },
    ["<leader>cv"] = { ":Refactor extract_var<CR>", "Extract To Variable" },
    ["<leader>cb"] = { ":Refactor extract_block<CR>", "Extract To Block" },
    ["<leader>ct"] = { ":Refactor extract_block_to_file<CR>", "Extract Block To File" },
    ["<leader>cn"] = { ":Refactor refactor_names<CR>", "Refactor names" },
    ["<leader>cf"] = { ":Refactor extract_to_file<CR>", "Extract to file" },
    ["<leader>ci"] = { ":Refactor inline_var<CR>", "Inline Variable" },
  },
}

M.ai_assistant = {
  n = {
    ["<leader>ai"] = { ":CodyChat<CR>", "AI Assistant" },
    ["<leader>ad"] = { ':CodyDo ""<Left>', "Let AI Write Code" },
    ["<leader>aa"] = { ":CodyTaskAccept<CR>", "Confirm AI work" },
  },

  v = {
    ["<leader>ac"] = { "y:CodyChat<CR><ESC>pG$a<CR>", "Chat Selected Code" },
    ["<leader>ar"] = { "y:CodyChat<CR>refactor following code:<CR><ESC>p<CR>", "Request Refactoring" },
    ["<leader>ae"] = { "y:CodyChat<CR>explain following code:<CR><ESC>p<CR>", "Request Explanation" },
    ["<leader>af"] = {
      "y:CodyChat<CR>find potential vulnerabilities from following code:<CR><ESC>p<CR>",
      "Request Potential Vulnerabilities",
    },
    ["<leader>at"] = {
      "y:CodyChat<CR>rewrite following code more idiomatically:<CR><ESC>p<CR>",
      "Request Potential Vulnerabilities",
    },
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
