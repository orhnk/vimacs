-- TODO: Remove telescope as a dependency and lazy load plugins later for squeezed performance.conf
local telescope_actions = require "telescope.actions"
local overrides = require "custom.configs.overrides"

-- Loaded plugins etc.
local status = require("custom.utils").status

---@type NvPluginSpec[]
local plugins = {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        -- "tsx",
        "json",
        -- "vue", "svelte",

        -- low level
        "c",
        "cpp",
        "cmake",
        "rust",
        "zig",

        -- Note
        "org",

        -- Script
        "bash",
        "python",
      },
    },
  },

  { -- WhichKey overrides
    "folke/which-key.nvim",
    config = function(_, opts)
      -- stylua: ignore start
      dofile(vim.g.base46_cache .. "whichkey")       --<-- from NvChad's config
      require("which-key").setup(opts)               --<-- From NvChad's config'
      require("custom.configs.which-key").prefixes() --<-- Vimacs
      -- stylua: ignore end
    end,
    opts = require("custom.configs.which-key").opts,
  },

  -- Override plugin definition options
  { -- Overriding NvChad Telescope options. (Dirty hack)
    "nvim-telescope/telescope.nvim",

    opts = {
      defaults = {
        mappings = {
          i = {
            -- remap TAB to CR
            -- ["<CR>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
            -- ["<S-CR>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
            -- Emacs style TAB nav
            ["<TAB>"] = telescope_actions.select_default,
          },
          n = {
            -- remap TAB to CR
            -- ["<CR>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
            -- ["<S-CR>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
            -- Emacs style TAB nav
            ["<TAB>"] = telescope_actions.select_default,
          },
        },
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
      require("copilot").setup(opts)
      status.copilot = true
    end,

    opts = require("custom.configs.copilot").opts,
  },

  -- C++ development
  -- Nice but limited cpp codegen features which I'll (probably) not use (if you want create keymapps)
  {
    "Badhi/nvim-treesitter-cpp-tools",

    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
      status.translate = true
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features

    dependencies = {
      -- "XXiaoA/ns-textobject.nvim",
      "chrisgrieser/nvim-various-textobjs",
    },

    keys = { "cs", "ds", "ys" },

    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,

    opts = {
      surrounds = {
        ["l"] = {
          add = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "[" },
              { "](" .. clipboard .. ")" },
            }
          end,
          find = "%b[]%b()",
          delete = "^(%[)().-(%]%b())()$",
          change = {
            target = "^()()%b[]%((.-)()%)$",
            replacement = function()
              local clipboard = vim.fn.getreg("+"):gsub("\n", "")
              return {
                { "" },
                { clipboard },
              }
            end,
          },
        },
      },
    },
  },

  -- { -- Emoji Picker
  --   -- MOVED: to nerdy.nvim
  --   "ziontee113/icon-picker.nvim",
  --
  --   keys = {
  --     {
  --       "<leader>fe",
  --       ":PickEverything<CR>",
  --       mode = "n",
  --       desc = "Glyph Picker",
  --     }, -- Gigantic Search Base
  --   },
  --
  --   config = function(_, opts)
  --     require("icon-picker").setup(opts)
  --   end,
  --
  --   opts = {
  --     disable_legacy_commands = false,
  --   },
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = require("custom.configs.cmp").dependencies,
    opts = require("custom.configs.cmp").opts,
  },

  { -- Code runner
    "Zeioth/compiler.nvim",
    keys = {
      {
        "<leader>rr",
        ":CompilerOpen<CR>",
        mode = "n",
        desc = "Run Project",
      },
      {
        "<leader>rt",
        ":CompilerToggleResults<CR>",
        mode = "n",
        desc = "Toggle Results",
      },
    },

    cmd = {
      "CompilerOpen",
      "CompilerToggleResults",
      "CompilerRedo",
    },

    dependencies = {
      "stevearc/overseer.nvim",
    },

    opts = {},
  },

  { -- The task runner for compiler.nvim + daily tasks
    "stevearc/overseer.nvim",
    -- commit = "19aac0426710c8fc0510e54b7a6466a03a1a7377",

    keys = {
      {
        "<leader>ra",
        function()
          vim.cmd [[OverseerRun]]
          vim.cmd [[OverseerOpen]]
        end,
        mode = "n",
        desc = "Run Task",
      },
    },

    cmd = {
      "CompilerOpen",
      "CompilerToggleResults",
      "CompilerRedo",
    },

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
      {
        "<leader>to",
        ":Neotest summary<CR>",
        mode = "n",
        desc = "Open interactive test session",
      },
      {
        "<leader>te",
        ":Neotest run<CR>",
        mode = "n",
        desc = "Run tests for the session",
      },
    },

    dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",

      -- Dev
      "rouge8/neotest-rust", -- Rust development
    },

    config = function(_, opts)
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

  { -- This plugin overrides the default vim selector ui (e.g <leader>ca)
    "stevearc/dressing.nvim",

    event = "VeryLazy", -- FIXME: maybe lazy loadable?

    config = function(_, opts)
      require("dressing").setup(opts)
    end,

    opts = {
      default_prompt = "❯ ",
    },
  },

  -- { -- TODO replace this with automaton
  --   "stevearc/overseer.nvim",
  --
  --   dependencies = { "stevearc/dressing.nvim" },
  --
  --   keys = {
  --     { "<leader>tt", ":OverseerToggle<CR>", mode = "n", desc = "Toggle Task Runner UI" },
  --     { "<leader>tr", ":OverseerRun<CR>", mode = "n", desc = "Run tasks" },
  --   },
  --
  --   config = function()
  --     require("overseer").setup()
  --   end,
  --
  --   opts = {},
  -- },

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
      {
        "<leader>mo",
        "codewindow.toggle_minimap()",
        mode = "n",
        desc = "Toggle Minimap",
      },
      {
        "<leader>mm",
        "codewindow.toggle_focus()",
        mode = "n",
        desc = "Focus Minimap",
      },
    },

    config = function(_, opts)
      local codewindow = require "codewindow"
      codewindow.setup(opts)
      codewindow.apply_default_keybinds()
    end,

    opts = {
      show_cursor = false,
      screen_bounds = "lines",
      window_border = "none",
    },
  },

  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",

    keys = {
      { "<leader>ga", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },

    -- optional, you can also install and use `yq` instead.
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },

    config = function(_, opts)
      require("gh-actions").setup(opts)
    end,

    opts = {},
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
      {
        "<leader><leader>p",
        ":PP<CR>",
        mode = "n",
        desc = "Send Buffer to Pastebin Client",
      },
      {
        "<leader><leader>p",
        ":PP<CR>",
        mode = "v",
        desc = "Send Seleceted Code to Pastebin Client",
      },
    },

    config = function(_, opts)
      require("paperplanes").setup(opts)
    end,

    opts = {
      register = "+",
      provider = "0x0.st",
      provider_options = {},
      notifier = vim.notify or print,
    },
  },

  {
    "NeogitOrg/neogit",

    keys = {
      {
        "<leader>gg",
        "<cmd> Neogit<CR>",
        mode = "n",
        desc = "Open Neogit",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },

    config = function(_, opts)
      require("neogit").setup(opts)
      status.git = true
    end,

    opts = {},
  },

  {
    "debugloop/telescope-undo.nvim",

    keys = {
      { "<leader>tu", ":Telescope undo<CR>", mode = "n", desc = "Open Undo History" },
    },

    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
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
        },
      },
    },

    config = function(_, opts)
      require("telescope").load_extension "undo"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",

    keys = {
      {
        "<leader>fs",
        ":SymbolsOutline<CR>",
        mode = "n",
        desc = "Find Symbols",
      },
    },

    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,

    opts = {},
  },

  { -- TODO: Config && Remove vim one
    "rgroli/other.nvim",

    keys = {
      {
        "<leader>sw",
        "<cmd> Other<CR>",
        mode = "n",
        desc = "Switch To Pair File",
      },
    },

    config = function(_, opts)
      require("other-nvim").setup {
        mappings = {
          {
            pattern = "(.*)/(.*).cpp$",
            target = "%1/%2.hpp",
            -- context = "component",
          },
          -- {
          --   pattern = "/src/app/(.*)/.*.html$",
          --   target = "/src/app/%1/%1.component.ts",
          --   context = "view",
          -- },
          -- {
          --   pattern = "/src/app/(.*)/.*.ts$",
          --   target = "/src/app/%1/%1.component.html",
          --   context = "component",
          -- },
          -- {
          --   pattern = "/src/app/(.*)/.*.spec.ts$",
          --   target = "/src/app/%1/%1.component.html",
          --   context = "test",
          -- },
        },
      }
    end,
  },

  -- { -- C/C++ cpp <-> hpp file pairing TODO: replace with other.nvim || harpoon
  --   "Everduin94/nvim-quick-switcher", -- TODO: use other.nvim
  --
  --   keys = {
  --     {
  --       "<leader>sw",
  --       ":lua require('nvim-quick-switcher').toggle('cpp', 'hpp')<CR>",
  --       mode = "n",
  --       desc = "Switch To Pair File",
  --     },
  --   },
  --
  --   config = function() end,
  -- },

  {
    "ThePrimeagen/refactoring.nvim",

    config = function()
      require("refactoring").setup()
      -- require("telescope").load_extension "refactoring" -- Unnede When dressing.nvim is a thing
    end,

    keys = require("custom.configs.refactoring").keys,
  },

  {
    "sourcegraph/sg.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function(_, opts)
      require("sg").setup(opts)
      status.cody = true
    end,

    opts = require("custom.configs.sg").opts,
    keys = require("custom.configs.sg").keys,

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    build = "nvim -l build/init.lua",
  },

  { -- TODO: Fix
    "iamcco/markdown-preview.nvim",

    ft = {
      "markdown",
    },
    build = ":call mkdp#util#install()",

    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        mode = "n",
        desc = "Markdown Preview",
      },
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
    keys = {
      {
        "<leader>dq",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "v" },
        desc = "Hover",
      },
      {
        "<leader>df",
        function()
          require("dapui").float_element()
        end,
        mode = "n",
        desc = "Lookup Options",
      },
    },

    config = function(_, opts)
      require("dapui").setup(opts)
      status.debug = true
    end,
  },

  { -- nvim-dap virtual text
    "theHamsta/nvim-dap-virtual-text",
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end,
    opts = {},
  },

  { -- DAP REPL Autocompletion
    "rcarriga/cmp-dap",
    config = function(_, opts)
      require("cmp").setup {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      }
      require("cmp").setup.filetype({
        "dap-repl",
        "dapui_watches",
        "dapui_hover",
      }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },

  {
    "LiadOz/nvim-dap-repl-highlights",
    dependencies = "nvim-treesitter/nvim-treesitter",

    keys = {
      {
        "<leader>dp",
        function()
          require("nvim-dap-repl-highlights").setup_highlights()
        end,
        mode = "n",
        desc = "Set REPL Highlight",
      },
    },

    config = function()
      require("nvim-dap-repl-highlights").setup()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "dap_repl",
        },
      }
    end,
  },

  { -- Debug Adapter Protocol
    "mfussenegger/nvim-dap",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/cmp-dap",
      "LiadOz/nvim-dap-repl-highlights",
    },
    -- TODO: Move these to configs/nvim-dap.lua
    config = function()
      require("custom.utils").load_breakpoints()
      local dap = require "dap"
      -- dap.set_log_level "TRACE"

      ----------------------------------------------------
      --                    ADAPTERS                    --
      ----------------------------------------------------
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

      dap.adapters.debugpy = {
        -- Requires:
        --  python -m pip install debugpy # --break-system-packages # <- if the first command doesn't work
        type = "executable",
        command = "python",
        -- function()
        --    local venv = os.getenv "VIRTUAL_ENV"
        --    if venv then
        --      return venv .. "/bin/python"
        --    else
        --      return "python" -- From $PATH
        --    end
        -- end,
        args = {
          "-m",
          "debugpy.adapter",
        },
      }

      -------------------------------------------------------
      --                    DAP CONFIGS                    --
      -------------------------------------------------------

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "debugpy", -- the type here established the link to the adapter definition: `dap.adapters.debugpy`
          request = "launch",
          name = "Launch file",
          cwd = "${workspaceFolder}",

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
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
          args = function()
            -- First split it by spaces
            local raw = vim.fn.input "Args: "
            local home = os.getenv "HOME"
            local args_filtered = raw.gsub(raw, "~", home)
            local args = vim.split(args_filtered, " ")

            print "HERE:"
            vim.print(args)
            for i, arg in ipairs(args) do
              -- Replace ~ with $HOME
              print(arg)
            end
            vim.print(args)

            return args
          end,
        },
      }

      -- Reuse configurations for other languages
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            print "Building Project..."
            vim.cmd "!cargo build"
            print "Done!"

            -- local release_dir = vim.fn.finddir("target/release", vim.fn.getcwd() .. ";")
            local debug_dir = vim.fn.finddir("target/debug", vim.fn.getcwd() .. ";")

            -- If both are nil then run cargo build
            -- WARNING:
            -- if release_dir == "" and debug_dir == "" then
            --   print "Building Project..."
            --   vim.cmd "silent !cargo build"
            --   print "Built With Cargo"
            -- end

            -- Select binary by the (only) file that has no extension
            -- Get the directory path where your files are located
            --[[ release_dir or ]]
            local directory = debug_dir

            -- Get a list of files in the directory
            local files = vim.fn.readdir(directory)

            -- Iterate through the files
            for _, file in ipairs(files) do
              local filepath = directory .. "/" .. file

              -- Check if the file is executable
              local is_executable = vim.fn.executable(filepath) == 1

              if is_executable then
                print("Found Executable on: ", filepath)
                return filepath
                -- You can perform further actions on the executable here
              end
            end

            -- If none of the above don't work
            -- then ask the user to input the path to the executable
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,

          args = function()
            -- First split it by spaces
            local raw = vim.fn.input "Args: "
            local home = os.getenv "HOME"
            local args_filtered = raw.gsub(raw, "~", home)
            local args = vim.split(args_filtered, " ")

            print "HERE:"
            vim.print(args)
            for i, arg in ipairs(args) do
              -- Replace ~ with $HOME
              print(arg)
            end
            vim.print(args)

            return args
          end,
        },
      }

      -------------------------------------------------
      --                    SIGNS                    --
      -------------------------------------------------
      vim.fn.sign_define("DapBreakpoint", {
        text = " ",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointLine",
        numhl = "DapBreakpointNum",
      })

      vim.fn.sign_define("DapLogPoint", {
        text = " ",
        texthl = "DapLogPoint",
        linehl = "DapLogPointLine",
        numhl = "DapLogPointNum",
      })

      vim.fn.sign_define("DapStopped", {
        text = " ",
        texthl = "DapStopped",
        linehl = "DapStoppedLine",
        numhl = "DapStoppedNum",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = " ",
        texthl = "DapBreakpointCondition",
        linehl = "DapBreakpointConditionLine",
        numhl = "DapBreakpointConditionNum",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = " ",
        texthl = "DapBreakpointRejected",
        linehl = "DapBreakpointRejectedLine",
        numhl = "DapBreakpointRejectedNum",
      })
    end,

    keys = require("custom.configs.nvim-dap").keys,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("neogen").setup(opts)
    end,

    opts = {
      snippet_engine = "luasnip",
    },

    keys = {
      {
        "<leader>cd",
        "<cmd>lua require('neogen').generate()<CR>",
        mode = "n",
        desc = "Generate Base Documentation",
      },
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
      -- "nvim-telescope/telescope.nvim",
    },

    config = function(_, opts)
      require("leetbuddy").setup(opts)
      -- require("telescope").load_extension "leetbuddy"
    end,

    keys = {
      -- stylua: ignore start
      { "<leader>clq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>cll", "<cmd>LBQuestion<cr>",  desc = "View Question"  },
      { "<leader>clr", "<cmd>LBReset<cr>",     desc = "Reset Code"     },
      { "<leader>clt", "<cmd>LBTest<cr>",      desc = "Run Code"       },
      { "<leader>cls", "<cmd>LBSubmit<cr>",    desc = "Submit Code"    },
      -- stylua: ignore end
    },

    opts = {
      domain = "com", -- `cn` for chinese leetcode
      language = "rs",
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
              -- mappings = {
              --   ["i"] = {
              --     -- your custom insert mode mappings
              --     -- ["<TAB>"] = require("telescope").extensions.file_browser.actions.open, -- TODO
              --   },
              --   ["n"] = {
              --     -- your custom normal mode mappings
              --   },
              -- },
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

  { -- Telescope projects
    -- Migrated to project.nvim
    "nvim-telescope/telescope-project.nvim",

    -- if you want to enable custom hook
    dependencies = {
      -- {
      -- "ThePrimeagen/harpoon",
      -- }
      {
        "nvim-telescope/telescope.nvim",
        opts = {
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
              order_by = "recent",
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
        },
      },
    },

    keys = {
      {
        "<leader>fp",
        "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
        desc = "Find Project",
      },
    },

    config = function()
      -- local project_actions = require "telescope._extensions.project.actions"
      require("telescope").load_extension "project"
    end,
  },

  { -- Toggle case (CamelCase, snake_case, kebab-case, PascalCase, Title Case, UPPER CASE, lower case)
    "UTFeight/vim-case-change", -- FIXME
    keys = {
      -- NOTE: This is M-Shift-s actually.
      {
        "<M-S>",
        "<cmd>ToggleCase<cr>",
        mode = "v",
        desc = "Toggle Case",
      },
      {
        "<M-S>",
        "<ESC>viw<cmd>ToggleCase<cr>",
        mode = { "i", "n" },
        desc = "Toggle Case",
      },
    },
  },

  { -- Regexplainer
    "tomiis4/Hypersonic.nvim",
    config = function(_, opts)
      require("hypersonic").setup(opts)
    end,

    opts = {},

    keys = {
      { "<leader>re", "<cmd>Hypersonic<cr>", mode = { "n", "v" }, desc = "RegExplain" },
    },
  },

  -- { -- tasks.json, launch.json etc.
  --   -- TODO: Replace with Overseer.nvim
  --   "Dax89/automaton.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "mfussenegger/nvim-dap", -- Debug support for 'launch' configurations (Optional)
  --     "hrsh7th/nvim-cmp", -- Autocompletion for automaton workspace files (Optional)
  --     "L3MON4D3/LuaSnip", -- Snippet support for automaton workspace files (Optional)
  --   },
  --
  --   config = function(_, opts)
  --     require("automaton").setup(opts)
  --   end,
  --
  -- -- WARNING: Rename file from .automaton to automaton in custom/config/g
  --   opts = require("custom.configs.automaton").opts,
  --   keys = require("custom.configs.automaton").keys,
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
        "codelldb", -- Rust, C/C++
        "python",
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
      require("treesj").setup(opts)
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
      require("ts-node-action").setup(opts)
    end,
    opts = require("custom.configs.ts").opts,
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
      require("ccc").setup(opts)
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
        "<leader>mh",
        function()
          require("hlargs").toggle()
        end,
        mode = "n",
        desc = "Toggle Highlight Args",
      },
      -- {
      --   "<leader>zd",
      --   function()
      --     require("hlargs").enable()
      --   end,
      --   mode = "n",
      --   desc = "Enable Highlight Args",
      -- },
      -- {
      --   "<leader>zl",
      --   function()
      --     require("hlargs").disable()
      --   end,
      --   mode = "n",
      --   desc = "Disable Highlight Args",
      -- },
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

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    config = function(_, opts)
      require("perfanno").setup(opts)

      require("perfanno").setup {
        -- Creates a 10-step RGB color gradient beween bgcolor and "#CC3300"
        line_highlights = require("perfanno.util").make_bg_highlights(
          vim.fn.synIDattr(vim.fn.hlID "Normal", "bg", "gui"),
          "#CC3300",
          10
        ),
        vt_highlight = require("perfanno.util").make_fg_highlight "#CC3300",
      }
    end,

    keys = require("custom.configs.perfanno").keys,
    opts = require("custom.configs.perfanno").opts,
  },

  { -- TODO: CHECKMEOUT
    "pwntester/octo.nvim",
    config = function(_, opts)
      require("octo").setup(opts)
      status.github = true
    end,

    dependencies = require("custom.configs.octo").dependencies,
    opts = require("custom.configs.octo").opts,
    keys = require("custom.configs.octo").keys,
    cmd = require("custom.configs.octo").cmd,
  },

  { -- Folding. The fancy way
    "kevinhwang91/nvim-ufo",

    -- event = "VeryLazy",
    keys = require("custom.configs.ufo").keys,
    dependencies = require("custom.configs.ufo").dependencies,
    opts = require("custom.configs.ufo").opts,

    config = function(_, opts)
      require("ufo").setup(opts)

      -- Better UI elements
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = "3" -- "1" is better
    end,
  },

  { -- Lsp lens Show References, Definitions etc. as virtual text
    -- Not working smoothly in every language
    "VidocqH/lsp-lens.nvim",

    keys = {
      {
        "<leader>cj",
        "<cmd> LspLensToggle<CR>",
        mode = "n",
        desc = "Enable Lsp Lens",
      },
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
        "<leader>mb",
        function()
          -- require("nvim-biscuits").toggle_biscuits() -- moved to opts
        end,
        mode = "n",
        desc = "Biscuit Mode", -- TODO: MAYBE rename this
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
        "<leader>fi",
        "<cmd>Cheatsheet<cr>",
        mode = "n",
        desc = "Find Cheat",
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
    event = "BufEnter Cargo.toml",
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

      {
        "yorickpeterse/nvim-pqf",
      },
    },

    keys = require("custom.configs.nvim-bqf").keys,
    opts = require("custom.configs.nvim-bqf").opts,

    config = function(_, opts) -- TODO: add hlgroups
      require("bqf").setup(opts)
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
      -- stylua: ignore start
      { "<leader>nc", ":CECompile<CR>",     mode = "n", desc = "Compile"      },
      { "<leader>nl", ":CECompileLive<CR>", mode = "n", desc = "Compile Live" },
      { "<leader>nf", ":CEFormat<CR>",      mode = "n", desc = "Format"       },
      { "<leader>na", ":CEAddLibrary<CR>",  mode = "n", desc = "Add Library"  },
      { "<leader>ne", ":CELoadExample<CR>", mode = "n", desc = "Load Example" },
      { "<leader>nw", ":CEOpenWebsite<CR>", mode = "n", desc = "Open Website" },
      { "<leader>nd", ":CEDeleteCache<CR>", mode = "n", desc = "Delete Cache" },
      { "<leader>ns", ":CEShowTooltip<CR>", mode = "n", desc = "Show Tooltip" },
      { "<leader>ng", ":CEGotoLabel<CR>",   mode = "n", desc = "Goto Label"   },
      -- stylua: ignore end
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
      -- stylua: ignore start
      { "<leader>mll", "<cmd> Lushify<CR>",         mode = "n", desc = "Lushify Colorscheme" },
      { "<leader>mli", "<cmd> LushImport<CR>",      mode = "n", desc = "Lush Import"         },
      { "<leader>mlt", "<cmd> LushRunTutorial<CR>", mode = "n", desc = "Lush Tutorial"       },
      { "<leader>mlp", '"zp',                       mode = "n", desc = "Lush Paste"          },
      -- stylua: ignore end
    },
  },

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
      {
        "<leader>mz",
        "<cmd> ZenMode<CR>",
        mode = "n",
        desc = "Zen Mode",
      },
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
        "<leader>hs",
        "<cmd> Telescope harpoon marks<cr>", -- TODO: Lazy load them on this specific keystroke
        mode = "n",
        desc = "Telescope Harpoon",
      },
    },
  },

  -- { -- NOTE: Breaks syntax highlighting + slow
  --   "simrat39/rust-tools.nvim",
  --
  --   config = function(_, opts)
  --     require("rust-tools").setup(opts)
  --   end,
  --
  --   event = "BufRead *.rs",
  --
  --   opts = {
  --     tools = { -- rust-tools options
  --
  --       -- how to execute terminal commands
  --       -- options right now: termopen / quickfix / toggleterm / vimux
  --       --
  --       -- FIX: Not working <17-09-23, utfeight>
  --       -- executor = require("rust-tools.executors").termopen,
  --
  --       -- callback to execute once rust-analyzer is done initializing the workspace
  --       -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
  --       on_initialized = nil,
  --
  --       -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
  --       reload_workspace_from_cargo_toml = true,
  --
  --       -- These apply to the default RustSetInlayHints command
  --       inlay_hints = {
  --         -- automatically set inlay hints (type hints)
  --         -- default: true
  --         auto = true,
  --
  --         -- Only show inlay hints for the current line
  --         only_current_line = false,
  --
  --         -- whether to show parameter hints with the inlay hints or not
  --         -- default: true
  --         show_parameter_hints = true,
  --
  --         -- prefix for parameter hints
  --         -- default: "<-"
  --         parameter_hints_prefix = "<- ",
  --
  --         -- prefix for all the other hints (type, chaining)
  --         -- default: "=>"
  --         other_hints_prefix = "=> ",
  --
  --         -- whether to align to the length of the longest line in the file
  --         max_len_align = false,
  --
  --         -- padding from the left if max_len_align is true
  --         max_len_align_padding = 1,
  --
  --         -- whether to align to the extreme right or not
  --         right_align = false,
  --
  --         -- padding from the right if right_align is true
  --         right_align_padding = 7,
  --
  --         -- The color of the hints
  --         highlight = "Comment",
  --       },
  --
  --       -- options same as lsp hover / vim.lsp.util.open_floating_preview()
  --       hover_actions = {
  --
  --         -- the border that is used for the hover window
  --         -- see vim.api.nvim_open_win()
  --         border = {
  --           { "╭", "FloatBorder" },
  --           { "─", "FloatBorder" },
  --           { "╮", "FloatBorder" },
  --           { "│", "FloatBorder" },
  --           { "╯", "FloatBorder" },
  --           { "─", "FloatBorder" },
  --           { "╰", "FloatBorder" },
  --           { "│", "FloatBorder" },
  --         },
  --
  --         -- Maximal width of the hover window. Nil means no max.
  --         max_width = nil,
  --
  --         -- Maximal height of the hover window. Nil means no max.
  --         max_height = nil,
  --
  --         -- whether the hover action window gets automatically focused
  --         -- default: false
  --         auto_focus = false,
  --       },
  --
  --       -- settings for showing the crate graph based on graphviz and the dot
  --       -- command
  --       crate_graph = {
  --         -- Backend used for displaying the graph
  --         -- see: https://graphviz.org/docs/outputs/
  --         -- default: x11
  --         backend = "x11",
  --         -- where to store the output, nil for no output stored (relative
  --         -- path from pwd)
  --         -- default: nil
  --         output = nil,
  --         -- true for all crates.io and external crates, false only the local
  --         -- crates
  --         -- default: true
  --         full = true,
  --
  --         -- List of backends found on: https://graphviz.org/docs/outputs/
  --         -- Is used for input validation and autocompletion
  --         -- Last updated: 2021-08-26
  --         enabled_graphviz_backends = {
  --           "bmp",
  --           "cgimage",
  --           "canon",
  --           "dot",
  --           "gv",
  --           "xdot",
  --           "xdot1.2",
  --           "xdot1.4",
  --           "eps",
  --           "exr",
  --           "fig",
  --           "gd",
  --           "gd2",
  --           "gif",
  --           "gtk",
  --           "ico",
  --           "cmap",
  --           "ismap",
  --           "imap",
  --           "cmapx",
  --           "imap_np",
  --           "cmapx_np",
  --           "jpg",
  --           "jpeg",
  --           "jpe",
  --           "jp2",
  --           "json",
  --           "json0",
  --           "dot_json",
  --           "xdot_json",
  --           "pdf",
  --           "pic",
  --           "pct",
  --           "pict",
  --           "plain",
  --           "plain-ext",
  --           "png",
  --           "pov",
  --           "ps",
  --           "ps2",
  --           "psd",
  --           "sgi",
  --           "svg",
  --           "svgz",
  --           "tga",
  --           "tiff",
  --           "tif",
  --           "tk",
  --           "vml",
  --           "vmlz",
  --           "wbmp",
  --           "webp",
  --           "xlib",
  --           "x11",
  --         },
  --       },
  --     },
  --
  --     -- all the opts to send to nvim-lspconfig
  --     -- these override the defaults set by rust-tools.nvim
  --     -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  --     server = {
  --       -- standalone file support
  --       -- setting it to false may improve startup time
  --       standalone = true,
  --     }, -- rust-analyzer options
  --
  --     -- debugging stuff
  --     dap = {
  --       adapter = {
  --         type = "executable",
  --         command = "lldb-vscode",
  --         name = "rt_lldb",
  --       },
  --     },
  --   },
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

  -- TODO: Enable multicursors

  -- { --  The superior project management solution for neovim.
  --   "ahmedkhalf/project.nvim",
  --   dependencies = {
  --     {
  --       "nvim-tree/nvim-tree.lua",
  --       opts = {
  --         sync_root_with_cwd = true,
  --         respect_buf_cwd = true,
  --         update_focused_file = {
  --           enable = true,
  --           update_root = true,
  --         },
  --       },
  --     },
  --   },
  --
  --   keys = {
  --     {
  --       "<leader>fp",
  --       "<cmd>lua require('telescope').extensions.projects.projects{}<cr>",
  --       mode = "n",
  --       desc = "Telescope Projects",
  --     },
  --   },
  --
  --   config = function(_, opts)
  --     require("project_nvim").setup(opts)
  --     require("telescope").load_extension "projects" -- FIXME: Conflicting or smt with cmp-tabnine
  --   end,
  --
  --   opts = {
  --     -- Manual mode doesn't automatically change your root directory, so you have
  --     -- the option to manually do so using `:ProjectRoot` command.
  --     manual_mode = false,
  --
  --     -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  --     -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  --     -- order matters: if one is not detected, the other is used as fallback. You
  --     -- can also delete or rearangne the detection methods.
  --     detection_methods = { "lsp", "pattern" },
  --
  --     -- All the patterns used to detect root dir, when **"pattern"** is in
  --     -- detection_methods
  --     patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "^Github" },
  --
  --     -- Table of lsp clients to ignore by name
  --     -- eg: { "efm", ... }
  --     ignore_lsp = {},
  --
  --     -- Don't calculate root dir on specific directories
  --     -- Ex: { "~/.cargo/*", ... }
  --     exclude_dirs = {},
  --
  --     -- Show hidden files in telescope
  --     show_hidden = false,
  --
  --     -- When set to false, you will get a message when project.nvim changes your
  --     -- directory.
  --     silent_chdir = true,
  --
  --     -- What scope to change the directory, valid options are
  --     -- * global (default)
  --     -- * tab
  --     -- * win
  --     scope_chdir = "global",
  --
  --     -- Path where project.nvim will store the project history for use in
  --     -- telescope
  --     datapath = vim.fn.stdpath "data",
  --   },
  -- },

  { --  🌻 A Vim alignment plugin
    -- Nice
    "junegunn/vim-easy-align",

    keys = {
      {
        "ga",
        "<Plug>(EasyAlign)",
        mode = { "x", "n" },
        desc = "Easy Align",
      },
    },
  },

  -- {
  --   "declancm/cinnamon.nvim",
  --   config = function(_, opts)
  --     require("cinnamon").setup(opts)
  --   end,
  --
  -- --   keys = {
  -- --     {
  -- --       "<leader>ms",
  -- --       "",
  -- --       mode = "n",
  -- --       desc = "Enable Smooth Scrolling",
  -- --     },
  -- --   },
  --
  --   opts = {
  --     extra_keymaps = true,
  --     extended_keymaps = true,
  --     -- override_keymaps = true,
  --     -- max_length = 500,
  --     scroll_limit = -1,
  --   },
  -- },

  { -- Smooth scrolling
    "karb94/neoscroll.nvim",

    config = function(_, opts)
      require("neoscroll").setup(opts)
    end,

    keys = {
      {
        "<leader>ms",
        "",
        mode = "n",
        desc = "Enable Smooth Scrolling",
      },
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
      {
        "<leader>ltq",
        "<cmd>TodoQuickFix<cr>",
        mode = "n",
        desc = "QuickFix TODOs",
      },
      {
        "<leader>ltt",
        "<cmd>TodoTelescope<cr>",
        mode = "n",
        desc = "Telescope TODOs",
      },
      {
        "<leader>ltl",
        "<cmd>TodoLocList<cr>",
        mode = "n",
        desc = "LocList TODOs",
      },
      -- 🚦 :TodoTrouble is an option too!
      {
        "<leader>ltn",
        function()
          require("todo-comments").jump_next() -- More arguments: {keywords = { "ERROR", "WARNING"}}
        end,
        mode = "n",
        desc = "Next TODO",
      },
      {
        "<leader>ltp",
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
      colors = { -- TODO. Add hlgroups
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
    keys = require("custom.configs.sniprun").keys,
    opts = require("custom.configs.sniprun").opts,
  },

  ------- GAMES -------
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",

    config = function(_, opts)
      require("sudoku").setup(opts)
      status.games = true
    end,

    opts = require("custom.configs.sudoku").opts,
    keys = require("custom.configs.sudoku").keys,
  },

  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",

    config = function(_, opts)
      status.games = true
    end,
    keys = {
      { "<leader>vg", "<cmd> VimBeGood<CR>", mode = "n", desc = "Play VimBeGood" },
    },
  },

  {
    "alec-gibson/nvim-tetris",

    cmd = "Tetris",

    config = function(_, opts)
      status.games = true
    end,

    keys = {
      { "<leader>vt", "<cmd> Tetris<CR>", mode = "n", desc = "Play Tetris" },
    },
  },

  { -- One of the nices things ever!
    "seandewar/killersheep.nvim",

    config = function(_, opts)
      require("killersheep").setup(opts)
      status.games = true
    end,

    opts = {
      gore = true, -- Enables/disables blood and gore.
      keymaps = {
        move_left = "h", -- Keymap to move cannon to the left.
        move_right = "l", -- Keymap to move cannon to the right.
        shoot = "<Space>", -- Keymap to shoot the cannon.
      },
    },

    cmd = "KillKillKill",

    keys = {
      { "<leader>vk", "<cmd> KillKillKill<CR>", mode = "n", desc = "Play Killer Sheep" },
    },
  },

  { -- Nice actions using your buffers text
    "Eandrju/cellular-automaton.nvim",

    cmd = "CellularAutomaton",

    keys = {
      { "<leader>vr", "<cmd> CellularAutomaton make_it_rain<CR>", mode = "n", desc = "Rain" },
      { "<leader>vl", "<cmd> CellularAutomaton game_of_life<CR>", mode = "n", desc = "Game of Life" },
      { "<leader>vx", "<cmd> CellularAutomaton scramble<CR>", mode = "n", desc = "Scrable" },
    },
  },

  {
    "seandewar/nvimesweeper",

    cmd = "Nvimesweeper",

    config = function(_, opts)
      status.games = true
    end,

    keys = {
      { "<leader>vw", "<cmd> Nvimesweeper<CR>", mode = "n", desc = "Play MineSweeper" },
    },
  },

  {
    "madskjeldgaard/cppman.nvim",

    dependencies = {
      {
        "MunifTanjim/nui.nvim",
      },
    },

    cmd = {
      "CPPMan",
    },

    keys = {
      {
        "<leader>fd",
        function()
          require("cppman").open_cppman_for(vim.fn.expand "<cword>")
        end,
        mode = "n",
        desc = "Open Cpp Manual",
      },

      {
        "<leader>fx",
        function()
          require("cppman").input()
        end,
        mode = "n",
        desc = "Search Cpp Manual",
      },
    },

    config = function()
      require("cppman").setup()
    end,
  },

  {
    "sindrets/winshift.nvim",

    keys = {
      {
        "<leader>mw",
        "<cmd> WinShift<CR>",
        mode = "n",
        desc = "Window Shift Mode",
      },
    },

    config = function(_, opts)
      require("winshift").setup(opts)
    end,

    opts = {
      highlight_moving_win = true, -- Highlight the window being moved
      focused_hl_group = "Visual", -- The highlight group used for the moving window

      moving_win_options = {
        -- These are local options applied to the moving window while it's
        -- being moved. They are unset when you leave Win-Move mode.
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
      },

      keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        win_move_mode = {
          ["h"] = "left",
          ["j"] = "down",
          ["k"] = "up",
          ["l"] = "right",
          ["H"] = "far_left",
          ["J"] = "far_down",
          ["K"] = "far_up",
          ["L"] = "far_right",
          ["<left>"] = "left",
          ["<down>"] = "down",
          ["<up>"] = "up",
          ["<right>"] = "right",
          ["<S-left>"] = "far_left",
          ["<S-down>"] = "far_down",
          ["<S-up>"] = "far_up",
          ["<S-right>"] = "far_right",
        },
      },
      ---A function that should prompt the user to select a window.
      ---
      ---The window picker is used to select a window while swapping windows with
      ---`:WinShift swap`.
      ---@return integer? winid # Either the selected window ID, or `nil` to
      ---   indicate that the user cancelled / gave an invalid selection.
      window_picker = function()
        return require("winshift.lib").pick_window {
          -- A string of chars used as identifiers by the window picker.
          picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          filter_rules = {
            -- This table allows you to indicate to the window picker that a window
            -- should be ignored if its buffer matches any of the following criteria.
            cur_win = true, -- Filter out the current window
            floats = true, -- Filter out floating windows
            filetype = {}, -- List of ignored file types
            buftype = {}, -- List of ignored buftypes
            bufname = {}, -- List of vim regex patterns matching ignored buffer names
          },
          ---A function used to filter the list of selectable windows.
          ---@param winids integer[] # The list of selectable window IDs.
          ---@return integer[] filtered # The filtered list of window IDs.
          filter_func = nil,
        }
      end,
    },
  },

  {
    "pocco81/true-zen.nvim",

    -- stylua: ignore start
    keys = {
      { "<leader>mn", "<cmd> TZNarrow<CR>",      mode  = "n", desc = "Narrow Mode"     },
      { "<leader>mn", "<cmd> '<,'>TZNarrow<CR>", mode  = "v", desc = "Narrow Mode"     },
      { "<leader>mf", "<cmd> TZFocus<CR>",       mode  = "n", desc = "Focus Mode"      },
      { "<leader>mi", "<cmd> TZMinimalist<CR>",  mode  = "n", desc = "Minimalist Mode" },
      { "<leader>mx", "<cmd> TZAtaraxis<CR>",    mode  = "n", desc = "Atarix Mode"     },
    },
    -- stylua: ignore end

    -- config = function(_, opts)
    --   require("true-zen").setup(opts)
    -- end,

    -- opts = {
    --   modes = { -- configurations per mode
    --     ataraxis = {
    --       shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
    --       backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
    --       minimum_writing_area = { -- minimum size of main window
    --         width = 70,
    --         height = 44,
    --       },
    --       quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
    --       padding = { -- padding windows
    --         left = 52,
    --         right = 52,
    --         top = 0,
    --         bottom = 0,
    --       },
    --       callbacks = { -- run functions when opening/closing Ataraxis mode
    --         open_pre = nil,
    --         open_pos = nil,
    --         close_pre = nil,
    --         close_pos = nil,
    --       },
    --     },
    --     minimalist = {
    --       ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
    --       options = { -- options to be disabled when entering Minimalist mode
    --         number = false,
    --         relativenumber = false,
    --         showtabline = 0,
    --         signcolumn = "no",
    --         statusline = "",
    --         cmdheight = 1,
    --         laststatus = 0,
    --         showcmd = false,
    --         showmode = false,
    --         ruler = false,
    --         numberwidth = 1,
    --       },
    --       callbacks = { -- run functions when opening/closing Minimalist mode
    --         open_pre = nil,
    --         open_pos = nil,
    --         close_pre = nil,
    --         close_pos = nil,
    --       },
    --     },
    --     narrow = {
    --       --- change the style of the fold lines. Set it to:
    --       --- `informative`: to get nice pre-baked folds
    --       --- `invisible`: hide them
    --       --- function() end: pass a custom func with your fold lines. See :h foldtext
    --       folds_style = "informative",
    --       run_ataraxis = true, -- display narrowed text in a Ataraxis session
    --       callbacks = { -- run functions when opening/closing Narrow mode
    --         open_pre = nil,
    --         open_pos = nil,
    --         close_pre = nil,
    --         close_pos = nil,
    --       },
    --     },
    --     focus = {
    --       callbacks = { -- run functions when opening/closing Focus mode
    --         open_pre = nil,
    --         open_pos = nil,
    --         close_pre = nil,
    --         close_pos = nil,
    --       },
    --     },
    --   },
    --   integrations = {
    --     tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
    --     kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
    --       enabled = false,
    --       font = "+3",
    --     },
    --     twilight = false, -- enable twilight (ataraxis)
    --     lualine = false, -- hide nvim-lualine (ataraxis)
    --   },
    -- },
  },

  -- {
  --   "nvim-neorg/neorg",
  --
  --   build = ":Neorg sync-parsers",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --
  --   cmd = "Neorg",
  --   event = "BufEnter *.norg",
  --
  --   keys = {
  --     {
  --       "<leader>zc",
  --       "<cmd> Neorg keybind all core.looking-glass.magnify-code-block<CR>",
  --       mode = "n",
  --       desc = "Neorg Code Buffer",
  --     },
  --     {
  --       "<leader>zm",
  --       "<cmd> Neorg toggle-concealer<CR>",
  --       mode = "n",
  --       desc = "Toggle Markdown",
  --     },
  --     {
  --       "<leader>zn",
  --       "<cmd> Neorg keybind all core.integrationg.treesitter.next.heading<CR>",
  --       mode = "n",
  --       desc = "Next Heading",
  --     },
  --     {
  --       "<leader>zp",
  --       "<cmd> Neorg keybind all core.integrationg.treesitter.previous.heading<CR>",
  --       mode = "n",
  --       desc = "Previous Heading",
  --     },
  --     {
  --       "<leader>zl",
  --       "<cmd> Neorg keybind all core.integrationg.treesitter.next.link<CR>",
  --       mode = "n",
  --       desc = "Next Link",
  --     },
  --     {
  --       "<leader>zn",
  --       "<cmd> Neorg keybind all core.integrationg.treesitter.previous.link<CR>",
  --       mode = "n",
  --       desc = "Previous Link",
  --     },
  --
  --     -- {
  --     --   "<leader>z",
  --     --   "<cmd> Neorg <CR>",
  --     --   mode = "n",
  --     --   desc = "Neorg ",
  --     -- },
  --   },
  --
  --   config = function(_, opts)
  --     require("neorg").setup(opts)
  --   end,
  --
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {}, -- Loads default behaviour
  --       ["core.integrations.nvim-cmp"] = {},
  --
  --       -- ["core.integrations.treesitter "] = {}, -- FIXME
  --
  --       ["core.completion"] = {
  --         config = {
  --           engine = "nvim-cmp",
  --         },
  --       },
  --       ["core.ui.calendar"] = {},
  --       ["core.presenter"] = {
  --         config = {
  --           zen_mode = "zen-mode",
  --         },
  --       },
  --       ["core.summary"] = {},
  --       ["core.export.markdown"] = {},
  --       ["core.export"] = {},
  --       ["core.qol.toc"] = {
  --         config = {
  --           close_after_use = true,
  --         },
  --       },
  --       -- [""] = {},
  --       -- [""] = {},
  --       -- [""] = {},
  --       -- [""] = {},
  --       ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --       ["core.dirman"] = { -- Manages Neorg workspaces
  --         config = {
  --           workspaces = {
  --             -- NOTE: for multiple workspaces check out the README
  --             notes = "~/Notes",
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },

  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    keys = {
      {
        "<leader>mg",
        "<cmd> Goyo<CR>",
        mode = "n",
        desc = "Goyo Mode",
      },
    },
  },

  {
    "axieax/urlview.nvim",
    cmd = "UrlView",

    config = function(_, opts)
      require("urlview").setup(opts)
    end,

    opts = {
      -- custom configuration options --
    },

    keys = {
      { "<leader>fuu", "<Cmd>UrlView<CR>", mode = "n", desc = "View buffer URLs" },
      { "<leader>ful", "<Cmd>UrlView lazy<CR>", mode = "n", desc = "View Lazy URLs" },
      { "<leader>fup", "<Cmd>UrlView packer<CR>", mode = "n", desc = "View Packer plugin URLs" },
      { "<leader>fuv", "<Cmd>UrlView vimplug<CR>", mode = "n", desc = "View Packer plugin URLs" },
    },
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  --
  --   opts = {
  --     textobjects = {
  --       select = {
  --         enable = true,
  --
  --         -- Automatically jump forward to textobj, similar to targets.vim
  --         lookahead = true,
  --
  --         keymaps = {
  --           -- You can use the capture groups defined in textobjects.scm
  --           ["af"] = "@function.outer",
  --           ["if"] = "@function.inner",
  --           ["ac"] = "@class.outer",
  --           -- You can optionally set descriptions to the mappings (used in the desc parameter of
  --           -- nvim_buf_set_keymap) which plugins like which-key display
  --           ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
  --           -- You can also use captures from other query groups like `locals.scm`
  --           ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
  --         },
  --         -- You can choose the select mode (default is charwise 'v')
  --         --
  --         -- Can also be a function which gets passed a table with the keys
  --         -- * query_string: eg '@function.inner'
  --         -- * method: eg 'v' or 'o'
  --         -- and should return the mode ('v', 'V', or '<c-v>') or a table
  --         -- mapping query_strings to modes.
  --         selection_modes = {
  --           ["@parameter.outer"] = "v", -- charwise
  --           ["@function.outer"] = "V", -- linewise
  --           ["@class.outer"] = "<c-v>", -- blockwise
  --         },
  --         -- If you set this to `true` (default is `false`) then any textobject is
  --         -- extended to include preceding or succeeding whitespace. Succeeding
  --         -- whitespace has priority in order to act similarly to eg the built-in
  --         -- `ap`.
  --         --
  --         -- Can also be a function which gets passed a table with the keys
  --         -- * query_string: eg '@function.inner'
  --         -- * selection_mode: eg 'v'
  --         -- and should return true of false
  --         include_surrounding_whitespace = true,
  --       },
  --
  --       swap = {
  --         enable = true,
  --         swap_next = {
  --           ["<leader>sl"] = "@parameter.inner",
  --         },
  --         swap_previous = {
  --           ["<leader>sh"] = "@parameter.inner",
  --         },
  --       },
  --       lsp_interop = {
  --         enable = true,
  --         border = "none",
  --         floating_preview_opts = {},
  --         peek_definition_code = {
  --           ["<leader>df"] = "@function.outer",
  --           ["<leader>dF"] = "@class.outer",
  --         },
  --       },
  --     },
  --   },
  --
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  -- },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>fg", "<cmd> UndotreeToggle<CR>", mode = "n", desc = "View Undo Tree" },
    },
  },

  {
    "XXiaoA/ns-textobject.nvim",

    config = function(_, opts)
      require("ns-textobject").setup(opts)
    end,

    opts = {
      -- auto_mapping = {
      --   -- automatically mapping for nvim-surround's aliases
      --   aliases = true,
      --   -- for nvim-surround's surrounds
      --   surrounds = true,
      -- },
      -- disable_builtin_mapping = {
      --   enabled = true,
      --   -- list of char which shouldn't mapping by auto_mapping
      --   chars = { "b", "B", "t", "`", "'", '"', "{", "}", "(", ")", "[", "]", "<", ">" },
      -- },
    },
  },

  {
    "lalitmee/browse.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function(_, opts)
      require("browse").setup(opts)
    end,

    keys = {
      {
        "<leader>op",
        function()
          require("browse").browse()
        end,
        mode = "n",
        desc = "Browse Anything",
      },
    },
    opts = {
      -- search provider you want to use
      provider = "google", -- duckduckgo, bing

      -- either pass it here or just pass the table to the functions
      -- see below for more
      bookmarks = {
        ["github"] = {
          ["name"] = "search github from neovim",
          ["code_search"] = "https://github.com/search?q=%s&type=code",
          ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
          ["issues_search"] = "https://github.com/search?q=%s&type=issues",
          ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
        },
      },
    },
  },

  -- { -- WARNING: Doesn't work
  --   {
  --     "antosha417/nvim-lsp-file-operations",
  --     dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "nvim-tree/nvim-tree.lua",
  --     },
  --   },
  -- },

  {
    "aPeoplesCalendar/apc.nvim",
    -- Required for APeoplesCalendarTeaser
    -- dependencies = {
    --   "rcarriga/nvim-notify",
    -- },
    -- event = "VeryLazy",
    config = function(_, opts)
      require("apeoplescalendar").setup(opts) -- configuration options are described below
    end,

    keys = {
      { "<leader>vc", "<cmd> APeoplesCalendar<CR>", mode = "n", desc = "Daily Calendar" },
    },

    opts = {
      -- auto_teaser_filetypes = { "dashboard", "alpha", "starter" }, -- will enable running the teaser automatically for listed filetypes
    },
  },

  {
    "monaqa/dial.nvim",

    keys = {
      {
        "<leader><C-a>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        mode = "v",
        desc = "Custom Toggle",
      },
      {
        "<leader><C-a>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
        mode = "n",
        desc = "Custom Toggle",
      },
    },

    config = function(_, opts)
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.integer.alias.decimal,
          augend.constant.alias.bool, -- boolean value (true <-> false)

          augend.constant.new {
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          },

          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
        },

        -- -- augends used when group with name `<below>` is specified
        -- custom = {
        --   augend.integer.alias.decimal,
        --   augend.constant.alias.bool, -- boolean value (true <-> false)
        --   augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
        -- },
      }
    end,
  },

  -- { -- WARNING: Doesn't work
  --   "richardbizik/nvim-toc",
  --
  --   config = function(_, opts)
  --     require("nvim-toc").setup(opts)
  --   end,
  --
  --   opts = {},
  --
  --   keys = {
  --     { "<leader>cmg", "<cmd> TOC<CR>", mode = "n", desc = "Generaate TOC" },
  --   },
  -- },

  {
    "gsuuon/llm.nvim",

    cmd = "Llm", -- Others cmds are ignored for now

    keys = {
      { "<leader>al", "<cmd> Llm<CR>", mode = { "n", "v" }, desc = "LLM Generate" },
    },

    config = function(_, opts)
      -- FIXME:
      -- require("llm.providers.huggingface").initialize {
      --   max_tokens = 2000,
      -- }

      require("llm").setup {
        default_prompt = {
          provider = require "llm.providers.huggingface",
          params = {
            model = "bigcode/starcoder",
            max_tokens = 2000,
          },
          builder = function(input)
            return {
              inputs = input,
            }
          end,
        }, -- Prompt — modify the default prompt (`:Llm` with no argument)

        hl_group = "", -- string — Set the default highlight group of in-progress responses
        prompts = {
          -- ["huggingface bigcode"] = {},
        }, -- table<string, Prompt>` — add prompt alternatives
      }

      -- require("llm").setup(opts.init)
    end,

    -- opts = {
    --   default = {
    --   },
    -- },
  },

  {
    "AckslD/nvim-FeMaco.lua",

    keys = {
      {
        "<leader>cme",
        "<cmd> FeMaco<CR>",
        mode = "n",
        desc = "Edit Code Block",
      },
    },

    config = function(_, opts)
      require("femaco").setup(opts)
    end,

    opts = {
      -- -- should prepare a new buffer and return the winid
      -- -- by default opens a floating window
      -- -- provide a different callback to change this behaviour
      -- -- @param opts: the return value from float_opts
      -- prepare_buffer = function(opts)
      --   local buf = vim.api.nvim_create_buf(false, false)
      --   return vim.api.nvim_open_win(buf, true, opts)
      -- end,
      -- -- should return options passed to nvim_open_win
      -- -- @param code_block: data about the code-block with the keys
      -- --   * range
      -- --   * lines
      -- --   * lang
      -- float_opts = function(code_block)
      --   return {
      --     relative = "cursor",
      --     width = clip_val(5, 120, vim.api.nvim_win_get_width(0) - 10), -- TODO how to offset sign column etc?
      --     height = clip_val(5, #code_block.lines, vim.api.nvim_win_get_height(0) - 6),
      --     anchor = "NW",
      --     row = 0,
      --     col = 0,
      --     style = "minimal",
      --     border = "rounded",
      --     zindex = 1,
      --   }
      -- end,
      -- -- return filetype to use for a given lang
      -- -- lang can be nil
      -- ft_from_lang = function(lang)
      --   return lang
      -- end,
      -- -- what to do after opening the float
      -- post_open_float = function(winnr)
      --   vim.wo.signcolumn = "no"
      -- end,
      -- -- create the path to a temporary file
      -- create_tmp_filepath = function(filetype)
      --   return os.tmpname()
      -- end,
      -- -- if a newline should always be used, useful for multiline injections
      -- -- which separators needs to be on separate lines such as markdown, neorg etc
      -- -- @param base_filetype: The filetype which FeMaco is called from, not the
      -- -- filetype of the injected language (this is the current buffer so you can
      -- -- get it from vim.bo.filetyp).
      -- ensure_newline = function(base_filetype)
      --   return false
      -- end,
    },
  },

  {
    "nfrid/markdown-togglecheck",

    keys = {
      {
        "<leader>cml",
        function()
          require("markdown-togglecheck").toggle()
        end,
        mode = "n",
        desc = "Toggle Markdown Checkbox",
      },
    },

    dependencies = {
      "nfrid/treesitter-utils",
    },

    ft = {
      "markdown",
    },
  },

  {
    "potamides/pantran.nvim",

    keys = {
      { "<leader><leader>t", "<cmd> Pantran<CR>", mode = { "n", "v" }, desc = "Translate" },
      -- { "<leader>t", "<cmd> Pantran<CR>", mode = "v", desc = "Translate" },
    },

    config = function(_, opts)
      local default_source = "auto"
      local default_target = "tr" -- MUST: Refactor as your default target language.

      require("pantran").setup {
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "argos",
        -- Configuration for individual engines goes here.
        engines = {
          argos = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = default_source,
            default_target = default_target, -- MUST: Refactor as your default target language.
          },
          apertium = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = default_source,
            default_target = default_target, -- MUST: Refactor as your default target language.
          },
          yandex = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = default_source,
            default_target = default_target, -- MUST: Refactor as your default target language.
          },
          google = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function() vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = default_source,
            default_target = default_target, -- MUST: Refactor as your default target language.
          },
        },
        -- controls = {
        --   mappings = {
        --     edit = {
        --       n = {
        --         -- Use this table to add additional mappings for the normal mode in
        --         -- the translation window. Either strings or function references are
        --         -- supported.
        --         ["j"] = "gj",
        --         ["k"] = "gk",
        --       },
        --       i = {
        --         -- Similar table but for insert mode. Using 'false' disables
        --         -- existing keybindings.
        --         ["<C-y>"] = false,
        --         ["<C-a>"] = require("pantran.ui.actions").yank_close_translation,
        --       },
        --     },
        --     -- Keybindings here are used in the selection window.
        --     select = {
        --       n = {
        --         -- ...
        --       },
        --     },
        --   },
        -- },
      }
    end,
  },

  { -- markdown-mode
    "jakewvincent/mkdnflow.nvim",

    keys = {
      {
        "<leader>cmm",
        "<cmd> Mkdnflow<CR>",
        mode = "n",
        desc = "Markdown Mode",
      },
    },

    ft = {
      "markdown",
    },

    config = function(_, opts)
      require("mkdnflow").setup(opts)
    end,

    opts = {

      modules = {
        bib = true,
        buffers = true,
        conceal = true,
        cursor = true,
        folds = true,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        yaml = false,
      },
      filetypes = { md = true, rmd = true, markdown = true },
      create_dirs = true,
      perspective = {
        priority = "first",
        fallback = "current",
        root_tell = false,
        nvim_wd_heel = false,
        update = false,
      },
      wrap = false,
      bib = {
        default_path = nil,
        find_in_root = true,
      },
      silent = false,
      links = {
        style = "markdown",
        name_is_source = false,
        conceal = false,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          text = os.date "%Y-%m-%d_" .. text
          return text
        end,
      },
      new_file_template = {
        use_template = false,
        placeholders = {
          before = {
            title = "link_title",
            date = "os_date",
          },
          after = {},
        },
        template = "# {{ title }}",
      },
      to_do = {
        symbols = { " ", "-", "X" },
        update_parents = true,
        not_started = " ",
        in_progress = "-",
        complete = "X",
      },
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false,
      },
      yaml = {
        bib = { override = false },
      },
      mappings = {
        MkdnEnter = { { "n", "v" }, "<CR>" },
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = { "n", "<Tab>" },
        MkdnPrevLink = { "n", "<S-Tab>" },
        MkdnNextHeading = { "n", "]]" },
        MkdnPrevHeading = { "n", "[[" },
        MkdnGoBack = { "n", "<BS>" },
        MkdnGoForward = { "n", "<Del>" },
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = { "n", "<M-CR>" },
        MkdnTagSpan = { "v", "<M-CR>" },
        MkdnMoveSource = { "n", "<F2>" },
        MkdnYankAnchorLink = { "n", "yaa" },
        MkdnYankFileAnchorLink = { "n", "yfa" },
        MkdnIncreaseHeading = { "n", "+" },
        MkdnDecreaseHeading = { "n", "-" },
        MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
        MkdnNewListItem = { "i", "<CR>" },
        MkdnNewListItemBelowInsert = { "n", "o" },
        MkdnNewListItemAboveInsert = { "n", "O" },
        MkdnExtendList = false,
        MkdnUpdateNumbering = { "n", "<leader>nn" },
        MkdnTableNextCell = { "i", "<Tab>" },
        MkdnTablePrevCell = { "i", "<S-Tab>" },
        MkdnTableNextRow = false,
        MkdnTablePrevRow = { "i", "<M-CR>" },
        MkdnTableNewRowBelow = { "n", "<leader>ir" },
        MkdnTableNewRowAbove = { "n", "<leader>iR" },
        MkdnTableNewColAfter = { "n", "<leader>ic" },
        MkdnTableNewColBefore = { "n", "<leader>iC" },
        MkdnFoldSection = { "n", "<leader>f" },
        MkdnUnfoldSection = { "n", "<leader>F" },
      },
    },
  },

  {
    -- NOTE: cmp sources are listed in configs/cmp.lua
    "nvim-orgmode/orgmode",

    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        lazy = true, -- I doubt this is necessary
        opts = {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = {
              "org",
            },
          },
          -- NOTE: ensure_installed is in nvim-treesitter's config
        },
      },
      {
        "akinsho/org-bullets.nvim",
        config = function(_, opts)
          require("org-bullets").setup(opts)
        end,

        -- opts = {
        --   concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
        --   symbols = {
        --     -- list symbol
        --     list = "•",
        --     -- headlines can be a list
        --     headlines = { "◉", "○", "✸", "✿" },
        --     -- or a function that receives the defaults and returns a list
        --     headlines = function(default_list)
        --       table.insert(default_list, "♥")
        --       return default_list
        --     end,
        --     checkboxes = {
        --       half = { "", "OrgTSCheckboxHalfChecked" },
        --       done = { "✓", "OrgDone" },
        --       todo = { "˟", "OrgTODO" },
        --     },
        --   },
        -- },
      },

      {
        "lukas-reineke/headlines.nvim",

        dependencies = "nvim-treesitter",

        config = function()
          require("headlines").setup {
            markdown = {
              query = vim.treesitter.query.parse(
                "markdown",
                [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
              ),
              headline_highlights = { "Headline" },
              codeblock_highlight = "CodeBlock",
              dash_highlight = "Dash",
              dash_string = "-",
              quote_highlight = "Quote",
              quote_string = "┃",
              fat_headlines = true,
              fat_headline_upper_string = "▃",
              fat_headline_lower_string = "🬂",
            },
            -- rmd = {
            --  query = vim.treesitter.query.parse (
            --     "markdown",
            --     [[
            --       (atx_heading [
            --           (atx_h1_marker)
            --           (atx_h2_marker)
            --           (atx_h3_marker)
            --           (atx_h4_marker)
            --           (atx_h5_marker)
            --           (atx_h6_marker)
            --       ] @headline)
            --
            --       (thematic_break) @dash
            --
            --       (fenced_code_block) @codeblock
            --
            --       (block_quote_marker) @quote
            --       (block_quote (paragraph (inline (block_continuation) @quote)))
            --   ]]
            --   ),
            --   treesitter_language = "markdown",
            --   headline_highlights = { "Headline" },
            --   codeblock_highlight = "CodeBlock",
            --   dash_highlight = "Dash",
            --   dash_string = "-",
            --   quote_highlight = "Quote",
            --   quote_string = "┃",
            --   fat_headlines = true,
            --   fat_headline_upper_string = "▃",
            --   fat_headline_lower_string = "🬂",
            -- },
            -- norg = {
            --  query = vim.treesitter.query.parse (
            --     "norg",
            --     [[
            --       [
            --           (heading1_prefix)
            --           (heading2_prefix)
            --           (heading3_prefix)
            --           (heading4_prefix)
            --           (heading5_prefix)
            --           (heading6_prefix)
            --       ] @headline
            --
            --       (weak_paragraph_delimiter) @dash
            --       (strong_paragraph_delimiter) @doubledash
            --
            --       ([(ranged_tag
            --           name: (tag_name) @_name
            --           (#eq? @_name "code")
            --       )
            --       (ranged_verbatim_tag
            --           name: (tag_name) @_name
            --           (#eq? @_name "code")
            --       )] @codeblock (#offset! @codeblock 0 0 1 0))
            --
            --       (quote1_prefix) @quote
            --   ]]
            --   ),
            --   headline_highlights = { "Headline" },
            --   codeblock_highlight = "CodeBlock",
            --   dash_highlight = "Dash",
            --   dash_string = "-",
            --   doubledash_highlight = "DoubleDash",
            --   doubledash_string = "=",
            --   quote_highlight = "Quote",
            --   quote_string = "┃",
            --   fat_headlines = true,
            --   fat_headline_upper_string = "▃",
            --   fat_headline_lower_string = "🬂",
            -- },
            org = {
              query = vim.treesitter.query.parse(
                "org",
                [[
                (headline (stars) @headline)

                (
                    (expr) @dash
                    (#match? @dash "^-----+$")
                )

                (block
                    name: (expr) @_name
                    (#eq? @_name "SRC")
                ) @codeblock

                (paragraph . (expr) @quote
                    (#eq? @quote ">")
                )
            ]]
              ),
              headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5" },
              codeblock_highlight = "CodeBlock",
              dash_highlight = "Dash",
              dash_string = "-",
              quote_highlight = "Quote",
              quote_string = "┃",
              fat_headlines = true,
              fat_headline_upper_string = "▃",
              fat_headline_lower_string = "▀", -- 🬂
            },
          }
        end,
      },

      {
        "dhruvasagar/vim-table-mode",
      },

      {
        "NFrid/due.nvim",
      },
      {
        "danilshvalov/org-modern.nvim",
      },
    },

    event = "BufEnter *.org",

    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      -- require("nvim-treesitter.configs").setup

      -- Custom Menu
      local Menu = require "org-modern.menu"
      -- Setup orgmode
      require("orgmode").setup {
        org_startup_folded = "inherit",
        org_agenda_files = "~/org/**/*.org",
        org_default_notes_file = "~/org/daily/routine.org",
        ui = {
          menu = {
            handler = function(data)
              Menu:new({
                window = {
                  margin = { 1, 0, 1, 0 },
                  padding = { 0, 1, 0, 1 },
                  title_pos = "center",
                  border = "single",
                  zindex = 1000,
                },
                icons = {
                  separator = "➜",
                },
              }):open(data)
            end,
          },
        },
      }

      -- Conceal links, bolds etc.
      vim.opt.conceallevel = 2
      vim.opt.concealcursor = "nc"

      vim.cmd [[TableModeEnable]] -- Align tables with ||
      require("due_nvim").draw(0) -- Draw Due Dates
    end,
  },

  {
    "dhruvasagar/vim-table-mode",

    keys = {
      { "<leader>mkk", "<cmd> TableModeToggle<CR>", mode = "n", desc = "Toggle Table Mode" },
      { "<leader>mka", "<cmd> TableAddFormula<CR>", mode = "n", desc = "Add Formula" },
      { "<leader>mke", "<cmd> TableEvalFormulaLine<CR>", mode = "n", desc = "Eval Formula" },
      { "<leader>mkr", "<cmd> TableModeRealign<CR>", mode = "n", desc = "Realign Table" },
      { "<leader>mkl", "<cmd> Tableize<CR>", mode = "n", desc = "Tableize" },
      { "<leader>mks", "<cmd> TableSort<CR>", mode = "n", desc = "Sort Table" },
    },

    config = function()
      -- WARNING: Mapping these keys would probably cause something (NOT) funny
      vim.keymap.del("n", "<leader>tm")
      vim.keymap.del("n", "<leader>tt")
    end,
  },

  {
    "NFrid/due.nvim",

    keys = {
      -- require("due_nvim").draw(0)   -- Draws it for a buffer (0 to current)
      -- require("due_nvim").clean(0)  -- Cleans the array from it
      -- require("due_nvim").redraw(0) -- Cleans, then draws
      -- require("due_nvim").async_update(0) -- Runs the async update function (needs update_rate > 0)
      {
        "<leader>mc",
        function()
          require("due_nvim").draw(0)
        end,
        mode = "n",
        desc = "Due Mode",
      },
      -- {
      --   "<leader>md",
      --   function () require("due_nvim").clean(0) end,
      --   mode = "n",
      --   desc = "Due Clean",
      -- },
      -- {
      --   "<leader>mr",
      --   function () require("due_nvim").redraw(0) end,
      --   mode = "n",
      --   desc = "Due Redraw",
      -- },
      -- {
      --   "<leader>mu",
      --   function () require("due_nvim").async_update(0) end,
      --   mode = "n",
      --   desc = "Due Async Update",
      -- },
    },

    config = function(_, opts)
      local date_pattern = [[(%d%d)%-(%d%d)]]
      local datetime_pattern = date_pattern .. " (%d+):(%d%d)" -- m, d, h, min
      local fulldatetime_pattern = "(%d%d%d%d)%-" .. datetime_pattern -- y, m, d, h, min
      vim.o.foldlevel = 99

      require("due_nvim").setup {
        prescript = "due: ", -- prescript to due data
        prescript_hi = "Comment", -- highlight group of it
        due_hi = "String", -- highlight group of the data itself
        ft = "*.md", -- filename template to apply aucmds :)
        today = "TODAY", -- text for today's due
        today_hi = "Character", -- highlight group of today's due
        overdue = "OVERDUE", -- text for overdued
        overdue_hi = "Error", -- highlight group of overdued
        date_hi = "Conceal", -- highlight group of date string

        -- NOTE: needed for more complex patterns (e.g orgmode dates)
        pattern_start = "", -- start for a date string pattern
        pattern_end = "", -- end for a date string pattern
        -- pattern_start = "<", -- start for a date string pattern
        -- pattern_end = ">", -- end for a date string pattern

        -- lua patterns: in brackets are 'groups of data', their order is described
        -- accordingly. More about lua patterns: https://www.lua.org/pil/20.2.html
        date_pattern = date_pattern, -- m, d
        datetime_pattern = datetime_pattern, -- m, d, h, min
        datetime12_pattern = datetime_pattern .. " (%a%a)", -- m, d, h, min, am/pm
        fulldate_pattern = "(%d%d%d%d)%-" .. date_pattern, -- y, m, d
        fulldatetime_pattern = fulldatetime_pattern, -- y, m, d, h, min
        fulldatetime12_pattern = fulldatetime_pattern .. " (%a%a)", -- y, m, d, h, min, am/pm
        -- idk how to allow to define the order by config yet,
        -- but you can help me figure it out...

        -- regex_hi = "\\d*-*\\d\\+-\\d\\+\\( \\d*:\\d*\\( \\a\\a\\)\\?\\)\\?",
        regex_hi = [[\d*-*\d\+-\d\+\( \d*:\d*\( \a\a\)\?\)\?]],

        -- vim regex for highlighting, notice double
        -- backslashes cuz lua strings escaping

        -- update_rate = use_clock_time and (use_seconds and 1000 or 60000) or 0,
        -- selects the rate due clocks will update in
        -- milliseconds. 0 or less disables it

        use_clock_time = false, -- display also hours and minutes
        use_clock_today = false, -- do it instead of TODAY
        use_seconds = false, -- if use_clock_time == true, display seconds
        -- as well
        default_due_time = "midnight", -- if use_clock_time == true, calculate time
        -- until option on specified date. Accepts
        -- "midnight", for 23:59:59, or noon, for
        -- 12:00:00
      }
    end,
  },

  -- { -- `nvim` inside terminal triggers new tab instead opening a nested nvim instance
  --   "willothy/flatten.nvim",
  --   config = true,
  --   -- or pass configuration with
  --   -- opts = {  },
  --
  --   -- Ensure that it runs first to minimize delay when opening file from terminal
  --   lazy = false, -- TODO: think more about it
  --   priority = 1001,
  -- },
  -- { -- Same as above but different implementation
  --   "samjwill/nvim-unception",
  --   init = function()
  --     -- Optional settings go here!
  --     -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
  --   end,
  -- },

  { -- Same with nvim-biscuits
    -- TODO: migrate to this
    "andersevenrud/nvim_context_vt",
    dependencies = "nvim-treesitter",
    config = function(_, opts)
      require("nvim_context_vt").setup(opts)
      vim.cmd [[NvimContextVtToggle]]
    end,

    keys = {
      {
        "<leader>me",
        "<cmd> NvimContextVtToggle<CR>",
        mode = "n",
        desc = "Toggle Context Visualizer",
      },
    },

    -- opts = function()
    --   return {
    --     -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
    --     -- Default: true
    --     enabled = true,
    --
    --     -- Override default virtual text prefix
    --     -- Default: '-->'
    --     prefix = "",
    --
    --     -- Override the internal highlight group name
    --     -- Default: 'ContextVt'
    --     highlight = "CustomContextVt",
    --
    --     -- Disable virtual text for given filetypes
    --     -- Default: { 'markdown' }
    --     disable_ft = { "markdown" },
    --
    --     -- Disable display of virtual text below blocks for indentation based languages like Python
    --     -- Default: false
    --     disable_virtual_lines = false,
    --
    --     -- Same as above but only for spesific filetypes
    --     -- Default: {}
    --     disable_virtual_lines_ft = { "yaml" },
    --
    --     -- How many lines required after starting position to show virtual text
    --     -- Default: 1 (equals two lines total)
    --     min_rows = 1,
    --
    --     -- Same as above but only for spesific filetypes
    --     -- Default: {}
    --     min_rows_ft = {},
    --
    --     -- Custom virtual text node parser callback
    --     -- Default: nil
    --     custom_parser = function(node, ft, opts)
    --       local utils = require "nvim_context_vt.utils"
    --
    --       -- If you return `nil`, no virtual text will be displayed.
    --       if node:type() == "function" then
    --         return nil
    --       end
    --
    --       -- This is the standard text
    --       return opts.prefix .. " " .. utils.get_node_text(node)[1]
    --     end,
    --
    --     -- Custom node validator callback
    --     -- Default: nil
    --     custom_validator = function(node, ft, opts)
    --       -- Internally a node is matched against min_rows and configured targets
    --       local default_validator = require("nvim_context_vt.utils").default_validator
    --       if default_validator(node, ft) then
    --         -- Custom behaviour after using the internal validator
    --         if node:type() == "function" then
    --           return false
    --         end
    --       end
    --
    --       return true
    --     end,
    --
    --     -- Custom node virtual text resolver callback
    --     -- Default: nil
    --     custom_resolver = function(nodes, ft, opts)
    --       -- By default the last node is used
    --       return nodes[#nodes]
    --     end,
    --   }
    -- end,
  },

  -- { -- Center a window
  --   FIXME: TODO
  --   "shortcuts/no-neck-pain.nvim",
  --   config = function(_, opts)
  --     require("no-neck-pain").setup(opts)
  --   end,
  --
  --   opts = {
  --     -- Prints useful logs about triggered events, and reasons actions are executed.
  --     --- @type boolean
  --     debug = false,
  --     -- The width of the focused window that will be centered. When the terminal width is less than the `width` option, the side buffers won't be created.
  --     --- @type integer|"textwidth"|"colorcolumn"
  --     width = 100,
  --     -- Represents the lowest width value a side buffer should be.
  --     -- This option can be useful when switching window size frequently, example:
  --     -- in full screen screen, width is 210, you define an NNP `width` of 100, which creates each side buffer with a width of 50. If you resize your terminal to the half of the screen, each side buffer would be of width 5 and thereforce might not be useful and/or add "noise" to your workflow.
  --     --- @type integer
  --     minSideBufferWidth = 10,
  --     -- Disables the plugin if the last valid buffer in the list have been closed.
  --     --- @type boolean
  --     disableOnLastBuffer = false,
  --     -- When `true`, disabling the plugin closes every other windows except the initially focused one.
  --     --- @type boolean
  --     killAllBuffersOnDisable = false,
  --     -- Adds autocmd (@see `:h autocmd`) which aims at automatically enabling the plugin.
  --     --- @type table
  --     autocmds = {
  --       -- When `true`, enables the plugin when you start Neovim.
  --       -- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
  --       -- The command is cleaned once it has successfuly ran once.
  --       --- @type boolean
  --       enableOnVimEnter = false,
  --       -- When `true`, enables the plugin when you enter a new Tab.
  --       -- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
  --       --- @type boolean
  --       enableOnTabEnter = false,
  --       -- When `true`, reloads the plugin configuration after a colorscheme change.
  --       --- @type boolean
  --       reloadOnColorSchemeChange = false,
  --     },
  --     -- Creates mappings for you to easily interact with the exposed commands.
  --     --- @type table
  --     mappings = {
  --       -- When `true`, creates all the mappings that are not set to `false`.
  --       --- @type boolean
  --       enabled = false,
  --       -- Sets a global mapping to Neovim, which allows you to toggle the plugin.
  --       -- When `false`, the mapping is not created.
  --       --- @type string
  --       toggle = "<Leader>np",
  --       -- Sets a global mapping to Neovim, which allows you to increase the width (+5) of the main window.
  --       -- When `false`, the mapping is not created.
  --       --- @type string
  --       widthUp = "<Leader>n=",
  --       -- Sets a global mapping to Neovim, which allows you to decrease the width (-5) of the main window.
  --       -- When `false`, the mapping is not created.
  --       --- @type string
  --       widthDown = "<Leader>n-",
  --       -- Sets a global mapping to Neovim, which allows you to toggle the scratchpad feature.
  --       -- When `false`, the mapping is not created.
  --       --- @type string
  --       scratchPad = "<Leader>ns",
  --     },
  --     --- Common options that are set to both side buffers.
  --     --- See |NoNeckPain.bufferOptions| for option scoped to the `left` and/or `right` buffer.
  --     --- @type table
  --     buffers = {
  --       -- When `true`, the side buffers will be named `no-neck-pain-left` and `no-neck-pain-right` respectively.
  --       --- @type boolean
  --       setNames = false,
  --       -- Leverages the side buffers as notepads, which work like any Neovim buffer and automatically saves its content at the given `location`.
  --       -- note: quitting an unsaved scratchpad buffer is non-blocking, and the content is still saved.
  --       --- see |NoNeckPain.bufferOptionsScratchpad|
  --       -- scratchPad = NoNeckPain.bufferOptionsScratchpad,
  --       -- -- colors to apply to both side buffers, for buffer scopped options @see |NoNeckPain.bufferOptions|
  --       -- --- see |NoNeckPain.bufferOptionsColors|
  --       -- colors = NoNeckPain.bufferOptionsColors,
  --       -- -- Vim buffer-scoped options: any `vim.bo` options is accepted here.
  --       -- --- @see NoNeckPain.bufferOptionsBo `:h NoNeckPain.bufferOptionsBo`
  --       -- bo = NoNeckPain.bufferOptionsBo,
  --       -- -- Vim window-scoped options: any `vim.wo` options is accepted here.
  --       -- --- @see NoNeckPain.bufferOptionsWo `:h NoNeckPain.bufferOptionsWo`
  --       -- wo = NoNeckPain.bufferOptionsWo,
  --       -- --- Options applied to the `left` buffer, options defined here overrides the `buffers` ones.
  --       -- --- @see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
  --       -- left = NoNeckPain.bufferOptions,
  --       -- --- Options applied to the `right` buffer, options defined here overrides the `buffers` ones.
  --       -- --- @see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
  --       -- right = NoNeckPain.bufferOptions,
  --     },
  --     -- Supported integrations that might clash with `no-neck-pain.nvim`'s behavior.
  --     --- @type table
  --     integrations = {
  --       -- By default, if NvimTree is open, we will close it and reopen it when enabling the plugin,
  --       -- this prevents having the side buffers wrongly positioned.
  --       -- @link https://github.com/nvim-tree/nvim-tree.lua
  --       --- @type table
  --       NvimTree = {
  --         -- The position of the tree.
  --         --- @type "left"|"right"
  --         position = "left",
  --         -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
  --         --- @type boolean
  --         reopen = true,
  --       },
  --       -- By default, if NeoTree is open, we will close it and reopen it when enabling the plugin,
  --       -- this prevents having the side buffers wrongly positioned.
  --       -- @link https://github.com/nvim-neo-tree/neo-tree.nvim
  --       NeoTree = {
  --         -- The position of the tree.
  --         --- @type "left"|"right"
  --         position = "left",
  --         -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
  --         reopen = true,
  --       },
  --       -- @link https://github.com/mbbill/undotree
  --       undotree = {
  --         -- The position of the tree.
  --         --- @type "left"|"right"
  --         position = "left",
  --       },
  --     },
  --   },
  --
  --   -- NoNeckPain.bufferOptions = {
  --   --     -- When `false`, the buffer won't be created.
  --   --     --- @type boolean
  --   --     enabled = true,
  --   --     --- @see NoNeckPain.bufferOptionsColors `:h NoNeckPain.bufferOptionsColors`
  --   --     colors = NoNeckPain.bufferOptionsColors,
  --   --     --- @see NoNeckPain.bufferOptionsBo `:h NoNeckPain.bufferOptionsBo`
  --   --     bo = NoNeckPain.bufferOptionsBo,
  --   --     --- @see NoNeckPain.bufferOptionsWo `:h NoNeckPain.bufferOptionsWo`
  --   --     wo = NoNeckPain.bufferOptionsWo,
  --   --     --- @see NoNeckPain.bufferOptionsScratchpad `:h NoNeckPain.bufferOptionsScratchpad`
  --   --     scratchPad = NoNeckPain.bufferOptionsScratchpad,
  --   -- }
  --   --
  --   -- NoNeckPain.bufferOptionsWo = {
  --   --     --- @type boolean
  --   --     cursorline = false,
  --   --     --- @type boolean
  --   --     cursorcolumn = false,
  --   --     --- @type string
  --   --     colorcolumn = "0",
  --   --     --- @type boolean
  --   --     number = false,
  --   --     --- @type boolean
  --   --     relativenumber = false,
  --   --     --- @type boolean
  --   --     foldenable = false,
  --   --     --- @type boolean
  --   --     list = false,
  --   --     --- @type boolean
  --   --     wrap = true,
  --   --     --- @type boolean
  --   --     linebreak = true,
  --   -- }
  --   --
  --   -- NoNeckPain.bufferOptionsBo = {
  --   --     --- @type string
  --   --     filetype = "no-neck-pain",
  --   --     --- @type string
  --   --     buftype = "nofile",
  --   --     --- @type string
  --   --     bufhidden = "hide",
  --   --     --- @type boolean
  --   --     buflisted = false,
  --   --     --- @type boolean
  --   --     swapfile = false,
  --   -- }
  --   --
  --   -- --- NoNeckPain's scratchpad buffer options.
  --   -- ---
  --   -- --- Leverages the side buffers as notepads, which work like any Neovim buffer and automatically saves its content at the given `location`.
  --   -- --- note: quitting an unsaved scratchpad buffer is non-blocking, and the content is still saved.
  --   -- ---
  --   -- ---@type table
  --   -- ---Default values:
  --   -- ---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
  --   -- NoNeckPain.bufferOptionsScratchpad = {
  --   --     -- When `true`, automatically sets the following options to the side buffers:
  --   --     -- - `autowriteall`
  --   --     -- - `autoread`.
  --   --     --- @type boolean
  --   --     enabled = false,
  --   --     -- The name of the generated file. See `location` for more information.
  --   --     --- @type string
  --   --     --- @example: `no-neck-pain-left.norg`
  --   --     fileName = "no-neck-pain",
  --   --     -- By default, files are saved at the same location as the current Neovim session.
  --   --     -- note: filetype is defaulted to `norg` (https://github.com/nvim-neorg/neorg), but can be changed in `buffers.bo.filetype` or |NoNeckPain.bufferOptions| for option scoped to the `left` and/or `right` buffer.
  --   --     --- @type string?
  --   --     --- @example: `no-neck-pain-left.norg`
  --   --     location = nil,
  --   -- }
  --   --
  --   -- NoNeckPain.bufferOptionsColors = {
  --   --     -- Hexadecimal color code to override the current background color of the buffer. (e.g. #24273A)
  --   --     -- Transparent backgrounds are supported by default.
  --   --     --- @type string?
  --   --     background = nil,
  --   --     -- Brighten (positive) or darken (negative) the side buffers background color. Accepted values are [-1..1].
  --   --     --- @type integer
  --   --     blend = 0,
  --   --     -- Hexadecimal color code to override the current text color of the buffer. (e.g. #7480c2)
  --   --     --- @type string?
  --   --     text = nil,
  --   -- }
  -- },

  {
    "chrisgrieser/nvim-various-textobjs",
    -- lazy = false, -- TODO: Think more about it

    keys = {
      "di",
      "ci",
      "yi",
      "vi",
    },

    opts = {
      useDefaultKeymaps = true,
    },
  },

  {
    "LudoPinelli/comment-box.nvim",
    config = function(_, opts)
      require("comment-box").setup(opts)
    end,

    keys = {
      {
        "<leader>bb",
        function()
          require("comment-box").ccbox()
        end,
        mode = { "n", "v" },
        desc = "Comment Box",
      },

      {
        "<leader>be",
        function()
          -- take an input:
          local input = vim.fn.input "Catalog: "
          require("comment-box").ccbox(input)
        end,
        mode = { "n", "v" },
        desc = "Left Comment Box",
      },

      {
        "<leader>bc",
        function()
          require("comment-box").lbox()
        end,
        mode = { "n", "v" },
        desc = "Left Comment Box",
      },

      {
        "<leader>bx",
        function()
          require("comment-box").catalog()
        end,
        mode = { "n", "v" },
        desc = "Comment Catalog",
      },
    },

    opts = {
      doc_width = 80, -- width of the document
      box_width = 60, -- width of the boxes
      borders = { -- symbols used to draw a box
        top = "─",
        bottom = "─",
        left = "│",
        right = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
      },
      line_width = 70, -- width of the lines
      line = { -- symbols used to draw a line
        line = "─",
        line_start = "─",
        line_end = "─",
      },
      outer_blank_lines = false, -- insert a blank line above and below the box
      inner_blank_lines = false, -- insert a blank line above and below the text
      line_blank_line_above = false, -- insert a blank line above the line
      line_blank_line_below = false, -- insert a blank line below the line
    },
  },

  --  [markdown markmap]
  --  https://github.com/Zeioth/markmap.nvim
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",

    keys = {
      -- {"<leader>mm", "<cmd> MarkmapOpen<CR>", mode = "n", desc = "Open Markmap"},
      -- {"<leader>mq", "<cmd> MarkmapWatchStop<CR>", mode = "n", desc = "Stop Markmap"},
      { "<leader>cmk", "<cmd> MarkmapWatch<CR>", mode = "n", desc = "Watch Markmap" },
      { "<leader>cms", "<cmd> MarkmapSave<CR>", mode = "n", desc = "Save Markmap" },
    },

    cmd = {
      "MarkmapOpen",
      "MarkmapSave",
      "MarkmapWatch",
      "MarkmapWatchStop",
    },

    opts = {
      html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts)
      require("markmap").setup(opts)
    end,
  },

  {
    "tommcdo/vim-exchange",

    keys = {
      { "cx", mode = "n" },
      { "X", mode = "v" },
    },
  },

  { -- Session Manager
    "folke/persistence.nvim",

    -- event = "BufReadPre", -- this will only start session saving when an actual file was opened

    -- restore the session for the current directory
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        mode = "n",
        desc = "Save Session",
      },
      -- restore the last session
      {
        "<leader>ql",
        function()
          require("persistence").load { last = true }
        end,
        mode = "n",
        desc = "Restore Session",
      },
      -- stop Persistence => session won't be saved function()on exit
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Stop Session Save",
        mode = "n",
      },
    },

    opts = {
      -- add any custom options here
    },
  },

  -- { -- Lazy plugin installlation system
  --   -- WARNING: Laggy, incomplete
  --   "roobert/activate.nvim",
  --   keys = {
  --     {
  --       "<leader>P",
  --       function()
  --         require("activate").list_plugins()
  --       end,
  --       desc = "Plugins",
  --     },
  --   },
  -- },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>P",
        "<cmd> Telescope lazy<CR>",
        desc = "Surf Plugins",
      },
    },

    dependencies = {
      "tsakirist/telescope-lazy.nvim",
      opts = {
        extensions = {
          lazy = {
            -- Optional theme (the extension doesn't set a default theme)
            theme = "ivy",
            -- Whether or not to show the icon in the first column
            show_icon = true,
            -- Mappings for the actions
            mappings = {
              open_in_browser = "<C-o>",
              open_in_file_browser = "<M-b>",
              open_in_find_files = "<C-f>",
              open_in_live_grep = "<C-g>",
              open_plugins_picker = "<C-b>", -- Works only after having called first another action
              open_lazy_root_find_files = "<C-r>f",
              open_lazy_root_live_grep = "<C-r>g",
            },
            -- Other telescope configuration options
          },
        },
      },
    },
  },

  -- { -- Embed Neovim into browsers
  --   -- Doesn't work. (Probably because the installation method I used to install my browser)
  --   "glacambre/firenvim",
  --
  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   -- lazy = not vim.g.started_by_firenvim,
  --   lazy = false,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- },

  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",

    keys = {
      {
        "<leader>vf",
        "<cmd> Speedtyper<CR>",
        mode = "n",
        desc = "Type Speed Game",
      },
    },

    opts = {
      -- your config
    },
  },

  -- { -- Reminds you to drink water
  --   "stefanlogue/hydrate.nvim",
  --   -- This installs the latest stable release.
  --   -- Set to false or omit to install the latest development version
  --   version = "*",
  --   opts = {
  --     -- The interval between notifications in minutes
  --     minute_interval = 20,
  --
  --     -- The render style for notifications
  --     -- Accepted values are "default", "minimal", "simple" or "compact"
  --     render_style = "compact",
  --
  --     -- Loads time of last drink on startup
  --     -- Useful if you don't have long-running neovim instances
  --     -- or if you tend to have multiple instances running at a time
  --     persist_timer = false,
  --   },
  -- },

  -- { -- Breaks vimacs
  --   "Rawnly/gist.nvim",
  --   cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
  --   -- dependencies = {
  --   --   -- `GistsList` opens the selected gif in a terminal buffer,
  --   --   -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
  --   --   -- and prevents neovim buffer inception
  --   --   "samjwill/nvim-unception",
  --   --   -- lazy = false,
  --   --   config = function()
  --   --     vim.g.unception_block_while_host_edits = true
  --   --   end,
  --   -- },
  --
  --   config = true,
  -- },
  {
    "m4xshen/smartcolumn.nvim",
    keys = {
      { "<leader>mj", mode = "n", desc = "Smart Column" },
    },
    opts = {
      colorcolumn = "100",
      disabled_filetypes = { "help", "text", "markdown" },
      custom_colorcolumn = {},
      scope = "file",
    },
  },

  { -- Glyph Picker
    "2kabhishek/nerdy.nvim",

    keys = {
      {
        "<leader>fe",
        "<cmd> Nerdy<CR>",
        mode = "n",
        desc = "Glyph Picker",
      }, -- Gigantic Search Base
    },

    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

  { -- Note this plugin is written as dependency of quickfix plugins
    -- Prettier quickfix window
    "yorickpeterse/nvim-pqf",

    dependencies = {
      "kevinhwang91/nvim-bqf",
    },

    config = function(_, opts)
      require("pqf").setup(opts)
    end,

    opts = {
      signs = {
        error = "E",
        warning = "W",
        info = "I",
        hint = "H",
      },

      -- By default, only the first line of a multi line message will be shown.
      -- When this is true, multiple lines will be shown for an entry, separated by a space
      show_multiple_lines = false,

      -- How long filenames in the quickfix are allowed to be. 0 means no limit.
      -- Filenames above this limit will be truncated from the beginning with [...]
      max_filename_length = 0,
    },
  },

  {
    "chentoast/marks.nvim",

    keys = {
      {
        "<leader>bm",
        "<cmd> MarksToggleSigns<CR>",
        mode = "n",
        desc = "Marks",
      },
    },

    config = function(_, opts)
      require("marks").setup(opts)
      -- This plugin enables by default
      -- So we toggle it to reanable it (because we only have a toggling function)
      vim.cmd [[MarksToggleSigns]]
    end,

    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
      mappings = {},
    },
  },

  { -- Native Plugin (for of neoproj)
    "UTFeight/neoproj",

    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },

    cmd = {
      "ProjectOpen",
      "ProjectNew",
    },

    keys = {
      -- { -- Using <leader>fp is suggested
      --   "<leader>pf",
      --   "<cmd> ProjectOpen<CR>",
      --   mode = "n",
      --   desc = "Project",
      -- },
      {
        "<leader>nn",
        "<cmd> ProjectNew<CR>",
        mode = "n",
        desc = "New Project",
      },
    },

    config = function(_, opts)
      require("neoproj").setup(opts.setup)
      for _, template in ipairs(opts.templates) do
        if template.repo then
          require("neoproj").register_template {
            name = template.name,

            expand = function()
              -- vim.cmd ":Telescope file_browser path=%:p:h select_buffer=true<CR>"
              local cmd = require("neoproj").create_project(template.repo, template.opts)
              os.execute(cmd)
            end,
          }
        else
          require("neoproj").register_template(template)
        end
      end
    end,

    opts = require("custom.configs.neoproj").opts,
  },

  {
    "mrjones2014/smart-splits.nvim",
    -- For Kitty Terminal Emulator
    -- build = "./kitty/install-kittens.bash",
    keys = {
      {
        "<C-Up",
        function()
          require("smart-splits").resize_up(5)
        end,
        mode = "n",
        desc = "Resize Up",
      },
      {
        "<C-Down>",
        function()
          require("smart-splits").resize_down(5)
        end,
        mode = "n",
        desc = "Resize Down",
      },
      {
        "<C-Left>",
        function()
          require("smart-splits").resize_left(5)
        end,
        mode = "n",
        desc = "Resize Left",
      },
      {
        "<C-Right>",
        function()
          require("smart-splits").resize_right(5)
        end,
        mode = "n",
        desc = "Resize Right",
      },

      {
        "<leader>mr",
        function()
          require("smart-splits").start_resize_mode()
        end,
        mode = "n",
        desc = "Resize Mode",
      },
    },

    config = function(_, opts)
      require("smart-splits").setup()
    end,
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = {
      {
        "<C-n>",
        function()
          vim.cmd [[call vm#insert#insert()]]
        end,
        mode = "i",
        desc = "Insert Mode",
      },
      {
        "<C-n>",
        function()
          vim.cmd [[call vm#visual_multi#start()]]
        end,
        mode = "n",
        desc = "Normal Mode",
      },
    },
  },
}

return plugins

-- TODO: Fix Lazy.nvim breaking the Nvdash (from some plugin that I installed)
