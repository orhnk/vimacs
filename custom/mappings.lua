---@type MappingsTable
local M = {}
local extern = require("custom.utils").extern

M.general = {
  n = {
    ["<leader>ww"] = { "<cmd> w<cr>", "Save Changes", opts = { nowait = true } },
    ["<leader>qq"] = { "<cmd> qa<cr>", "Quit Editor", opts = { nowait = true } },
    ["<leader>fq"] = { "<cmd> qa!<cr>", "Force Quit Editor", opts = { nowait = true } },
    ["<leader>wq"] = { "<cmd> wq<cr>", "Write Quit Editor", opts = { nowait = true } },
  },
}

M.disabled = {
  n = {

    -- LSP
    -- NOTE: All of these mappings are remapped
    -- to a compatible keybind. There are all nice
    --
    -- diagnostics
    ["<leader>f"] = "",
    -- loclist
    ["<leader>q"] = "",

    -- Terminal
    ["<leader>v"] = "",
    ["<leader>h"] = "",

    -- Buffer
    ["<leader>x"] = "",
    ["<leader>b"] = "",

    ["<C-s>"] = "",

    -- NvimTree
    ["<C-n>"] = "",
    ["<leader>e"] = "",

    -- Comment
    ["<leader>/"] = "",

    -- Git
    ["<leader>cm"] = "", -- Commits
    ["<leader>ph"] = "", -- Preview hunk

    -- Editor
    ["<leader>n"] = "", -- linenr

    -- Terminal
    ["<leader>pt"] = "",

    -- LSP
    ["<leader>ls"] = "",

    -- NvChad
    ["<leader>th"] = "",
    ["<leader>fo"] = "", -- moved: <leader>fr
  },
}

M.themes = {
  n = {
    ["<leader>ht"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
  },
}

M.terms = {
  n = {
    ["<leader>ft"] = {
      "<cmd> Telescope terms <CR>",
      "Pick hidden term",
    },
  },
}

M.treesitter = {
  n = {
    ["<leader>nts"] = { "<cmd> Inspect<CR>", "HL groups Under Cursor" },
    ["<leader>ntt"] = { "<cmd> InspectTree<CR>", "Parsed Syntax Tree" },
    ["<leader>ntq"] = { "<cmd> PreviewQuery<CR>", "Query Editor" },
  },
}

M.buffer = {
  n = {
    ["<leader>bn"] = { "<cmd> enew <CR>", "New buffer" },

    -- quit buffer
    ["<leader>bd"] = {
      "<cmd> q<CR>",
      "Close buffer", -- Terminals are hidden
    },

    -- close buffer + hide terminal buffer
    ["<leader>bk"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer", -- Terminals are hidden
    },
  },
}

M.sort = {
  v = {
    -- <cmd> breaks visual mode selection sorting
    -- and sorts the whole buffer instead
    ["<leader>sq"] = { ":sort<CR>", "Sort Selection" },
  },
}

M.nvterm = {
  n = {
    ["<leader>hh"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>vv"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.selection = {
  n = {
    ["<C-M-a>"] = { "gg0vG$", mode = "n", desc = "Select Whole Buffer" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>ee"] = { "<cmd> NvimTreeFocus<CR>", "Toggle NvimTree" },
    ["<leader>et"] = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
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

-- VIMSCRIPT:
-- function! ZathuraOpenPdf()
-- 	let fullPath = expand("%:p")
-- 	let pdfFile = substitute(fullPath, ".tex", ".pdf", "")
-- 	execute "silent !zathura '" . pdfFile . "' &"
-- endfunction
-- END
--
-- M.zathura = {
--   n = {
--     ["<leader>oz"] = { ":next ~/.config/nvim/lua/custom/*.lua<CR>", "Open in Zathura" },
--   },
-- }

M.telescope = {
  n = {
    ["<leader>fc"] = { ":Telescope builtin<CR>", "Find Editor Command" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles<CR>", "Recent Files" },
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
    ["<leader>om"] = { ":Mason<CR>", "Open LSP Installer" },
  },
}

M.git = {
  n = {
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
  },
}

M.code = {
  v = {
    ["<leader>cz"] = {
      ":Telescope lsp_range_code_actions",
      "Code actions for refactoring",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP Code Action",
    },
  },

  n = {
    ["<leader>ss"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP Signature Help",
    },

    ["<leader>sa"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    -- now lazy loads nvim-bqf
    -- ["<leader>li"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>sq"] = { -- in v mode it sorts
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

M.other = {
  n = {
    ["<leader>bl"] = { "<cmd> set nu!<cr>", "Toggle line number", opts = { nowait = true } },
    ["<leader>br"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
  },
}

M.dashboard = {
  n = {
    ["<leader>bi"] = { "<cmd> Nvdash<CR>", "Open Dashboard" },
  },
}

M.irc = {
  n = {
    ["<leader>xi"] = {
      function()
        extern("weechat", "vertical")
      end,
      "IRC Client",
    },
  },
}

M.discord = {
  n = {
    ["<leader>xd"] = {
      function()
        extern("discordo", "vertical")
      end,
      "Discord",
    },
  },
}

M.map = {
  n = {
    ["<leader>xm"] = {
      function()
        extern("mapscii", "vertical")
      end,
      "Open World Map",
    },
  },
}

M.browser = {
  n = {
    ["<leader>xb"] = {
      function()
        extern("browsh", "vertical")
      end,
      "Open Browsher",
    },

    ["<leader>xl"] = {
      function()
        extern("lynx", "vertical")
      end,
      "Open Lynx",
    },
  },
}

M.reddit = {
  n = {
    ["<leader>xr"] = {
      function()
        extern("tuir", "vertical")
      end,
      "Reddit Client",
    },
  },
}

M.stackoverflow = {
  n = {
    ["<leader>xs"] = {
      function()
        local q = vim.fn.input("Query: ")
        extern("so " .. q, "vertical")
      end,
      "Query StackOverflow",
    },
  },
}

M.mail = {
  n = {
    ["<leader>xq"] = {
      function()
        extern("mutt", "vertical")
      end,
      "Email Client",
    },
  },
}

M.ncmpcpp = {
  n = {
    ["<leader>xa"] = {
      function()
        extern("ncmpcpp", "vertical")
      end,
      "Music Player",
    },
  },
}

M.whatsapp = {
  n = {
    ["<leader>xw"] = {
      function()
        extern("nchat", "vertical")
      end,
      "WhatsApp Client",
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
