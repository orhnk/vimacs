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
  -- stylua: ignore start
  StBg            = { bg = "statusline_bg"                       },
  StGroup         = { --[[ fg = "grey",]]   bg = "statusline_bg" },
  StEncoding      = { fg = "white",         bg = "statusline_bg" },
  StBrowser       = { fg = "blue",          bg = "statusline_bg" },
  StCody          = { fg = "green",         bg = "statusline_bg" },
  StCopilot       = { fg = "yellow",        bg = "statusline_bg" },
  StDebug         = { fg = "red",           bg = "statusline_bg" },
  StDiscord       = { fg = "nord_blue",     bg = "statusline_bg" },
  StGit           = { fg = "orange",        bg = "statusline_bg" },
  StGithub        = { fg = "white",         bg = "statusline_bg" },
  StHome          = { fg = "yellow",        bg = "statusline_bg" },
  StIRC           = { fg = "white",         bg = "statusline_bg" },
  StKernel        = { fg = "white",         bg = "statusline_bg" },
  StMail          = { fg = "yellow",        bg = "statusline_bg" },
  StReddit        = { fg = "white",         bg = "statusline_bg" },
  StStackOverflow = { fg = "orange",        bg = "statusline_bg" },
  StHN            = { fg = "orange",        bg = "statusline_bg" },
  StGames         = { fg = "white",         bg = "statusline_bg" },
  StTranslate     = { fg = "nord_blue",     bg = "statusline_bg" },
  StWhatsapp      = { fg = "vibrant_green", bg = "statusline_bg" },
  StWorld         = { fg = "nord_blue",     bg = "statusline_bg" },
  -- stylua: ignore end
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

  -- neogit
  -- PR: NEEDED
  -- stylua: ignore start
  -- NeogitRemote                  = { fg = "white"               },
  -- NeogitObjectId                = { fg = "white"               },
  -- NeogitStash                   = { fg = "white"               },
  -- NeogitFold                    = { fg = "white"               },
  -- NeogitRebaseDone              = { fg = "white"               },
  -- NeogitTagName                 = { fg = "white"               },
  -- NeogitTagDistance             = { fg = "white"               },
  -- NeogitSectionHeader           = { fg = "white"               },
  -- NeogitUnpushedTo              = { fg = "white"               },
  -- NeogitUnmergedInto            = { fg = "white"               },
  -- NeogitUnpulledFrom            = { fg = "white"               },
  -- NeogitUntrackedfiles          = { fg = "white"               },
  -- NeogitUnstagedchanges         = { fg = "white"               },
  -- NeogitUnmergedchanges         = { fg = "white"               },
  -- NeogitUnpulledchanges         = { fg = "white"               },
  -- NeogitRecentcommits           = { fg = "white"               },
  -- NeogitStagedchanges           = { fg = "white"               },
  -- NeogitStashes                 = { fg = "white"               },
  -- NeogitRebasing                = { fg = "white"               },
  -- NeogitReverting               = { fg = "white"               },
  -- NeogitPicking                 = { fg = "white"               },
  -- NeogitChangeModified          = { fg = "white"               },
  NeogitChangeAdded                = { fg = "green", bg = "NONE"  },
  NeogitChangeDeleted              = { fg = "red", bg = "NONE"    },
  -- NeogitChangeRenamed           = { fg = "white"               },
  -- NeogitChangeUpdated           = { fg = "white"               },
  -- NeogitChangeCopied            = { fg = "white"               },
  -- NeogitChangeBothModified      = { fg = "white"               },
  -- NeogitChangeNewFile           = { fg = "white"               },
  -- NeogitHunkHeader              = { fg = "white"               },
  -- NeogitDiffContext             = { fg = "sun"                 },
  NeogitDiffAdd                    = { fg = "green", bg = "NONE"  }, -- bg = "#004717"    },
  NeogitDiffDelete                 = { fg = "red", bg = "NONE"    }, -- bg = "#611300"      },
  -- NeogitDiffHeader              = { fg = "grey_fg2"            },
  -- NeogitHunkHeaderHighlight     = { fg = "grey_fg2"            },
  -- NeogitDiffContextHighlight    = { fg = "grey_fg"             },
  NeogitDiffAddHighlight           = { fg = "green",  bg = "NONE" },
  NeogitDiffDeleteHighlight        = { fg = "red", bg = "NONE"    },
  -- NeogitDiffHeaderHighlight     = { fg = "grey_fg2"            },
  -- NeogitCursorLine              = { fg = "white"               },
  -- NeogitFilePath                = { fg = "white"               },
  -- NeogitCommitViewHeader        = { fg = "white"               },
  -- NeogitGraphBlack              = { fg = "black"               },
  -- NeogitGraphBlackBold          = { fg = "black2"              },
  -- NeogitGraphRed                = { fg = "red"                 },
  -- NeogitGraphRedBold            = { fg = "red"                 },
  -- NeogitGraphGreen              = { fg = "green"               },
  -- NeogitGraphGreenBold          = { fg = "vibrant_green"       },
  -- NeogitGraphYellow             = { fg = "yellow"              },
  -- NeogitGraphYellowBold         = { fg = "sun"                 },
  -- NeogitGraphBlue               = { fg = "blue"                },
  -- NeogitGraphBlueBold           = { fg = "nord_blue"           },
  -- NeogitGraphPurple             = { fg = "purple"              },
  -- NeogitGraphPurpleBold         = { fg = "dark_purple"         },
  -- NeogitGraphCyan               = { fg = "cyan"                },
  -- NeogitGraphCyanBold           = { fg = "teal"                },
  -- NeogitGraphWhite              = { fg = "white"               },
  -- NeogitGraphWhiteBold          = { fg = "light_grey"          },
  -- NeogitGraphGray               = { fg = "grey"                },
  -- NeogitGraphBoldGray           = { fg = "grey_fg"             },
  -- NeogitGraphOrange             = { fg = "orange"              },
  -- NeogitSignatureGood           = { fg = "green"               },
  -- NeogitSignatureBad            = { fg = "red"                 },
  -- NeogitSignatureMissing        = { fg = "grey"                },
  -- NeogitSignatureNone           = { fg = "grey_fg2"            },
  -- NeogitSignatureGoodUnknown    = { fg = "white"               },
  -- NeogitSignatureGoodExpired    = { fg = "white"               },
  -- NeogitSignatureGoodExpiredKey = { fg = "white"               },
  -- NeogitSignatureGoodRevokedKey = { fg = "white"               },
  -- NeogitPopupSectionTitle       = { fg = "white"               },
  -- NeogitPopupBranchName         = { fg = "white"               },
  -- NeogitPopupBold               = { fg = "white"               },
  -- NeogitPopupSwitchKey          = { fg = "white"               },
  -- NeogitPopupSwitchEnabled      = { fg = "white"               },
  -- NeogitPopupSwitchDisabled     = { fg = "white"               },
  -- NeogitPopupOptionKey          = { fg = "white"               },
  -- NeogitPopupOptionEnabled      = { fg = "white"               },
  -- NeogitPopupOptionDisabled     = { fg = "white"               },
  -- NeogitPopupConfigKey          = { fg = "white"               },
  -- NeogitPopupConfigEnabled      = { fg = "white"               },
  -- NeogitPopupConfigDisabled     = { fg = "white"               },
  -- NeogitPopupActionKey          = { fg = "white"               },
  -- NeogitPopupActionDisabled     = { fg = "white"               },
  -- NeogitNotificationInfo        = { fg = "white"               },
  -- NeogitNotificationWarning     = { fg = "white"               },
  -- NeogitNotificationError       = { fg = "white"               },
  -- NeogitCommandText             = { fg = "white"               },
  -- NeogitCommandTime             = { fg = "white"               },
  -- NeogitCommandCodeNormal       = { fg = "white"               },
  -- NeogitCommandCodeError        = { fg = "white"               },
  -- stylua: ignore end
  -- end neogit

  -- stylua: ignore start
  BqfPreviewBorder = { fg = "grey_fg2" },
  BqfPreviewTitle  = { fg = "white"    },
  BqfPreviewThumb  = { fg = "white"    },
  BqfPreviewRange  = { fg = "white"    },
  -- stylua: ignore end

  -- orgmode
  -- stylua: ignore start
  Headline1 = { bg = "#114319"                },
  Headline2 = { bg = "#424311"                },
  Headline3 = { bg = "#432111"                },
  Headline4 = { bg = "#114331"                },
  Headline5 = { bg = "#113143"                },
  CodeBlock = { fg = "sun"                    },
  Dash      = { fg = "grey_fg2",  bold = true },
  Quote     = { fg = "grey",      bold = true },
  -- stylua: ignore end
  -- end orgmode

  -- pqf
  -- stylua: ignore start
  qfPath     = { fg = "yellow" },
  qfPosition = { fg = "green" },
  qfError    = { fg = "red" },
  qfWarning  = { fg = "orange" },
  qfInfo     = { fg = "nord_blue" },
  qfHint     = { fg = "purple" },
  -- stylua: ignore end
  -- end pqf

  -- marks
  -- stylua: ignore start
  MarkSignHL     = { fg = "orange" },
  MarkSignNumHL  = { fg = "green"  },
  MarkVirtTextHL = { fg = "sun"    },
  -- stylua: ignore end
  -- end marks

  -- dap
  -- stylua: ignore start
  DapBreakpoint          = { fg = "red" },
  DapBreakpointCondition = { fg = "vibrant_green" },
  DapBreakpointRejected  = { fg = "grey_fg2" },
  -- DapBreakpointNum  = { fg = "red" },
  -- DapBreakpointLine = { bg = "red" },

  DapLogPoint     = { fg = "blue" },
  -- DapLogPointNum  = { fg = "nord_blue" },
  -- DapLogPointLine = { bg = "nord_blue" },

  DapStopped     = { fg = "sun" },
  -- DapStoppedNum  = { fg = "sun" },
  DapStoppedLine = { bg = "one_bg" },

  -- DAP UI
  DapUIBreakpointsCurrentLine = { fg = "sun" },
  DapUIBreakpointsPath = { fg = "red" },
  DapUICurrentFrameName = { fg = "orange" },
  DapUIDecoration = { fg = "grey" },
  DapUIFrameName = { fg = "sun" },
  DapUILineNumber = { fg = "white" },
  DapUIModifiedValue = { fg = "orange" },
  DapUIScope = { fg = "red" },
  DapUISource = { fg = "green" },
  DapUIStoppedThread = { fg = "cyan" },
  DapUIType = { fg = "nord_blue" },

  DapUIStepOut = { fg = "yellow" },
  DapUIStepOver = { fg = "nord_blue" },
  DapUIPlayPause = { fg = "vibrant_green" },
  DapUIRestart = { fg = "pink" },
  DapUIStepBack = { fg = "nord_blue" },
  DapUIStepInto = { fg = "yellow" },
  DapUIStop = { fg = "red" },

  -- DapUI = { fg = "nord_blue" },
  -- DapUI = { fg = "nord_blue" },
  DapUIVariable = { fg = "vibrant_green" },
  DapUIWatchesEmpty = { fg = "red" },

  -- stylua: ignore end
  -- end dap

  -- stylua: ignore start
  -- Vim Visual Multi
  VM_Cursor = { fg = "grey_fg" },
  -- stylua: ignore end
  -- end dap
}

return M
