-- {
--   "mg979/vim-visual-multi",
--   -- cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
--   keys = {
--     {
--       mode = { "v", "n" },
--       "<C-x>",
--       "<cmd>MCstart<cr>", -- invalid
--       desc = "Multi Cursors",
--     },
--   },
-- },

-- Using TreeSJ now.
-- { -- Opposite of vim's J (Join like)
--   "AckslD/nvim-trevJ.lua",
--   config = function()
--     require("trevj").setup {
--       containers = {
--         lua = {
--           table_constructor = { final_separator = ",", final_end_line = true },
--           arguments = { final_separator = false, final_end_line = true },
--           parameters = { final_separator = false, final_end_line = true },
--         },
--         -- ... -- other filetypes
--       },
--     }
--   end,
--
--   keys = {
--     { "<leader>jo", "<cmd>lua require('trevj').format_at_cursor()<cr>", mode = "n", desc = "Format" },
--     -- { "<leader>jo", "<cmd>lua require('trevj').format_at_cursor()<cr>", mode = "v", desc = "Format" },
--   },
-- },

-- { -- Use builtin `:sort` instead
--   "sQVe/sort.nvim",
--
--   keys = {
--     {
--       "<leader>sq",
--       "<cmd> Sort<CR>",
--       mode = "v",
--       desc = "Sort Selection",
--     },
--   },
--
--   config = function(_, opts)
--     require("sort").setup {
--       opts,
--     }
--   end,
--
--   opts = {
--     -- Config
--   },
-- },

-- { -- Pretty buggy (and inperformant I think) but cool
--   "nvim-treesitter",
--   dependencies = {
--     "filNaj/tree-setter",
--   },
--
--   -- Override default config (By appending)
--   opts = {
--     tree_setter = {
--       enable = true,
--     },
--   },
-- },

--  -- Old toggle case plugin
--   "johmsalas/text-case.nvim",
--
--   keys = {
--     { "<leader>sq", "<cmd>lua require('textcase').toggle()<cr>", mode = "n", desc = "Toggle Case" },
--     { "<leader>sq", "<cmd>lua require('textcase').toggle()<cr>", mode = "v", desc = "Toggle Case" },
--   },
--
--   config = function()
--     require("textcase").setup {
--       prefix = "<leader>s",
--     }
--   end,
-- },

-- { -- COC-like virtual text type annotations
--   -- Didn't work though :(
--   -- Used with nvim_lsp which I don't
--   "jubnzv/virtual-types.nvim",
--   event = "VeryLazy",
-- },

-- { -- I don't like it
--   "HiPhish/rainbow-delimiters.nvim",
--
--   event = "VeryLazy",
--
--   config = function(_, opts)
--     require "rainbow-delimiters.setup" { opts }
--   end,
--
--   opts = { -- Erroneous
--     --   strategy = {
--     --     [""] = require("rainbow_delimiters").strategy["global"],
--     --     commonlisp = require("rainbow_delimiters").strategy["local"],
--     --   },
--     --   query = {
--     --     [""] = "rainbow-delimiters",
--     --     latex = "rainbow-blocks",
--     --   },
--     --   highlight = {
--     --     "RainbowDelimiterRed",
--     --     "RainbowDelimiterYellow",
--     --     "RainbowDelimiterBlue",
--     --     "RainbowDelimiterOrange",
--     --     "RainbowDelimiterGreen",
--     --     "RainbowDelimiterViolet",
--     --     "RainbowDelimiterCyan",
--     --   },
--     --   blacklist = { "c", "cpp" },
--   },
-- },

-- { -- custom w, e, b motions to navigate TextWritten_like_THIS
--   "chrisgrieser/nvim-spider",
--   keys = {
--     { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
--     { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
--     { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
--     { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
--
--     config = function(_, opts)
--       require("spider").setup(opts)
--     end,
--
--     opts = {
--       skipInsignificantPunctuation = true,
--     },
--   },
-- },

-- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
--   f
-- },

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--   "mg979/vim-visual-multi",
--   lazy = false,
-- }

-- DELETETHIS
local M = {
  "L3MON4D3/LuaSnip",

  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "molleweide/LuaSnip-snippets.nvim",
  },

  keys = {
    {
      "<C-s>",
      function()
        local ls = require "luasnip"
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,

      mode = { "i", "s" },
      silent = true,
    },
  },
  -- opts = {
  --   history = true,
  --   updateevents = "TextChanged,TextChangedI",
  --
  --   leave = function()
  --     local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
  --     if snip and snip.generate_doc == true then
  --       require("neogen").generate()
  --     end
  --   end,
  -- },

  -- init = function()
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "LuaSnipPostExpand",
  --   -- command = "echo 'LuaSnipPostExpand'",
  --   callback = function()
  --     require("neogen").generate()
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "LuasnipPreExpand",
  --   callback = function()
  --     vim.cmd [[echo "LuasnipInsertNodeEnter"]]
  --     -- local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
  --     -- if snip and snip.generate_doc == true then
  --     require("neogen").generate()
  --     -- end
  --   end,
  -- })
  -- end,

  config = function(opts)
    -- require("plugins.configs.others").luasnip(opts)
    require("luasnip").config.set_config(opts)

    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   callback = function()
    --     require("neogen").generate()
    --   end,
    -- })

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "LuasnipPreExpand",
    --   callback = function()
    --     -- get event-parameters from `session`.
    --     local snippet = require("luasnip").session.event_node
    --     local expand_position = require("luasnip").session.event_args.expand_pos
    --
    --     print(
    --       string.format(
    --         "expanding snippet %s at %s:%s",
    --         table.concat(snippet:get_docstring(), "\n"),
    --         expand_position[1],
    --         expand_position[2]
    --       )
    --     )
    --   end,
    -- })

    -- vscode format
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

    -- snipmate format
    require("luasnip.loaders.from_snipmate").load()
    require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

    -- lua format
    require("luasnip.loaders.from_lua").load()
    require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        if
          require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
        then
          require("luasnip").unlink_current()
        end
      end,
    })
  end,
}
