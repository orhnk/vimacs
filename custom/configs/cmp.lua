local M = {}

M.dependencies = {
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

  {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
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

    config = function(_, opts)
      require("plugins.configs.others").luasnip(opts)
    end,
  },

  -- -- These integrates with nvim-cmp with both Github Copilot and Tabnine AI
  -- -- I find it uncomfortable to use, so I disabled them
  -- -- >>> If you want to enable them don't forget to turn on them in `sources` too! <<<
  -- { -- Tabnine
  --   "tzachar/cmp-tabnine",
  --
  --   build = "./install.sh",
  --   dependencies = "hrsh7th/nvim-cmp",
  --
  --   config = function(_, opts)
  --     local tabnine = require "cmp_tabnine.config"
  --     tabnine:setup(opts)
  --   end,
  --
  --   opts = {
  --     max_lines = 1000,
  --     max_num_results = 20,
  --     sort = true,
  --     run_on_every_keystroke = true,
  --     snippet_placeholder = "..",
  --     ignored_file_types = {
  --       -- default is not to ignore
  --       -- uncomment to ignore in lua:
  --       -- lua = true
  --     },
  --     show_prediction_strength = false,
  --   },
  -- },

  -- { -- Copilot
  --   "zbirenbaum/copilot-cmp",
  --
  --   dependencies = {
  --     "zbirenbaum/copilot.lua",
  --
  --     opts = {
  --       suggestion = {
  --         enabled = false,
  --       },
  --
  --       panel = {
  --         enabled = false,
  --       },
  --     },
  --   },
  --
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  -- cmp sources plugins
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
} -- END NV-CMP DEPENDENCIES

-- ALL OPTS GET MERGED WITH DEFAULTS IN LAZY.nvim
M.opts = {
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
    -- { name = "copilot" },
    -- Tabnine
    -- { name = "cmp_tabnine" },

    -- Other Sources
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },

    -- Cargo.toml
    { name = "crates" },

    -- Other
    { name = "orgmode" },
    -- { name = "calc" },
  },
}

return M
