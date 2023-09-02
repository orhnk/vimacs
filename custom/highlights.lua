-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = false,
  },

  NvDashAscii = {
    bg = "none",
    fg = "orange",
  },

  NvDashButtons = {
    fg = "light_grey",
    bg = "none",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },

  -- modicator.nvim
  -- stylua: ignore start
  NormalMode         = { fg = "blue",          bold = true },
  InsertMode         = { fg = "purple",        bold = true },
  VisualMode         = { fg = "cyan",          bold = true },
  CommandMode        = { fg = "vibrant_green", bold = true },
  ReplaceMode        = { fg = "orange",        bold = true },
  SelectMode         = { fg = "nord_blue",     bold = true },
  TerminalMode       = { fg = "green",         bold = true },
  TerminalNormalMode = { fg = "sun",           bold = true },
  -- stylua: ignore end
  -- end modicator.nvim

  -- harpoon FIXME: None of these actually work
  -- stylua: ignore start
  HarpoonInactive       = { fg = "purple", bold = true },
  HarpoonActive         = { fg = "white",  bold = true },
  HarpoonNumberActive   = { fg = "blue",   bold = true },
  HarpoonNumberInactive = { fg = "blue",   bold = true },
  TabLineFill           = { fg = "white",  bold = true },
  -- stylua: ignore end
  -- end harpoon

  -- nvim-biscuits
  BiscuitColor = { fg = "sun" }, -- TODO: make it more sense
  -- end nvim-biscuits

  -- Stutusline
  StCopilot = { fg = "yellow", bg = "black2" },
  -- end Statusline

  -- neotest
  -- stylua: ignore start
  NeotestAdapterName  = { fg = "red"           },
  NeotestBorder       = { fg = "purple"        },
  NeotestDir          = { fg = "teal"          },
  NeotestFailed       = { fg = "red"           },
  NeotestFile         = { fg = "white"         },
  NeotestFocused      = { fg = "green"         },
  NeotestExpandMarker = { fg = "sun"           },
  NeotestIndent       = { fg = "sun"           },
  NeotestMarked       = { fg = "red"           },
  NeotestNamespace    = { fg = "purple"        },
  NeotestPassed       = { fg = "green"         },
  NeotestRunning      = { fg = "grey"          },
  NeotestWinSelect    = { fg = "baby_pink"     },
  NeotestSkipped      = { fg = "grey_fg2"      },
  NeotestTarget       = { fg = "vibrant_green" },
  NeotestTest         = { fg = "dark_purple"   },
  NeotestUnknown      = { fg = "grey"          },
  NeotestWatching     = { fg = "light_grey"    },
  -- stylua: ignore end
  -- end neotest
}

return M
