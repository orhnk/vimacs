-- TODO: Remove telescope as a dependency and lazy load plugins later for squeezed performance

local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {

  { -- WhichKey overrides
    "folke/which-key.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey") --<-- from NvChad's config
      require("which-key").setup(opts) --<-- From NvChad's config'
      require("custom.configs.which-key").prefixes()
    end,
  },

  -- Override plugin definition options
  {
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
  },

  { -- Overriding NvChad Telescope options. (Dirty hack)
    "nvim-telescope/telescope.nvim",

    -- NvChad:
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end

      -- Emoji picker:
      require("telescope").setup {
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
          perfanno = {
            -- Special mappings in the telescope finders
            mappings = {
              ["i"] = {
                -- Find hottest callers of selected entry
                ["<C-h>"] = require("telescope").extensions.perfanno.actions.hottest_callers,
                -- Find hottest callees of selected entry
                ["<C-l>"] = require("telescope").extensions.perfanno.actions.hottest_callees,
              },

              ["n"] = {
                ["gu"] = require("telescope").extensions.perfanno.actions.hottest_callers,
                ["gd"] = require("telescope").extensions.perfanno.actions.hottest_callees,
              },
            },
          },
        },
      }
    end,

    opts = function()
      local settings = require "plugins.configs.telescope"

      settings.defaults.mappings.i = {
        ["<leader>tp"] = require("telescope.actions.layout").toggle_preview,
      }
      settings.extensions_list = {
        "themes",
        "terms",
      }

      return settings
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function(_, opts)
      require("copilot").setup { opts }
    end,

    opts = {
      panel = {
        enabled = true,
        auto_refresh = true, -- Refresh suggestions when typing to the buffer
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-Tab>",
          accept_word = false,
          accept_line = false,
          next = "<C-l>",
          prev = "<C-h>",
          dismiss = "<C-q>",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
        svn = true,
        cvs = true,
        ["."] = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 16.x
      server_opts_overrides = {},
    },
  },

  -- C++ development
  -- Nice but limited cpp codegen features which I'll (probably) not use (if you want create keymapps)
  {
    "Badhi/nvim-treesitter-cpp-tools",
    requires = { "nvim-treesitter/nvim-treesitter" },

    keys = {
      { "<leader>cpl", ":TSCppDefineClassFunc", mode = "n", desc = "Define Class function" },
      { "<leader>cpm", ":TSCppMakeConcreteClass", mode = "n", desc = "Make Concrete Class" },
      { "<leader>cpo", ":TSCppRuleOf3", mode = "n", desc = "Rule of 3" },
      { "<leader>cpp", ":TSCppRuleOf5", mode = "n", desc = "Rule of 5" },

      { "<leader>cpl", ":TSCppDefineClassFunc", mode = "v", desc = "Define Class function" },
      { "<leader>cpm", ":TSCppMakeConcreteClass", mode = "v", desc = "Make Concrete Class" },
      { "<leader>cpo", ":TSCppRuleOf3", mode = "v", desc = "Rule of 3" },
      { "<leader>cpp", ":TSCppRuleOf5", mode = "v", desc = "Rule of 5" },
    },

    config = function()
      require("nt-cpp-tools").setup {
        preview = {
          quit = "q", -- optional keymapping for quit preview
          accept = "<tab>", -- optional keymapping for accept preview
        },
        -- header_extension = "h", -- optional
        -- source_extension = "cxx", -- optional
        -- custom_define_class_function_commands = { -- optional
        --   TSCppImplWrite = {
        --   output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
        -- },
        --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
        -- },
      }
    end,
  },

  { -- Translate
    "voldikss/vim-translator",

    keys = {
      { "<leader>tt", ":TranslateW<CR>", mode = "v", desc = "Translate selected test" },
      { "<leader>tc", ":TranslateX<CR>", mode = "v", desc = "Translate & Copy selected text" },
      { "<leader>tr", ":TranslateR<CR>", mode = "v", desc = "Replace text with Translation" },
    },

    config = function()
      vim.g.translator_target_lang = "tr"
      vim.g.translator_window_type = "popup"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  { -- Emoji Picker
    "ziontee113/icon-picker.nvim",

    keys = {
      { "<leader>fe", ":PickEverything<CR>", mode = "n", desc = "Glyph Picker" }, -- Gigantic Search Base
    },

    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = false,
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",

    dependencies = {

      { -- Tabnine
        "tzachar/cmp-tabnine",

        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",

        config = function(_, opts)
          local tabnine = require "cmp_tabnine.config"
          tabnine:setup { opts }
        end,

        opts = {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          ignored_file_types = {
            -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
          },
          show_prediction_strength = false,
        },
      },

      { -- Copilot
        "zbirenbaum/copilot-cmp",

        dependencies = {
          "zbirenbaum/copilot.lua",

          opts = {
            suggestion = {
              enabled = false,
              -- auto_trigger = false,
            },

            panel = {
              enabled = false,
            },
          },
        },

        config = function()
          require("copilot_cmp").setup()
        end,
      },
    }, -- END NV-CMP DEPENDENCIES

    -- ALL OPTS GET MERGED WITH DEFAULTS IN LAZY.nvim
    opts = {
      mapping = {
        -- Disable <TAB> for autocompletion to not go crazy!!!
        ["<Tab>"] = require("cmp").mapping(function(fallback)
          if require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),

        ["<S-Tab>"] = require("cmp").mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },

      sources = {
        -- -- AI
        -- Copilot
        { name = "copilot" },
        -- Tabnine
        { name = "cmp_tabnine" },

        -- Other Sources
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "crates" },
        -- { name = "calc" },
      },
    },
  },

  { -- Code runner
    "Zeioth/compiler.nvim",
    keys = {
      { "<leader>rr", ":CompilerOpen<CR>", mode = "n", desc = "Open project runner" },
      { "<leader>rt", ":CompilerToggleResults<CR>", mode = "n", desc = "Toggle project runner window" },
    },

    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },

  { -- The task runner for compiler.nvim
    "stevearc/overseer.nvim",
    commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd "OverseerClose"
          end,
        },
      },
    },
  },

  { -- Integrated Tests -- CONFIG
    "nvim-neotest/neotest",

    keys = {
      { "<leader>to", ":Neotest summary<CR>", mode = "n", desc = "Open interactive test session" },
      { "<leader>te", ":Neotest run<CR>", mode = "n", desc = "Run tests for the session" },
    },

    dependencies = {
      "rouge8/neotest-rust", -- Rust development
    },

    requires = {
      -- Required
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },

    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-rust",
          -- require "neotest-vim-test" {
          --   ignore_file_types = { "python", "vim", "lua" },
          -- },
        },
      }
    end,
  },

  -- { -- Diagnostics as a scrollbar (JetBrains feature)
  --   -- NOTE: I deprecate this plugin from CamelVim. This is optional because of the bad performance satellite.nvim has.
  --   -- Opened a issue about this (#51)
  --
  -- --  "lewis6991/satellite.nvim", -- Bad performance But Beautiful
  --   "dstein64/nvim-scrollview", -- Better performance
  --   lazy = false, -- Load on startup
  --
  --   cmd = { "SatelliteEnable", "SatelliteDisable" },
  --
  --   keys = {
  --     { -- This plugin lacks a toggle function
  --       "<leader>sd",
  --       ":SatelliteDisable<CR>",
  --       mode = "n",
  --       desc = "Toggle Satellite",
  --     },
  --   },
  -- },

  { -- Overseer prettifier
    "stevearc/dressing.nvim",

    event = "VeryLazy", -- FIXME

    config = function()
      require("dressing").setup {
        default_prompt = "❯ ",
      }
    end,
  },

  {
    "stevearc/overseer.nvim",

    dependencies = { "stevearc/dressing.nvim" },

    keys = {
      { "<leader>tt", ":OverseerToggle<CR>", mode = "n", desc = "Toggle Task Runner UI" },
      { "<leader>tr", ":OverseerRun<CR>", mode = "n", desc = "Run tasks" },
    },

    config = function()
      require("overseer").setup()
    end,

    opts = {},
  },

  -- { -- Using flash.nvim now
  --   "ggandor/leap.nvim",
  --   config = function()
  --     require("leap").add_default_mappings()
  --   end,
  --   lazy = false, -- leap takes care of lazy loading by itself
  -- },

  { -- Minimap
    "gorbit99/codewindow.nvim",

    keys = {
      { "<leader>mo", "codewindow.toggle_minimap()", mode = "n", desc = "Toggle Minimap" },
      { "<leader>mm", "codewindow.toggle_focus()", mode = "n", desc = "Focus Minimap" },
    },

    config = function()
      local codewindow = require "codewindow"
      codewindow.setup {
        show_cursor = false,
        screen_bounds = "lines",
        window_border = "none",
      }
      codewindow.apply_default_keybinds()
    end,
  },

  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",

    keys = {
      { "<leader>ga", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },

    -- optional, you can also install and use `yq` instead.
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },

    opts = {},
    config = function(_, opts)
      require("gh-actions").setup(opts)
    end,
  },

  {
    "willothy/moveline.nvim",
    event = "VeryLazy",

    --    keys = {
    --      { "<C-M-j>", ':lua require("moveline").down<CR>', mode = "n", desc = "Move line down" },
    --      { "<C-M-k>", ':lua require("moveline").up<CR>', mode = "n", desc = "Move line up" },
    --
    --      { "<C-M-j>", ':lua require("moveline").block_down<CR>', mode = "v", desc = "Move line down" },
    --      { "<C-M-k>", ':lua require("moveline").block_up<CR>', mode = "v", desc = "Move line up" },
    --    },

    config = function()
      local moveline = require "moveline"

      -- My terminal has it's own M-j/k bindings so:
      vim.keymap.set("n", "<C-M-k>", moveline.up)
      vim.keymap.set("n", "<C-M-j>", moveline.down)
      vim.keymap.set("v", "<C-M-k>", moveline.block_up)
      vim.keymap.set("v", "<C-M-j>", moveline.block_down)
    end,
    build = "make",
  },

  {
    "rktjmp/paperplanes.nvim",

    keys = {
      { "<leader>pp", ":PP<CR>", mode = "n", desc = "Send Buffer to Pastebin Client" },
      { "<leader>pp", ":PP<CR>", mode = "v", desc = "Send Seleceted Code to Pastebin Client" },
    },

    config = function()
      require("paperplanes").setup {
        register = "+",
        provider = "0x0.st",
        provider_options = {},
        notifier = vim.notify or print,
      }
    end,
  },

  {
    "NeogitOrg/neogit",

    keys = {
      { "<leader>gg", "<cmd> Neogit<CR>", mode = "n", desc = "Open Neogit" },
    },

    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },

    config = function()
      require("neogit").setup()
    end,
  },

  {
    "ldelossa/gh.nvim",

    dependencies = {
      "ldelossa/litee.nvim",
    },

    keys = {
      { "<leader>gh", ":GH<CR>", mode = "n", desc = "Open Github Client" },
    },

    config = function()
      require("litee.lib").setup()
      require("litee.gh").setup {
        -- deprecated, around for compatibility for now.
        jump_mode = "invoking",
        -- remap the arrow keys to resize any litee.nvim windows.
        map_resize_keys = false,
        -- do not map any keys inside any gh.nvim buffers.
        disable_keymaps = false,
        -- the icon set to use.
        icon_set = "default",
        -- any custom icons to use.
        icon_set_custom = nil,
        -- whether to register the @username and #issue_number omnifunc completion
        -- in buffers which start with .git/
        git_buffer_completion = true,
        -- defines keymaps in gh.nvim buffers.
        keymaps = {
          -- when inside a gh.nvim panel, this key will open a node if it has
          -- any futher functionality. for example, hitting <CR> on a commit node
          -- will open the commit's changed files in a new gh.nvim panel.
          open = "<CR>",
          -- when inside a gh.nvim panel, expand a collapsed node
          expand = "zo",
          -- when inside a gh.nvim panel, collpased and expanded node
          collapse = "zc",
          -- when cursor is over a "#1234" formatted issue or PR, open its details
          -- and comments in a new tab.
          goto_issue = "gd",
          -- show any details about a node, typically, this reveals commit messages
          -- and submitted review bodys.
          details = "d",
          -- inside a convo buffer, submit a comment
          submit_comment = "<C-s>",
          -- inside a convo buffer, when your cursor is ontop of a comment, open
          -- up a set of actions that can be performed.
          actions = "<C-a>",
          -- inside a thread convo buffer, resolve the thread.
          resolve_thread = "<C-r>",
          -- inside a gh.nvim panel, if possible, open the node's web URL in your
          -- browser. useful particularily for digging into external failed CI
          -- checks.
          goto_web = "gx",
        },
      }

      --      local wk = require "which-key"
      --      wk.register({
      --        g = {
      --          name = "+Git",
      --          h = {
      --            name = "+Github",
      --            c = {
      --              name = "+Commits",
      --              c = { "<cmd>GHCloseCommit<cr>", "Close" },
      --              e = { "<cmd>GHExpandCommit<cr>", "Expand" },
      --              o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
      --              p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
      --              z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      --            },
      --            i = {
      --              name = "+Issues",
      --              p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      --            },
      --            l = {
      --              name = "+Litee",
      --              t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      --            },
      --            r = {
      --              name = "+Review",
      --              b = { "<cmd>GHStartReview<cr>", "Begin" },
      --              c = { "<cmd>GHCloseReview<cr>", "Close" },
      --              d = { "<cmd>GHDeleteReview<cr>", "Delete" },
      --              e = { "<cmd>GHExpandReview<cr>", "Expand" },
      --              s = { "<cmd>GHSubmitReview<cr>", "Submit" },
      --              z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      --            },
      --            p = {
      --              name = "+Pull Request",
      --              c = { "<cmd>GHClosePR<cr>", "Close" },
      --              d = { "<cmd>GHPRDetails<cr>", "Details" },
      --              e = { "<cmd>GHExpandPR<cr>", "Expand" },
      --              o = { "<cmd>GHOpenPR<cr>", "Open" },
      --              p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
      --              r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
      --              t = { "<cmd>GHOpenToPR<cr>", "Open To" },
      --              z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      --            },
      --            t = {
      --              name = "+Threads",
      --              c = { "<cmd>GHCreateThread<cr>", "Create" },
      --              n = { "<cmd>GHNextThread<cr>", "Next" },
      --              t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      --            },
      --          },
      --        },
      --      }, { prefix = "<leader>" })
    end,
  },

  {
    "debugloop/telescope-undo.nvim",

    keys = {
      { "<leader>tu", ":Telescope undo<CR>", mode = "n", desc = "Open Undo History" },
    },

    config = function()
      require("telescope").load_extension "undo"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",

    keys = {
      { "<leader>ss", ":SymbolsOutline<CR>", mode = "n", desc = "Surf declarations" },
    },

    config = function()
      require("symbols-outline").setup()
    end,
  },

  { -- C/C++ cpp <-> hpp file pairing
    "Everduin94/nvim-quick-switcher",

    keys = {
      {
        "<leader>sw",
        ":lua require('nvim-quick-switcher').toggle('cpp', 'hpp')<CR>",
        mode = "n",
        desc = "Switch To Pair File",
      },
    },

    config = function() end,
  },

  {
    "ThePrimeagen/refactoring.nvim",

    config = function()
      require("refactoring").setup()
    end,

    keys = {
      { "<leader>ce", ":Refactor extract<CR>", mode = "n", desc = "Extract To Function" },
      { "<leader>cv", ":Refactor extract_var<CR>", mode = "n", desc = "Extract To Variable" },
      { "<leader>cb", ":Refactor extract_block<CR>", mode = "n", desc = "Extract To Block" },
      { "<leader>ct", ":Refactor extract_block_to_file<CR>", mode = "n", desc = "Extract Block To File" },
      { "<leader>cn", ":Refactor refactor_names<CR>", mode = "n", desc = "Refactor names" },
      { "<leader>cf", ":Refactor extract_to_file<CR>", mode = "n", desc = "Extract to file" },
      { "<leader>ci", ":Refactor inline_var<CR>", mode = "n", desc = "Inline Variable" },

      { "<leader>ce", ":Refactor extract<CR>", mode = "v", desc = "Extract To Function" },
      { "<leader>cv", ":Refactor extract_var<CR>", mode = "v", desc = "Extract To Variable" },
      { "<leader>cb", ":Refactor extract_block<CR>", mode = "v", desc = "Extract To Block" },
      { "<leader>ct", ":Refactor extract_block_to_file<CR>", mode = "v", desc = "Extract Block To File" },
      { "<leader>cn", ":Refactor refactor_names<CR>", mode = "v", desc = "Refactor names" },
      { "<leader>cf", ":Refactor extract_to_file<CR>", mode = "v", desc = "Extract to file" },
      { "<leader>ci", ":Refactor inline_var<CR>", mode = "v", desc = "Inline Variable" },
    },
  },

  {
    "sourcegraph/sg.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      require("sg").setup {
        -- ... other configuration options ...

        -- Disable LSP suggestions
        on_attach = function(client)
          local buffer_name = vim.fn.expand "%:t"
          if buffer_name ~= "COMMIT_EDITMSG" then
            if client.supports_method "textDocument/formatting" then
              vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format { bufnr = bufnr }
                end,
              })
            end

            if client.resolved_capabilities.document_highlight then
              vim.api.nvim_exec(
                [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
                false
              )
            end
          end
        end,
      }
    end,

    keys = {

      { "<leader>ai", ":CodyChat<CR>", mode = "n", desc = "AI Assistant" },

      {
        "<leader>ad",
        function()
          local line = vim.fn.getline "."
          local start = vim.fn.col "."
          local finish = vim.fn.col "$"
          local text = line:sub(start, finish)
          vim.fn.setreg('"', text)
          vim.cmd [[CodyDo 'Write document for current context']]
        end,
        mode = "n",
        desc = "Generate Document with AI",
      },

      { "<leader>ac", ':CodyDo ""<Left>', mode = "n", desc = "Let AI Write Code" },

      { "<leader>aa", ":CodyTaskAccept<CR>", mode = "n", desc = "Confirm AI work" },

      {
        "<leader>as",
        "<cmd> lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
        mode = "n",
        desc = "AI Search",
      },

      { "<leader>ai", "y:CodyChat<CR><ESC>pG$a<CR>", mode = "v", desc = "Chat Selected Code" },

      {
        "<leader>ad",
        "{:CodyDo 'Write document for current context<CR>'",
        mode = "n",
        desc = "Generate Document with AI",
      },

      {
        "<leader>ar",
        "y:CodyChat<CR>refactor following code:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Refactoring",
      },

      { "<leader>ae", "y:CodyChat<CR>explain following code:<CR><ESC>p<CR>", mode = "v", desc = "Request Explanation" },

      {
        "<leader>af",
        "y:CodyChat<CR>find potential vulnerabilities from following code:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Potential Vulnerabilities",
      },

      {
        "<leader>at",
        "y:CodyChat<CR>rewrite following code more idiomatically:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Idiomatic Rewrite",
      },
    },

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    build = "nvim -l build/init.lua",
  },

  { -- TODO: Fix
    "iamcco/markdown-preview.nvim",

    ft = { "markdown" },

    build = ":call mkdp#util#install()",

    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", mode = "n", desc = "Markdown Preview" },
    },

    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- { -- Allows to use vim command "w" inside CamelCase snake_case etc
  --   "chaoren/vim-wordmotion",
  --   lazy = false,
  -- },

  { -- nvim-dap UI
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  },

  { -- nvim-dap virtual text
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-virtual-text").setup()
    end,
  },

  { -- Debug Adapter Protocol
    "mfussenegger/nvim-dap",

    -- TODO: Move these to configs/nvim-dap.lua
    config = function()
      local dap = require "dap"
      -- dap.set_log_level "TRACE"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = "codelldb",
          args = { "--port", "${port}" },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Reuse configurations for other languages
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,

    keys = {
      { "<leader>dc", "<cmd>lua require('dap').continue()<CR>", mode = "n", desc = "Continue" },
      { "<leader>ds", "<cmd>lua require('dap').step_over()<CR>", mode = "n", desc = "Step Over" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>", mode = "n", desc = "Step Into" },
      { "<leader>do", "<cmd>lua require('dap').step_out()<CR>", mode = "n", desc = "Step Out" },
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", mode = "n", desc = "Toggle Breakpoint" },
      {
        "<leader>dB",
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        mode = "n",
        desc = "Set Breakpoint",
      },
      {
        "<leader>dl",
        "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        mode = "n",
        desc = "Log Point",
      },
      { "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", mode = "n", desc = "Run Last" },
      { "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", mode = "n", desc = "Open REPL" },
      { "<leader>dd", "<cmd>lua require('dapui').toggle()<CR>", mode = "n", desc = "Toggle UI" },
      { "<leader>da", "<cmd>lua require('dapui').eval()<CR>", mode = "n", desc = "Evaluate" },
      { "<leader>du", "<cmd>lua require('dapui').scopes()<CR>", mode = "n", desc = "Scopes" },
      { "<leader>dv", "<cmd>lua require('dapui').variables()<CR>", mode = "n", desc = "Variables" },
      { "<leader>dw", "<cmd>lua require('dapui').watches()<CR>", mode = "n", desc = "Watches" },
      {
        "<leader>de",
        "<cmd>lua require('dapui').set_exception_breakpoints()<CR>",
        mode = "n",
        desc = "Exception Breakpoints",
      },
      { "<leader>di", "<cmd>lua require('dapui').pick_one()<CR>", mode = "n", desc = "Pick One" },
    },
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup {
        snippet_engine = "luasnip",
      }
    end,
    keys = {
      { "<leader>cd", "<cmd>lua require('neogen').generate()<CR>", mode = "n", desc = "Generate Base Documentation" },
    },
  },

  -- { -- Give up bad practices in (neo)vim
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  --   event = "VeryLazy",
  --   config = function()
  --     require("hardtime").setup()
  --   end,
  -- },

  -- { -- Leetcode session inside neovim. Need to set some cookies though
  --   "Dhanus3133/LeetBuddy.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   event = "VeryLazy",
  --
  --   config = function()
  --     require("leetbuddy").setup {}
  --   end,
  --   keys = {
  --     { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
  --     { "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
  --     { "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
  --     { "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Code" },
  --     { "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
  --   },
  -- },

  -- {
  --   "ThePrimeagen/harpoon",
  --   config = function()
  --     require("harpoon").setup()
  --   end,
  -- },

  { -- Optional file manager for telescope-project.nvim
    "nvim-telescope/telescope-file-browser.nvim",

    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

    keys = {
      { "<leader>.", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Find File" },
    },

    config = function()
      -- local fb_actions = require("telescope").extensions.file_browser.actions
      require("telescope").setup {
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
                -- ["<TAB>"] = fb_actions.open, -- TODO
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      }
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension "file_browser"
    end,
  },

  { -- Telescope projects
    "nvim-telescope/telescope-project.nvim",

    -- if you want to enable custom hook
    -- dependencies = {
    --   "ThePrimeagen/harpoon",
    -- },

    keys = {
      {
        "<leader>fp",
        "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
        desc = "Find Project",
      },
    },

    config = function()
      local project_actions = require "telescope._extensions.project.actions"
      require("telescope").setup {
        extensions = {
          project = {
            base_dirs = {
              "~/Github",
              "~/",
              -- { "~/dev/src2" },
              -- { "~/dev/src3", max_depth = 4 },
              -- { path = "~/dev/src4" },
              -- { path = "~/dev/src5", max_depth = 2 },
            },
            -- hidden_files = true, -- default: false --- .git files go brrr
            -- theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
            -- default for on_project_selected = find project files
            -- on_project_selected = function(prompt_bufnr)
            --   -- Do anything you want in here. For example:
            --   project_actions.change_working_directory(prompt_bufnr, false)
            --   require("harpoon.ui").nav_file(1)
            -- end,
          },
        },
      }
      require("telescope").load_extension "project"
    end,
  },

  { -- Toggle case (CamelCase, snake_case, kebab-case, PascalCase, Title Case, UPPER CASE, lower case)
    "UTFeight/vim-case-change",
    keys = {
      { "<M-S>", "<cmd>ToggleCase<cr>", mode = "v", desc = "Toggle Case" },
      { "<M-S>", "<ESC>viw<cmd>ToggleCase<cr>", mode = { "i", "n" }, desc = "Toggle Case" },
    },
  },

  { -- Regexplainer
    "tomiis4/Hypersonic.nvim",
    config = function()
      require("hypersonic").setup {}
    end,

    keys = {
      { "<leader>re", "<cmd>Hypersonic<cr>", mode = { "n", "v" }, desc = "Hypersonic" },
    },
  },

  { -- tasks.json, launch.json etc.
    "Dax89/automaton.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap", -- Debug support for 'launch' configurations (Optional)
      "hrsh7th/nvim-cmp", -- Autocompletion for automaton workspace files (Optional)
      "L3MON4D3/LuaSnip", -- Snippet support for automaton workspace files (Optional)
    },
  },

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

  { -- nvim-dap installer MAYBE
    "jay-babu/mason-nvim-dap.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },

    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        "codelldb",
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
  },

  {
    "Wansmer/treesj",

    dependencies = { "nvim-treesitter/nvim-treesitter" },

    keys = {
      {
        "<leader>jj",
        function()
          require("treesj").toggle()
        end,
        mode = "n",
        desc = "Toggle Treesitter Unjoin",
      },

      {
        "<leader>js",
        function()
          require("treesj").split()
        end,
        mode = "n",
        desc = "Treesitter Split",
      },

      {
        "<leader>jl",
        function()
          require("treesj").join()
        end,
        mode = "n",
        desc = "Treesitter Join Line",
      },
    },

    config = function(_, opts)
      require("treesj").setup { opts }
    end,

    opts = {
      use_default_keymaps = false,
    },
  },

  {
    --          DEFINITELY TAKE A LOOK
    --             IT's AWESOME!!!
    -- -> https://github.com/CKolkey/ts-node-action <-
    --
    -- !!! INTEGRATED WITH BUILT-IN CODE ACTIONS !!!
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },

    keys = {
      {
        "<leader>cs",
        function()
          require("ts-node-action").node_action()
        end,
        mode = "n",
        desc = "Treesitter Code Action", -- Actually Node but...
      },
    },

    config = function(_, opts)
      -- Repo says it is not required if not using custom actions
      require("ts-node-action").setup { opts }
    end,
    opts = {},
  },

  { -- Color Picker (Probably the best one)
    "uga-rosa/ccc.nvim",

    keys = {
      {
        "<leader>kp",
        "<cmd> CccPick<CR>",
        mode = "n",
        desc = "Color Picker",
      },
    },

    config = function(_, opts)
      require("ccc").setup { opts }
    end,

    opts = {
      -- Config
    },
  },

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

  { -- Show lsp signature help when in a function (param info)
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- { -- Highlight Args in functions etc.
  --   -- I think this is a bloat for now
  --   "m-demare/hlargs.nvim",
  --   opts = {},
  --   init = function(_)
  --     require("hlargs").enable()
  --   end,
  --   config = function(_, opts)
  --     require("hlargs").setup()
  --   end,
  -- },

  -- { -- Saved for later MAYBE
  --   "smoka7/multicursors.nvim",
  --   -- event = "VeryLazy",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "smoka7/hydra.nvim",
  --   },
  --   opts = {},
  --   cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  --   keys = {
  --     {
  --       mode = { "v", "n" },
  --       "<Leader>m",
  --       "<cmd>MCstart<cr>",
  --       desc = "Create a selection for selected text or word under the cursor",
  --     },
  --   },
  -- },

  -- { -- Take Beautiful Code shots - (when using paperplanes.nvim I don't need this.)
  --   -- paperplanes.nvim has ray.so backend too!
  --   "TobinPalmer/rayso.nvim",
  --   cmd = { "Rayso" },
  --   config = function()
  --     require("rayso").setup {}
  --   end,
  -- },

  -- { -- Stylish Code Shots
  --   "ellisonleao/carbon-now.nvim",
  --   cmd = "CarbonNow",
  --   ---@param opts cn.ConfigSchema
  --   opts = { [[ your custom config here ]] },
  -- },
  { -- https://github.com/t-troebst/perfanno.nvim
    "t-troebst/perfanno.nvim",

    dependencies = {
      -- {
      "nvim-telescope/telescope.nvim",
      --   opts = {
      --     extensions = {},
      --   },
      -- },
    },

    config = function(_, opts)
      require("perfanno").setup(opts)
    end,

    opts = {
      -- -- List of highlights that will be used to highlight hot lines (or nil to disable highlighting)
      -- line_highlights = nil,
      -- -- Highlight used for virtual text annotations (or nil to disable virtual text)
      -- vt_highlight = nil,
      --
      -- -- Annotation formats that can be cycled between via :PerfCycleFormat
      -- --   "percent" controls whether percentages or absolute counts should be displayed
      -- --   "format" is the format string that will be used to display counts / percentages
      -- --   "minimum" is the minimum value below which lines will not be annotated
      -- -- Note: this also controls what shows up in the telescope finders
      -- formats = {
      --   { percent = true, format = "%.2f%%", minimum = 0.5 },
      --   { percent = false, format = "%d", minimum = 1 },
      -- },
      --
      -- -- Automatically annotate files after :PerfLoadFlat and :PerfLoadCallGraph
      -- annotate_after_load = true,
      -- -- Automatically annotate newly opened buffers if information is available
      -- annotate_on_open = true,
      --
      -- -- Options for telescope-based hottest line finders
      -- telescope = {
      --   -- Enable if possible, otherwise the plugin will fall back to vim.ui.select
      --   enabled = pcall(require, "telescope"),
      --   -- Annotate inside of the preview window
      --   annotate = true,
      -- },
      --
      -- -- Node type patterns used to find the function that surrounds the cursor
      -- ts_function_patterns = {
      --   -- These should work for most languages (at least those used with perf)
      --   default = {
      --     "function",
      --     "method",
      --   },
      --   -- Otherwise you can add patterns for specific languages like:
      --   -- weirdlang = {
      --   --     "weirdfunc",
      --   -- }
      -- },
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    config = function(_, opts)
      require("octo").setup(opts)
    end,

    opts = {
      use_local_fs = false, -- use local files on right side of reviews
      enable_builtin = false, -- shows a list of builtin actions when no action is provided
      default_remote = { "upstream", "origin" }, -- order to try remotes
      ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
      reaction_viewer_hint_icon = "", -- marker for user reactions
      user_icon = " ", -- user icon
      timeline_marker = "", -- timeline marker
      timeline_indent = "2", -- timeline indentation
      right_bubble_delimiter = "", -- bubble delimiter
      left_bubble_delimiter = "", -- bubble delimiter
      github_hostname = "", -- GitHub Enterprise host
      snippet_context_lines = 4, -- number or lines around commented lines
      gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
      timeout = 5000, -- timeout for requests between the remote server
      ui = {
        use_signcolumn = true, -- show "modified" marks on the sign column
      },
      issues = {
        order_by = { -- criteria to sort results of `Octo issue list`
          field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
          direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
        },
      },
      pull_requests = {
        order_by = { -- criteria to sort the results of `Octo pr list`
          field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
          direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
        },
        always_select_remote_on_create = "false", -- always give prompt to select base remote repo when creating PRs
      },
      file_panel = {
        size = 10, -- changed files panel rows
        use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
      },
      mappings = {
        --   issue = {
        --     close_issue = { lhs = "<space>ic", desc = "close issue" },
        --     reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
        --     list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
        --     reload = { lhs = "<C-r>", desc = "reload issue" },
        --     open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        --     copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        --     add_assignee = { lhs = "<space>aa", desc = "add assignee" },
        --     remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
        --     create_label = { lhs = "<space>lc", desc = "create label" },
        --     add_label = { lhs = "<space>la", desc = "add label" },
        --     remove_label = { lhs = "<space>ld", desc = "remove label" },
        --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
        --     add_comment = { lhs = "<space>ca", desc = "add comment" },
        --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
        --     next_comment = { lhs = "]c", desc = "go to next comment" },
        --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
        --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
        --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
        --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
        --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
        --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
        --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
        --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
        --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
        --   },
        --   pull_request = {
        --     checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
        --     merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
        --     squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
        --     list_commits = { lhs = "<space>pc", desc = "list PR commits" },
        --     list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
        --     show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
        --     add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
        --     remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
        --     close_issue = { lhs = "<space>ic", desc = "close PR" },
        --     reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
        --     list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
        --     reload = { lhs = "<C-r>", desc = "reload PR" },
        --     open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
        --     copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        --     goto_file = { lhs = "gf", desc = "go to file" },
        --     add_assignee = { lhs = "<space>aa", desc = "add assignee" },
        --     remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
        --     create_label = { lhs = "<space>lc", desc = "create label" },
        --     add_label = { lhs = "<space>la", desc = "add label" },
        --     remove_label = { lhs = "<space>ld", desc = "remove label" },
        --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
        --     add_comment = { lhs = "<space>ca", desc = "add comment" },
        --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
        --     next_comment = { lhs = "]c", desc = "go to next comment" },
        --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
        --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
        --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
        --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
        --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
        --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
        --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
        --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
        --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
        --   },
        --   review_thread = {
        --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
        --     add_comment = { lhs = "<space>ca", desc = "add comment" },
        --     add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
        --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
        --     next_comment = { lhs = "]c", desc = "go to next comment" },
        --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
        --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
        --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
        --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
        --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
        --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
        --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
        --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
        --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
        --   },
        --   submit_win = {
        --     approve_review = { lhs = "<C-a>", desc = "approve review" },
        --     comment_review = { lhs = "<C-m>", desc = "comment review" },
        --     request_changes = { lhs = "<C-r>", desc = "request changes review" },
        --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        --   },
        --   review_diff = {
        --     add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
        --     add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
        --     focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
        --     toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
        --     next_thread = { lhs = "]t", desc = "move to next thread" },
        --     prev_thread = { lhs = "[t", desc = "move to previous thread" },
        --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        --     toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
        --     goto_file = { lhs = "gf", desc = "go to file" },
        --   },
        --   file_panel = {
        --     next_entry = { lhs = "j", desc = "move to next changed file" },
        --     prev_entry = { lhs = "k", desc = "move to previous changed file" },
        --     select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
        --     refresh_files = { lhs = "R", desc = "refresh changed files panel" },
        --     focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
        --     toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
        --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
        --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        --     toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
        --   },
      },
    },
  },

  { -- Folding. The fancy way
    "kevinhwang91/nvim-ufo",

    -- event = "VeryLazy",

    keys = {
      -- Use z_ instead
      {
        --    INVALID!
        "<leader>lp",
        "",
        mode = "n",
        desc = "Enable UFO",
      },

      -- {
      --   "<leader>lR",
      --   "<cmd>lua require('ufo').openAllFolds()<cr>",
      --   mode = "n",
      --   desc = "Open All Folds",
      -- },
      --
      -- {
      --   "<leader>lM",
      --   "<cmd>lua require('ufo').closeAllFolds()<cr>",
      --   mode = "n",
      --   desc = "Close All Folds",
      -- },
    },

    dependencies = {
      {
        "kevinhwang91/promise-async",
      },

      {
        "yaocccc/nvim-foldsign",

        -- event = "CursorHold",

        config = function()
          require("nvim-foldsign").setup()
        end,

        opts = {
          offset = -2,
          foldsigns = {
            open = "", -- mark the beginning of a fold
            close = "↪", -- show a closed fold
            seps = { "│", "┃" }, -- open fold middle marker
          },
        },
      },
    },

    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup {
        opts,
        -- enable_get_fold_virt_text = true,
        fold_virt_text_handler = handler,
      }
    end,

    opts = {
      open_fold_hl_timeout = 150,
      -- close_fold_kinds = { "imports", "comment" },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },

  { -- Lsp lens Show References, Definitions etc. as virtual text
    -- Not working smoothly in every language
    "VidocqH/lsp-lens.nvim",

    keys = {
      { "<leader>cl", "<cmd> LspLensToggle<CR>", mode = "n", desc = "Enable Lsp Lens" },
    },

    config = function(_, opts)
      require("lsp-lens").setup(opts)
    end,

    opts = {
      enable = true,
      include_declaration = false, -- Reference include declaration

      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implements = true,
      },

      ignore_filetype = {
        "prisma",
      },
    },
  },

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

  { -- Show context on delimiter. (eg:..
    --   fn some(a, b ,c) {             |
    --   some_action();                 |
    --   } // fn some(a, b ,c) <--------'
    -- )

    -- TODO: Fix issue #47 on repo
    "code-biscuits/nvim-biscuits",

    keys = {
      {
        "<leader>bb",
        function()
          require("nvim-biscuits").toggle_biscuits()
        end,
        mode = "n",
        desc = "Enable Biscuits",
      },
    },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    config = function(_, opts)
      require("nvim-biscuits").setup(opts)
    end,

    opts = {
      -- toggle_keybind = "<leader>bt", -- TODO: Add doc for which-key
      cursor_line_only = true,
      show_on_start = true,
    },
  },

  { -- Built-in cheats
    "sudormrfbin/cheatsheet.nvim",

    cmd = { "Cheatsheet" },

    keys = {
      {
        "<leader>ch",
        "<cmd>Cheatsheet<cr>",
        mode = "n",
        desc = "Toggle Cheatsheet",
      },
    },

    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },

  { -- Rust Cargo.toml integration
    -- https://github.com/Saecki/crates.nvim#functions
    "Saecki/crates.nvim",

    keys = {
      {
        "<leader>cxt",
        function()
          require("crates").toggle()
        end,
        mode = "n",
        desc = "Toggle UI elements",
      },

      {
        "<leader>cxr",
        function()
          require("crates").reload()
        end,
        mode = "n",
        desc = "Reload",
      },

      {
        "<leader>cxv",
        function()
          require("crates").show_versions_popup()
        end,
        mode = "n",
        desc = "Show Version",
      },

      {
        "<leader>cxf",
        function()
          require("crates").show_features_popup()
        end,
        mode = "n",
        desc = "Show Feature",
      },

      {
        "<leader>cxd",
        function()
          require("crates").show_dependencies_popup()
        end,
        mode = "n",
        desc = "Show Dependencies",
      },

      {
        "<leader>cxu",
        function()
          require("crates").update_crate()
        end,
        mode = "n",
        desc = "Update Crate",
      },

      {
        "<leader>cxu",
        function()
          require("crates").update_crates()
        end,
        mode = "v",
        desc = "Update Selected Crates",
      },

      {
        "<leader>cxa",
        function()
          require("crates").update_all_crates()
        end,
        mode = "n",
        desc = "Update All Crates",
      },

      {
        "<leader>cxU",
        function()
          require("crates").upgrade_crate()
        end,
        mode = "n",
        desc = "Upgrade Crate",
      },

      {
        "<leader>cxU",
        function()
          require("crates").upgrade_crates()
        end,
        mode = "v",
        desc = "Upgrade Selected Crates",
      },
      {
        "<leader>cxA",
        function()
          require("crates").upgrade_all_crates()
        end,
        mode = "n",
        desc = "Upgrade All Crates",
      },

      {
        "<leader>cxe",
        function()
          require("crates").expand_plain_crate_to_inline_table()
        end,
        mode = "n",
        desc = "Inline Crate to Table",
      },

      {
        "<leader>cxE",
        function()
          require("crates").extract_crate_into_table()
        end,
        mode = "n",
        desc = "Extract Crate to table",
      },

      {
        "<leader>cxH",
        function()
          require("crates").open_homepage()
        end,
        mode = "n",
        desc = "Open Crate Home Page",
      },

      {
        "<leader>cxR",
        function()
          require("crates").open_repository()
        end,
        mode = "n",
        desc = "Open Crate Repository",
      },

      {
        "<leader>cxD",
        function()
          require("crates").open_documentation()
        end,
        mode = "n",
        desc = "Open Crate Documentation",
      },

      {
        "<leader>cxC",
        function()
          require("crates").open_crates_io()
        end,
        mode = "n",
        desc = "Open Crate on crates.io",
      },

      {
        "<leader>cxK",
        function()
          local filetype = vim.bo.filetype
          if vim.tbl_contains({ "vim", "help" }, filetype) then
            vim.cmd("h " .. vim.fn.expand "<cword>")
          elseif vim.tbl_contains({ "man" }, filetype) then
            vim.cmd("Man " .. vim.fn.expand "<cword>")
          elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end,
        mode = "n",
        desc = "Open Crate Documentation in a PopUp",
      },
    },

    -- tag = "v0.3.0", -- Adventurous but Featureful
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function(_, opts)
      require("crates").setup(opts)
    end,

    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },

  { -- Better quickfix window including telescope integration, code view etc.
    -- TODO: improve this
    "kevinhwang91/nvim-bqf",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },

      { -- OPTIONAL for fuzzy searching
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },

      { -- Treesitter
        "nvim-treesitter/nvim-treesitter",
      },
    },

    keys = {
      {
        "<leader>fq",
        [[ <cmd> vimgrep /\w\+/j % | copen<CR> ]],
        mode = "n",
        desc = "QuickFix Window",--[[ { noremap = true, silent = true } ]]
      },

      {
        "<leader>li",
        function()
          vim.diagnostic.setloclist()
        end,
        mode = "n",
        desc = "Diagnostic SetLocList",--[[ { noremap = true, silent = true } ]]
      },

      -- -- FIXME: Doesn't work
      -- {
      --   "gr",
      --   function()
      --     vim.lsp.buf.references()
      --   end,
      --   mode = "n",
      --   desc = "LSP references",
      -- },
      --
      -- {
      --   "gi",
      --   function()
      --     vim.lsp.buf.implementation()
      --   end,
      --   mode = "n",
      --   desc = "LSP implementation",
      -- },
      --
      -- {
      --   "gd",
      --   function()
      --     vim.lsp.buf.definition()
      --   end,
      --   mode = "n",
      --   desc = "LSP definition",
      -- },
      --
      -- {
      --   "gD",
      --   function()
      --     vim.lsp.buf.declaration()
      --   end,
      --   mode = "n",
      --   desc = "LSP declaration",
      -- },
    },

    config = function(_, opts)
      vim.cmd [[
          hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
          hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
          hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
          hi link BqfPreviewRange Search
      ]]

      require("bqf").setup { opts }
      -- Better UI in quickfix window:
      -- https://github.com/kevinhwang91/nvim-bqf/tree/c920a55c6153766bd909e474b7feffa9739f07e8#format-new-quickfix
      -- https://github.com/kevinhwang91/nvim-bqf/tree/c920a55c6153766bd909e474b7feffa9739f07e8#rebuild-syntax-for-quickfix
    end,

    opts = {
      auto_enable = true,
      auto_resize_height = true, -- highly recommended enable
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 102k
            ret = false
          elseif bufname:match "^fugitive://" then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end,
      },
      -- make `drop` and `tab drop` to become preferred
      func_map = {
        drop = "o",
        openc = "O",
        split = "<C-s>",
        tabdrop = "<C-t>",
        -- set to empty string to disable
        tabc = "",
        ptogglemode = "z,",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  { -- Jump Jump Jump
    "folke/flash.nvim",
    -- event = "VeryLazy",
    ---@type Flash.Config
    opts = require("custom.configs.flash").opts,
    keys = require("custom.configs.flash").keys,
  },

  {
    "jubnzv/mdeval.nvim",

    cmd = "MdEval",

    keys = {
      {
        "<leader>cmd", -- TODO: refactor this to use <leader>c prefix
        "<cmd> MdEval<cr>",
        mode = "n",
        desc = "Eval Code Snip",
      },

      config = function(_, opts)
        require("mdeval").setup(opts)
      end,

      opts = {
        -- Don't ask before executing code blocks
        require_confirmation = false,
        -- Change code blocks evaluation options.
        eval_options = {
          -- Set custom configuration for C++
          cpp = {
            command = { "clang++", "-std=c++20", "-O0" },
            default_header = [[
                              #include <iostream>
                              #include <vector>
                              using namespace std;
                             ]],
          },
          -- Add new configuration for Racket
          racket = {
            command = { "racket" }, -- Command to run interpreter
            language_code = "racket", -- Markdown language code
            exec_type = "interpreted", -- compiled or interpreted
            extension = "rkt", -- File extension for temporary files
          },
        },
      },
    },
  },

  { -- Visualize git conflicts MAYBE
    "akinsho/git-conflict.nvim",

    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },

    opts = {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = "copen", -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },

    version = "*",

    config = function(_, opts)
      require("git-conflict").setup(opts)
    end,
  },

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
}

return plugins

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
