local M = {}

local wk = require "which-key"

M.prefixes = function()
  -- TODO: Rewise this frequently
  -- WhichKey prefixes:
  wk.register {
    ["<leader>"] = {
      -- stylua: ignore start
      a  = { name = " AI"                }, --   󰧑
      b  = { name = "󱂬 Buffer"            },
      c  = { name = "󱃖 Code"              },
      cm = { name = " Markdown"          },
      cp = { name = " Cpp"               }, --   󰙲
      cx = { name = "󱣘 Cargo.toml"        },
      d  = { name = " Debug"             },
      e  = { name = " Edit"              },
      f  = { name = " Find"              },
      g  = { name = " Git"               },
      h  = { name = "󱕘 Harpoon"           },
      i  = { name = " Automation"        },
      io = { name = " Open"              },
      j  = { name = " Join"              },
      k  = { name = " Color"             },
      l  = { name = " LSP"               },
      m  = { name = " Modes"             },
      ml = { name = "󰉦 Lush"              },
      n  = { name = " Compiler Explorer" }, -- 
      o  = { name = " Open"              },
      p  = { name = " Profile"           }, -- 
      pl = { name = "󱑤 Load"              },
      r  = { name = " Run"               },
      rq = { name = " LeetCode"          },
      s  = { name = "󱝆 Surf"              },
      t  = { name = "󰙨 Test"              },
      ts = { name = "󱘎 TreeSitter"        },
      u  = { name = "󰚰 Update"            },
      v  = { name = " Vertical"          },
      y  = { name = "󱘣 Neoclip"           }, -- TODO
      w  = { name = " Workspace"         },
      x  = { name = "󰟃 Other"             },
      z  = { name = " Zen"               },
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
