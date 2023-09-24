local M = {}

local wk = require "which-key"

M.prefixes = function()
  -- TODO: Rewise this frequently
  -- WhichKey prefixes:
  wk.register {
    ["<leader>"] = {

      -- stylua: ignore start
      [" "] = { name = " Quick"             },
      a     = { name = " AI"                }, --   󰧑
      b     = { name = "󱂬 Buffer"            },
      c     = { name = "󱃖 Code"              },
      cl    = { name = "󰡱 LeetCode"          },
      cm    = { name = " Markdown"          },
      cp    = { name = " Cpp"               }, --   󰙲
      cs    = { name = "󱝆 Surf"              },
      cx    = { name = "󱣘 Cargo.toml"        },
      cz    = { name = " Snippet"           },
      d     = { name = " Debug"             },
      e     = { name = " Edit"              }, -- TODO: Move these to their groups
      f     = { name = " Find"              },
      fu    = { name = "󰌷 URL"               },
      g     = { name = " Git"               },
      gh    = { name = " GitHub"            },
      ghc   = { name = " Card"              },
      ghi   = { name = " Issue"             },
      ghj   = { name = " Comment"           },
      gho   = { name = "󱓨 Assignee"          },
      ghp   = { name = " Repo"              },
      ghn   = { name = "󰓂 PR"                },
      ghr   = { name = " Review"            },
      ghl   = { name = "󰌕 Label"             },
      ght   = { name = "󱇫 Thread"            },
      ghu   = { name = " React"             },
      h     = { name = "󱕘 Harpoon"           },
      -- i     = { name = " Automation"        },
      i     = { name = " Sniprun"           },
      io    = { name = " Open"              },
      j     = { name = " Join"              },
      k     = { name = " Color"             },
      l     = { name = "󱃕 Lists"             },
      lt    = { name = " TODO"              },
      m     = { name = " Modes"             },
      ml    = { name = "󰉦 Lush"              },
      mk    = { name = "󰓫 Table"             },
      n     = { name = " Compiler Explorer" }, -- 
      nt    = { name = "󱘎 TreeSitter"        },
      o     = { name = " Open"              },
      p     = { name = " Profile"           }, -- 
      pl    = { name = "󱑤 Load"              },
      q     = { name = "󰗼 Quit"              },
      r     = { name = " Run"               },
      rq    = { name = " LeetCode"          },
      s     = { name = " LSP"               },
      t     = { name = "󰙨 Test"              },
      u     = { name = "󰚰 Update"            },
      v     = { name = " Games"             },
      w     = { name = " Workspace"         },
      x     = { name = " External"          },
      y     = { name = "󱘣 Neoclip"           },
      z     = { name = " Neorg"             },
      -- stylua: ignore end
    },
  }
end

M.opts = {
  icons = {
    group = "", -- disable + to make Nerf fonts usable
  },
}

return M
