local M = {}

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

M.keys = {
  -- {
  --   "<leader>sr",
  --   function()
  --     require("sniprun").run "n"
  --   end,
  --   mode = "n",
  --   desc = "Sniprun",
  -- },
  {
    "<leader>ir",
    "<cmd> SnipRun<CR>",
    mode = { "n", "v" },
    desc = "Run Snippet",
  },
  {
    "<leader>ii",
    function()
      require("sniprun").info()
    end,
    mode = "n",
    desc = "Info",
  },
  {
    "<leader>ie",
    function()
      require("sniprun").reset()
    end,
    mode = "n",
    desc = "Reset",
  },
  {
    "<leader>ic",
    function()
      require("sniprun").clear_rlepl()
    end,
    mode = "n",
    desc = "Clear REPL",
  },
  {
    "<leader>ix",
    function()
      require("sniprun.display").close_all()
    end,
    mode = "n",
    desc = "Close All",
  },
  {
    "<leader>il",
    function()
      require("sniprun.live_mode").toggle()
    end,
    mode = "n",
    desc = "Toggle Live Mode",
  },
}

M.opts = {
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
}

return M
