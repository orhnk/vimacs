-- TODO: Remove telescope as a dependency and lazy load plugins later for squeezed performance.confconf

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

  { -- Overriding NvChad Telescope options. (Dirty hack)
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "t-troebst/perfanno.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "debugloop/telescope-undo.nvim",
    },

    opts = {
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
      extensions_list = {
        -- "file_browser", -- Lazy loading it
        "undo", -- FIXME: Lazy load
        -- others are lazy loaded

        -- NvChad defaults
        "themes",
        "terms",
      },
    },

    -- Toggles preview window
    -- opts = function()
    --   local settings = require "plugins.configs.telescope"
    --
    --   settings.defaults.mappings.i = {
    --     ["<leader>tp"] = require("telescope.actions.layout").toggle_preview,
    --   }
    --   settings.extensions_list = {
    --     "themes",
    --     "terms",
    --   }
    --
    --   return settings
    -- end,
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

    opts = require("custom.configs.copilot").opts,
  },

  -- C++ development
  -- Nice but limited cpp codegen features which I'll (probably) not use (if you want create keymapps)
  {
    "Badhi/nvim-treesitter-cpp-tools",

    requires = { "nvim-treesitter/nvim-treesitter" },
    keys = require("custom.configs.cpp").treesitter.keys,
    opts = require("custom.configs.cpp").treesitter.opts,

    config = function(_, opts)
      require("nt-cpp-tools").setup(opts)
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

  { -- FIXME: Some snippets are not working: e.g fix (toggleable)
    "hrsh7th/nvim-cmp",
    dependencies = require("custom.configs.cmp").dependencies,
    opts = require("custom.configs.cmp").opts,
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

  -- { -- Default nvim motions are good enough
  --   "willothy/moveline.nvim",
  --   event = "VeryLazy",
  --
  --   --    keys = {
  --   --      { "<C-M-j>", ':lua require("moveline").down<CR>', mode = "n", desc = "Move line down" },
  --   --      { "<C-M-k>", ':lua require("moveline").up<CR>', mode = "n", desc = "Move line up" },
  --   --
  --   --      { "<C-M-j>", ':lua require("moveline").block_down<CR>', mode = "v", desc = "Move line down" },
  --   --      { "<C-M-k>", ':lua require("moveline").block_up<CR>', mode = "v", desc = "Move line up" },
  --   --    },
  --
  --   config = function()
  --     local moveline = require "moveline"
  --
  --     -- My terminal has it's own M-j/k bindings so:
  --     vim.keymap.set("n", "<C-M-k>", moveline.up)
  --     vim.keymap.set("n", "<C-M-j>", moveline.down)
  --     vim.keymap.set("v", "<C-M-k>", moveline.block_up)
  --     vim.keymap.set("v", "<C-M-j>", moveline.block_down)
  --   end,
  --   build = "make",
  -- },

  { -- One of the most useful plugins I've ever seen
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

    dependencies = { "ldelossa/litee.nvim" },
    opts = require("custom.configs.gh").opts,
    cmd = { "GH" },
    keys = {
      { "<leader>gh", ":GH<CR>", mode = "n", desc = "Open Github Client" },
    },

    config = function(_, opts)
      require("litee.lib").setup()
      require("litee.gh").setup(opts)
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

  { -- C/C++ cpp <-> hpp file pairing TODO: replace with other.nvim || harpoon
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

    keys = require("custom.configs.refactoring").keys,
  },

  {
    "sourcegraph/sg.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function(_, opts)
      require("sg").setup { opts }
    end,

    opts = require("custom.configs.sg").opts,

    keys = require("custom.configs.sg").keys,

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

    keys = require("custom.configs.nvim-dap").keys,
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

  { -- Leetcode session inside neovim. Need to set some cookies though
    -- Refer to: https://github.com/Dhanus3133/Leetbuddy.nvim#login-to-your-account
    -- Setup requires some additional things
    "Dhanus3133/LeetBuddy.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- event = "VeryLazy",

    config = function()
      require("leetbuddy").setup {}
      -- require("telescope").load_extension "leetbuddy"
    end,

    keys = {
      { "<leader>rqq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>rql", "<cmd>LBQuestion<cr>", desc = "View Question" },
      { "<leader>rqr", "<cmd>LBReset<cr>", desc = "Reset Code" },
      { "<leader>rqt", "<cmd>LBTest<cr>", desc = "Run Code" },
      { "<leader>rqs", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
    },
  },

  { -- (Emacs) Dired-like Optional file manager for telescope-project.nvim
    "nvim-telescope/telescope-file-browser.nvim",

    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = {
          extensions = {
            file_browser = {
              theme = "ivy",
              -- disables netrw and use telescope-file-browser in its place
              hijack_netrw = true,
              mappings = {
                ["i"] = {
                  -- local fb_actions = require("telescope").extensions.file_browser.actions
                  -- your custom insert mode mappings
                  -- ["<TAB>"] = fb_actions.open, -- TODO
                },
                ["n"] = {
                  -- your custom normal mode mappings
                },
              },
            },
          },
        },
      },
      {
        "nvim-lua/plenary.nvim",
      },
    },

    keys = {
      {
        "<leader>.",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "File Manager",
      },
    },

    config = function()
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension "file_browser"
    end,
  },

  -- { -- Telescope projects
  -- -- Migrated to project.nvim
  --   "nvim-telescope/telescope-project.nvim",
  --
  --   -- if you want to enable custom hook
  --   -- dependencies = {
  --   --   "ThePrimeagen/harpoon",
  --   -- },
  --
  --   keys = {
  --     {
  --       "<leader>fp",
  --       "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
  --       desc = "Find Project",
  --     },
  --   },
  --
  --   config = function()
  --     local project_actions = require "telescope._extensions.project.actions"
  --     require("telescope").setup {
  --       extensions = {
  --         project = {
  --           base_dirs = {
  --             "~/Github",
  --             "~/",
  --             -- { "~/dev/src2" },
  --             -- { "~/dev/src3", max_depth = 4 },
  --             -- { path = "~/dev/src4" },
  --             -- { path = "~/dev/src5", max_depth = 2 },
  --           },
  --           -- hidden_files = true, -- default: false --- .git files go brrr
  --           -- theme = "dropdown",
  --           order_by = "asc",
  --           search_by = "title",
  --           sync_with_nvim_tree = true, -- default false
  --           -- default for on_project_selected = find project files
  --           -- on_project_selected = function(prompt_bufnr)
  --           --   -- Do anything you want in here. For example:
  --           --   project_actions.change_working_directory(prompt_bufnr, false)
  --           --   require("harpoon.ui").nav_file(1)
  --           -- end,
  --         },
  --       },
  --     }
  --     require("telescope").load_extension "project"
  --   end,
  -- },

  -- { -- Toggle case (CamelCase, snake_case, kebab-case, PascalCase, Title Case, UPPER CASE, lower case)
  --   "UTFeight/vim-case-change", -- FIXME
  --   keys = {
  --     { "<M-S>", "<cmd>ToggleCase<cr>", mode = "v", desc = "Toggle Case" },
  --     { "<M-S>", "<ESC>viw<cmd>ToggleCase<cr>", mode = { "i", "n" }, desc = "Toggle Case" },
  --   },
  -- },

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
    -- TODO: Replace with Overseer.nvim
    "Dax89/automaton.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap", -- Debug support for 'launch' configurations (Optional)
      "hrsh7th/nvim-cmp", -- Autocompletion for automaton workspace files (Optional)
      "L3MON4D3/LuaSnip", -- Snippet support for automaton workspace files (Optional)
    },

    config = function(_, opts)
      require("automaton").setup(opts)
    end,

    opts = require("custom.configs.automaton").opts,
    keys = require("custom.configs.automaton").keys,
  },

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

  { -- Show lsp signature help when in a function (param info)
    "ray-x/lsp_signature.nvim",
    -- event = "VeryLazy", -- TODO: Add keys to enable as mode
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  { -- Highlight Args in functions etc. -- TODO: Add highlight-mode for this
    -- I think this is a bloat for now
    "m-demare/hlargs.nvim",
    opts = {},
    -- init = function(_) end, --  .enable function locates here by default
    config = function(_, opts)
      require("hlargs").setup(opts) -- Automatically enables the plugin
      require("hlargs").disable() -- So disable it
    end,

    keys = {
      {
        "<leader>zt",
        function()
          require("hlargs").toggle()
        end,
        mode = "n",
        desc = "Toggle Highlight Args",
      },
      {
        "<leader>zd",
        function()
          require("hlargs").enable()
        end,
        mode = "n",
        desc = "Enable Highlight Args",
      },
      {
        "<leader>zl",
        function()
          require("hlargs").disable()
        end,
        mode = "n",
        desc = "Disable Highlight Args",
      },
    },
  },

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

    config = function(_, opts)
      require("perfanno").setup(opts)
    end,

    keys = require("custom.configs.perfanno").keys,
    opts = require("custom.configs.perfanno").opts,
  },

  { -- TODO: CHECKMEOUT
    "pwntester/octo.nvim",
    config = function(_, opts)
      require("octo").setup(opts)
    end,

    dependencies = require("custom.configs.octo").dependencies,
    opts = require("custom.configs.octo").opts,
    keys = require("custom.configs.octo").keys,
    cmd = require("custom.configs.octo").cmd,
  },

  { -- Folding. The fancy way
    "kevinhwang91/nvim-ufo",

    -- event = "VeryLazy",
    keys = {
      {
        "<leader>lp",
        "",
        mode = "n",
        desc = "Enable UFO",
      },
    },

    dependencies = {
      {
        "kevinhwang91/promise-async",
      },
      {
        "yaocccc/nvim-foldsign",

        -- event = "CursorHold",

        config = function(_, opts)
          require("nvim-foldsign").setup(opts)
        end,

        opts = {
          offset = -2,
          foldsigns = {
            open = "", -- mark the beginning of a fold
            close = "↪", -- show a closed fold
            seps = { "│", "┃" }, -- open fold middle marker -- TODO: ADD MORE
          },
        },
      },
    },

    opts = require("custom.configs.ufo").opts,
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
          -- require("nvim-biscuits").toggle_biscuits()
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
      toggle_keybind = "<leader>bt", -- TODO: Add doc for which-key
      cursor_line_only = true,
      show_on_start = true,
    },
  },

  { -- Built-in cheats
    -- AWESOME
    "sudormrfbin/cheatsheet.nvim",

    cmd = { "Cheatsheet" },

    keys = {
      {
        "<leader>xc",
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

    keys = require("custom.configs.rust").keys,

    tag = "v0.3.0", -- Adventurous but Featureful
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require("custom.configs.rust").opts,
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },

  { -- Better quickfix window including telescope integration, code view etc.
    -- TODO: improve this
    "kevinhwang91/nvim-bqf",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },

      { -- OPTIONAL for fuzzy searching TODO: Replace MAYBE
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },

      { -- Treesitter
        "nvim-treesitter/nvim-treesitter",
      },
    },

    keys = require("custom.configs.nvim-bqf").keys,
    opts = require("custom.configs.nvim-bqf").opts,

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
    keys = require("custom.configs.mdeval").keys,
  },
  --| NOTE: Could be
  { -- Visualize git conflicts MAYBE
    "akinsho/git-conflict.nvim",

    -- TODO: Add keys
    cmd = require("custom.configs.git-conflict").cmd,
    opts = require("custom.configs.git-conflict").opts,
    version = "*",

    config = function(_, opts)
      require("git-conflict").setup(opts)
    end,
  },

  { -- TODO: migrate to file
    "krady21/compiler-explorer.nvim",

    config = function(_, opts)
      require("compiler-explorer").setup(opts)
    end,

    opts = {
      url = "https://godbolt.org",
      infer_lang = true, -- Try to infer possible language based on file extension.
      line_match = {
        -- FIXME: defaults are false and they don't work
        -- highlight = true, -- highlight the matching line(s) in the other buffer.
        -- jump = true, -- move the cursor in the other buffer to the first matching line.
      },
      open_qflist = true, --  Open qflist after compilation if there are diagnostics.
      split = "split", -- How to split the window after the second compile (split/vsplit).
      compiler_flags = "", -- Default flags passed to the compiler.
      job_timeout_ms = 25000, -- Timeout for libuv job in milliseconds.
      languages = { -- Language specific default compiler/flags
        --c = {
        --  compiler = "g121",
        --  compiler_flags = "-O2 -Wall",
        --},
      },
    },

    -- cmd = { -- TODO
    --   ":CECompile",
    --   ":CECompileLive",
    --   ":CEFormat",
    --   ":CEAddLibrary",
    --   ":CELoadExample",
    --   ":CEOpenWebsite",
    --   ":CEDeleteCache",
    --   ":CEShowTooltip",
    --
    --   ":CEGotoLabel",
    -- },
    keys = { --- IDK wheter they work under v mode
      { "<leader>nc", ":CECompile<CR>", mode = "n", desc = "Compile" },
      { "<leader>nl", ":CECompileLive<CR>", mode = "n", desc = "Compile Live" },
      { "<leader>nf", ":CEFormat<CR>", mode = "n", desc = "Format" },
      { "<leader>na", ":CEAddLibrary<CR>", mode = "n", desc = "Add Library" },
      { "<leader>ne", ":CELoadExample<CR>", mode = "n", desc = "Load Example" },
      { "<leader>nw", ":CEOpenWebsite<CR>", mode = "n", desc = "Open Website" },
      { "<leader>nd", ":CEDeleteCache<CR>", mode = "n", desc = "Delete Cache" },
      { "<leader>ns", ":CEShowTooltip<CR>", mode = "n", desc = "Show Tooltip" },
      { "<leader>ng", ":CEGotoLabel<CR>", mode = "n", desc = "Goto Label" },
    },
  },

  -- { --- FIXME
  --   "p00f/godbolt.nvim",
  --
  --   config = function(_, opts)
  --     require("godbolt").setup(opts)
  --   end,
  --
  --   opts = {
  --     languages = {
  --       cpp = { compiler = "g122", options = {} },
  --       c = { compiler = "cg122", options = {} },
  --       rust = { compiler = "r1650", options = {} },
  --       -- any_additional_filetype = { compiler = ..., options = ... },
  --     },
  --     quickfix = {
  --       enable = true, -- whether to populate the quickfix list in case of errors
  --       auto_open = true, -- whether to open the quickfix list in case of errors
  --     },
  --     url = "https://godbolt.org", -- can be changed to a different godbolt instance
  --   },
  --
  --   -- cmd = {
  --   --   "Godbolt",
  --   --   "GodboltCompiler",
  --   -- },
  --
  --   keys = {
  --     { "<leader>nc", ":Godbolt<CR>", mode = { "n", "v" }, desc = "Compile" },
  --     -- Note that telescope could be fzf, fzy + nvim-fzy, skim
  --     { "<leader>nt", ":GodboltCompiler telescope<CR>", mode = { "n", "v" }, desc = "Telescope Compile" },
  --   },
  -- },

  { -- TODO: Config
    "rktjmp/lush.nvim",

    cmd = {
      "Lushify",
      "LushImport",
      "LushRunTutorial",
    },

    keys = {
      { "<leader>mll", "<cmd> Lushify<CR>", mode = "n", desc = "Lushify Colorscheme" },
      { "<leader>mli", "<cmd> LushImport<CR>", mode = "n", desc = "Lush Import" },
      { "<leader>mlt", "<cmd> LushRunTutorial<CR>", mode = "n", desc = "Lush Tutorial" },
      { "<leader>mlp", '"zp', mode = "n", desc = "Lush Paste" },
    },
  },

  -- { -- TODO: Config && Remove vim one
  --   "rgroli/other.nvim",
  -- },

  { -- TODO: Config
    "folke/twilight.nvim",

    cmd = {
      "Twilight",
      "TwilightEnable",
      "TwilightDisable",
    },

    keys = {
      { "<leader>mt", "<cmd>Twilight<CR>", mode = "n", desc = "Toggle Twilight" },
    },

    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 10, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- exclude these filetypes
    },
  },

  { -- FIXME: Breaks Lazy.nvim startup installation
    "mawkler/modicator.nvim",
    -- dependencies = 'mawkler/onedark.nvim', -- Add your colorscheme plugin here

    -- event = "BufRead",

    keys = {
      { "<leader>md", "", mode = "n", desc = "Enable Cursor Mod Line" },
    },

    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,

    config = function(_, opts)
      require("modicator").setup(opts)
    end,

    opts = {
      -- Show warning if any required option is missing
      show_warnings = true,
      highlights = {
        -- Default options for bold/italic
        defaults = {
          bold = true,
          italic = false,
        },
      },
    },
  },

  {
    "folke/zen-mode.nvim",

    config = function(_, opts)
      require("zen-mode").toggle(opts)
    end,

    keys = {
      { "<leader>zz", "<cmd>ZenMode<CR>", mode = "n", desc = "Toggle Zen Mode" },
    },

    opts = {
      {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
          -- this will change the font size on wezterm when in zen mode
          -- See alse also the Plugins/Wezterm section in this projects README
          wezterm = {
            enabled = false,
            -- can be either an absolute font size or the number of incremental steps
            font = "+4", -- (10% increase per step)
          },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      },
    },
  },

  { -- TODO add hlgroups according to repo
    "ThePrimeagen/harpoon",

    config = function(_, opts)
      require("harpoon").setup(opts)
      require("telescope").load_extension "harpoon"
    end,

    opts = {
      global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- enable tabline with harpoon marks
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      },
    },

    keys = {
      {
        "<leader>hm",
        "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        mode = "n",
        desc = "Toggle Harpoon Menu",
      },

      {
        "<leader>ha",
        "<cmd>lua require('harpoon.mark').add_file()<cr>",
        mode = "n",
        desc = "Add File",
      },

      {
        "<leader>hn",
        "<cmd>lua require('harpoon.ui').nav_next()<cr>",
        mode = "n",
        desc = "Jump to next file",
      },

      {
        "<leader>hp",
        "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
        mode = "n",
        desc = "Jump to previous file",
      },

      { -- FIXME: doesn't work (after loading with :Telescope harpoon)
        "<leader>ht",
        "<cmd> Telescope harpoon marks<cr>", -- TODO: Lazy load them on this specific keystroke
        mode = "n",
        desc = "Telescope Harpoon",
      },
    },
  },

  -- { -- TODO: Config
  --   "simrat39/rust-tools.nvim",
  --
  --   config = function(_, opts)
  --     require("rust-tools").setup(opts)
  --   end,
  --   opts = {},
  -- },

  { -- TODO FIXME:
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      -- -- Restore from last session
      -- { "kkharji/sqlite.lua", module = "sqlite" }, -- packer style

      -- you'll need at least one of these
      { "nvim-telescope/telescope.nvim" },
      -- {'ibhagwan/fzf-lua'},
    },

    config = function(_, opts)
      require("neoclip").setup(opts)
      require("telescope").load_extension "neoclip"
    end,

    keys = {
      { "<leader>yp", "<cmd>Telescope neoclip<cr>", mode = "n", desc = "Telescope Yanks" },

      { -- NOTE: Macros are recorded after this plugin is loaded
        "<leader>ym",
        function()
          require("telescope").extensions.macroscope.default()
        end,
        mode = "n",
        desc = "Telescope Macros",
      },
    },

    opts = {
      history = 1000,
      enable_persistent_history = false,
      length_limit = 1048576,
      continuous_sync = false,
      db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
      filter = nil,
      preview = true,
      prompt = nil,
      default_register = '"',
      default_register_macros = "q",
      enable_macro_history = true,
      content_spec_column = true,
      disable_keycodes_parsing = false,
      on_select = {
        move_to_front = false,
        close_telescope = true,
      },
      on_paste = {
        set_reg = false,
        move_to_front = false,
        close_telescope = true,
      },
      on_replay = {
        set_reg = false,
        move_to_front = false,
        close_telescope = true,
      },
      on_custom_action = {
        close_telescope = true,
      },
      keys = {
        telescope = {
          i = {
            select = "<cr>",
            paste = "<c-p>",
            paste_behind = "<c-k>",
            replay = "<c-q>", -- replay a macro
            delete = "<c-d>", -- delete an entry
            edit = "<c-e>", -- edit an entry
            custom = {},
          },
          n = {
            select = "<cr>",
            paste = "p",
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = "P",
            replay = "q",
            delete = "d",
            edit = "e",
            custom = {},
          },
        },
        fzf = {
          select = "default",
          paste = "ctrl-p",
          paste_behind = "ctrl-k",
          custom = {},
        },
      },
    },
  },

  -- TODO: Add More cheatsheets.
  -- TODO: Enable multicursors

  { --  The superior project management solution for neovim.
    "ahmedkhalf/project.nvim",
    dependencies = {
      {
        "nvim-tree/nvim-tree.lua",
        opts = {
          sync_root_with_cwd = true,
          respect_buf_cwd = true,
          update_focused_file = {
            enable = true,
            update_root = true,
          },
        },
      },
    },

    keys = {
      {
        "<leader>fp",
        "<cmd>lua require('telescope').extensions.projects.projects{}<cr>",
        mode = "n",
        desc = "Telescope Projects",
      },
    },

    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension "projects" -- FIXME: Conflicting or smt with cmp-tabnine
    end,

    opts = {
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = false,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      ignore_lsp = {},

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {},

      -- Show hidden files in telescope
      show_hidden = false,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = true,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "global",

      -- Path where project.nvim will store the project history for use in
      -- telescope
      datapath = vim.fn.stdpath "data",
    },
  },

  { --  🌻 A Vim alignment plugin
    -- Nice
    "junegunn/vim-easy-align",

    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "x", "n" }, desc = "Easy Align" },
    },
  },

  { -- Smooth scrolling
    "karb94/neoscroll.nvim",

    config = function(_, opts)
      require("neoscroll").setup(opts)
    end,

    keys = {
      { "<leader>ms", "", mode = "n", desc = "Enable Smooth Scrolling" },
    },

    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = "sine", -- Default easing function == nil
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
    },

    -- You can create your own scrolling mappings using the following lua functions:
    --
    --     scroll(lines, move_cursor, time[, easing])
    --     zt(half_win_time[, easing])
    --     zz(half_win_time[, easing])
    --     zb(half_win_time[, easing])
  },

  {
    "folke/todo-comments.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "kevinhwang91/nvim-bqf",
    }, -- bqf is optional

    keys = {
      { "<leader>xq", "<cmd>TodoQuickFix<cr>", mode = "n", desc = "QuickFix TODOs" },
      { "<leader>xt", "<cmd>TodoTelescope<cr>", mode = "n", desc = "Telescope TODOs" },
      { "<leader>xl", "<cmd>TodoLocList<cr>", mode = "n", desc = "LocList TODOs" },
      -- 🚦 :TodoTrouble is an option too!
      {
        "<leader>xt",
        function()
          require("todo-comments").jump_next() -- More arguments: {keywords = { "ERROR", "WARNING"}}
        end,
        mode = "n",
        desc = "Next TODO",
      },
      {
        "<leader>xp",
        function()
          require("todo-comments").jump_prev()
        end,
        mode = "n",
        desc = "Prev TODO",
      },
    },

    opts = {

      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },

  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    config = function(_, opts)
      require("sniprun").setup(opts)
    end,
    -- lua require’sniprun’.run()
    -- lua require’sniprun’.run(‘n’)
    -- lua require’sniprun’.run(‘v’)
    -- lua require’sniprun’.info()
    -- lua require’sniprun’.reset()
    -- lua require’sniprun’.clear_repl()
    -- lua require’sniprun.display’.close_all()
    -- lua require’sniprun.live_mode’.toggle()
    -- lua require’sniprun.api’.run_range(..)
    -- lua require’sniprun.api’.run_string(..)

    keys = {
      -- {
      --   "<leader>sr",
      --   function()
      --     require("sniprun").run "n"
      --   end,
      --   mode = "n",
      --   desc = "Sniprun",
      -- },
      {
        "<leader>sr",
        "<cmd> SnipRun<CR>",
        mode = { "n", "v" },
        desc = "Run Snippet",
      },
      {
        "<leader>si",
        function()
          require("sniprun").info()
        end,
        mode = "n",
        desc = "Info",
      },
      {
        "<leader>se",
        function()
          require("sniprun").reset()
        end,
        mode = "n",
        desc = "Reset",
      },
      {
        "<leader>sc",
        function()
          require("sniprun").clear_repl()
        end,
        mode = "n",
        desc = "Open Repl",
      },
      {
        "<leader>sx",
        function()
          require("sniprun.display").close_all()
        end,
        mode = "n",
        desc = "Close All",
      },
      {
        "<leader>sl",
        function()
          require("sniprun.live_mode").toggle()
        end,
        mode = "n",
        desc = "Toggle Live Mode",
      },
    },

    opts = {
      selected_interpreters = {}, --# use those instead of the default for the current filetype
      repl_enable = {}, --# enable REPL-like behavior for the given interpreters
      repl_disable = {}, --# disable REPL-like behavior for the given interpreters

      interpreter_options = { --# interpreter-specific options, see doc / :SnipInfo <name>

        --# use the interpreter name as key
        GFM_original = {
          use_on_filetypes = { "markdown.pandoc" }, --# the 'use_on_filetypes' configuration key is
          --# available for every interpreter
        },
        Python3_original = {
          error_truncate = "auto", --# Truncate runtime errors 'long', 'short' or 'auto'
          --# the hint is available for every interpreter
          --# but may not be always respected
        },
      },

      --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
      --# to filter only sucessful runs (or errored-out runs respectively)
      display = {
        "Classic", --# display results in the command-line  area
        "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)

        -- "VirtualText",             --# display results as virtual text
        -- "TempFloatingWindow",      --# display results in a floating window
        -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
        -- "Terminal",                --# display results in a vertical split
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- "NvimNotify",              --# display with the nvim-notify plugin
        -- "Api"                      --# return output to a programming interface
      },

      live_display = { "VirtualTextOk" }, --# display mode used in live_mode

      display_options = {
        terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
        terminal_line_number = false, --# whether show line number in terminal window
        terminal_signcolumn = false, --# whether show signcolumn in terminal window
        terminal_persistence = true, --# always keep the terminal open (true) or close it at every occasion (false)
        terminal_width = 45, --# change the terminal display option width
        notification_timeout = 5, --# timeout for nvim_notify output
      },

      --# You can use the same keys to customize whether a sniprun producing
      --# no output should display nothing or '(no output)'
      show_no_output = {
        "Classic",
        "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
      },

      --# customize highlight groups (setting this overrides colorscheme)
      snipruncolors = { -- TODO: add hlgroups
        SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
        SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
        SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
        SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
      },

      live_mode_toggle = "off", --# live mode toggle, see Usage - Running for more info

      --# miscellaneous compatibility/adjustement settings
      inline_messages = false, --# boolean toggle for a one-line way to display messages
      --# to workaround sniprun not being able to display anything

      borders = "single", --# display borders around floating windows
      --# possible values are 'none', 'single', 'double', or 'shadow'
    },
  },

  {
    "edKotinsky/Arduino.nvim",

    config = function(_, opts)
      require("arduino").setup { opts }

      require("lspconfig")["arduino_language_server"].setup {
        on_new_config = require("arduino").on_new_config,
      }
    end,

    opts = {
      default_fqbn = "arduino:avr:uno",

      --Path to clangd (all paths must be full)
      clangd = "/usr/bin/clangd",

      --Path to arduino-cli
      arduino = "/usr/bin/arduino",

      --Data directory of arduino-cli
      arduino_config_dir = "~/Arduino/config/",

      --Extra options to arduino-language-server
      extra_opts = {},
    },
  },
}

return plugins

-- TODO: Fix Lazy.nvim breaking the Nvdash (from some plugin that I installed)
