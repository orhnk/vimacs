local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

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
    config = function()
      require("copilot").setup {
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
      }
    end,
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

  { -- -- Use copilot with cmp TODO: Fix
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- "zbirenbaum/copilot-cmp", -- TODO: Fix
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- -- TODO:
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   sources = {
  --     -- Copilot Source
  --     { name = "copilot", group_index = 2 },
  --   },
  -- },

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

  { -- Diagnostics as a scrollbar (JetBrains feature)
    "lewis6991/satellite.nvim",
    lazy = false, -- Load on startup
  },

  { -- Overseer prettifier
    "stevearc/dressing.nvim",

    event = "VeryLazy",

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

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
    lazy = false, -- leap takes care of lazy loading by itself
  },

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
        desc = "Surf declarations",
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
      require("sg").setup()
    end,

    keys = {

      { "<leader>ai", ":CodyChat<CR>", mode = "n", desc = "AI Assistant" },

      { "<leader>ad", ':CodyDo ""<Left>', mode = "n", desc = "Let AI Write Code" },

      { "<leader>aa", ":CodyTaskAccept<CR>", mode = "n", desc = "Confirm AI work" },

      {
        "<leader>as",
        "<cmd> lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
        mode = "n",
        desc = "AI Search",
      },

      { "<leader>ai", "y:CodyChat<CR><ESC>pG$a<CR>", mode = "v", desc = "Chat Selected Code" },

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

  {
    "chaoren/vim-wordmotion",
    lazy = false,
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
}

return plugins

-- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
-- },

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--   "mg979/vim-visual-multi",
--   lazy = false,
-- }
