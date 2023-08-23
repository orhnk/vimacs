local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

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
    -- NOTE: I deprecate this plugin from CamelVim. This is optional because of the bad performance satellite.nvim has.
    -- Opened a issue about this (#51)

    -- "lewis6991/satellite.nvim", -- Bad performance But Beautiful
    -- "dstein64/nvim-scrollview", -- Better performance
    -- lazy = false, -- Load on startup

    -- cmd = { "SatelliteEnable", "SatelliteDisable" },

    -- keys = {
    --   { -- This plugin lacks a toggle function
    --     "<leader>sd",
    --     ":SatelliteDisable<CR>",
    --     mode = "n",
    --     desc = "Toggle Satellite",
    --   },
    -- },
  },

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
      { "<C-a>", "<cmd>ToggleCase<cr>", mode = "v", desc = "Toggle Case" },
      { "<C-a>", "<ESC>viw<cmd>ToggleCase<cr>", mode = { "i", "n" }, desc = "Toggle Case" },
    },
  },

  {
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

  -- { -- Rust Cargo.toml
  --   "saecki/crates.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --
  --   init = function()
  --     local cmp = require "cmp"
  --     vim.api.nvim_create_autocmd("BufRead", {
  --       group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  --       pattern = "Cargo.toml",
  --       callback = function()
  --         cmp.setup.buffer { sources = { { name = "crates" } } }
  --       end,
  --     })
  --   end,
  --
  --   config = function()
  --     local null_ls = require "null-ls"
  --     require("crates").setup {
  --       null_ls = {
  --         enabled = true,
  --         name = "crates.nvim",
  --       },
  --     }
  --   end,
  -- },

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

  { -- Opposite of vim's J (Join like)
    "AckslD/nvim-trevJ.lua",
    config = function()
      require("trevj").setup {
        containers = {
          lua = {
            table_constructor = { final_separator = ",", final_end_line = true },
            arguments = { final_separator = false, final_end_line = true },
            parameters = { final_separator = false, final_end_line = true },
          },
          -- ... -- other filetypes
        },
      }
    end,

    keys = {
      { "<leader>jj", "<cmd>lua require('trevj').format_at_cursor()<cr>", mode = "n", desc = "Format" },
      -- { "<leader>jj", "<cmd>lua require('trevj').format_at_cursor()<cr>", mode = "v", desc = "Format" },
    },
  },

  { -- nvim-dap installer
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
