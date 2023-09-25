-- TODO: There's a lot to do, (:h dap after lazy loading the plugin)
local utils = require "custom.utils"
local M = {}

M.keys = {
  {
    "<leader>dc",
    "<cmd>lua require('dap').continue()<CR>",
    mode = "n",
    desc = "Continue",
  },

  {
    "<leader>ds",
    "<cmd>lua require('dap').step_over()<CR>",
    mode = "n",
    desc = "Step Over",
  },

  {
    "<leader>di",
    "<cmd>lua require('dap').step_into()<CR>",
    mode = "n",
    desc = "Step Into",
  },

  {
    "<leader>do",
    "<cmd>lua require('dap').step_out()<CR>",
    mode = "n",
    desc = "Step Out",
  },

  {
    "<leader>db",
    function()
      -- require("persistent-breakpoints.api").toggle_breakpoint()
      require("dap").toggle_breakpoint()
      utils.store_breakpoints(false)
    end, -- Persist the breakpoints
    mode = "n",
    desc = "Toggle Breakpoint",
  },

  {
    "<leader>dB",
    function()
      -- require("persistent-breakpoints.api").set_conditional_breakpoint() -- Persist
      require("dap").toggle_breakpoint(vim.fn.input "Log: ")
      utils.store_breakpoints(false)
    end,
    mode = "n",
    desc = "Set Conditional Breakpoint",
  },

  {
    "<leader>dL",
    function()
      require("dap").toggle_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      utils.store_breakpoints(false)
    end,
    mode = "n",
    desc = "Log Point",
  },

  {
    "<leader>dl",
    "<cmd>lua require('dap').run_last()<CR>",
    mode = "n",
    desc = "Run Last",
  },

  {
    "<leader>dr",
    "<cmd>lua require('dap').repl.open()<CR>",
    mode = "n",
    desc = "Open REPL",
  },

  {
    "<leader>dd",
    "<cmd>lua require('dapui').toggle()<CR>",
    mode = "n",
    desc = "Toggle UI",
  },

  {
    "<leader>da",
    "<cmd>lua require('dapui').eval()<CR>",
    mode = "n",
    desc = "Evaluate",
  },

  {
    "<leader>du",
    "<cmd>lua require('dapui').scopes()<CR>",
    mode = "n",
    desc = "Scopes",
  },

  {
    "<leader>dv",
    "<cmd>lua require('dapui').variables()<CR>",
    mode = "n",
    desc = "Variables",
  },

  {
    "<leader>dw",
    "<cmd>lua require('dapui').watches()<CR>",
    mode = "n",
    desc = "Watches",
  },

  {
    "<leader>de",
    "<cmd>lua require('dapui').set_exception_breakpoints()<CR>",
    mode = "n",
    desc = "Exception Breakpoints",
  },

  {
    "<leader>di",
    "<cmd>lua require('dapui').pick_one()<CR>",
    mode = "n",
    desc = "Pick One",
  },

  { -- NOTE: Log Points are not persistent right now.
    "<leader>dj",
    function()
      require("dap").toggle_breakpoint(vim.fn.input "Log: ")
    end,
    mode = "n",
    desc = "Set Log Point",
  },

  {
    "<leader>dx",
    function()
      -- require("persistent-breakpoints.api").clear_all_breakpoints()
      require("dap").clear_breakpoints()
      utils.store_breakpoints(true)
    end,
    mode = "n",
    desc = "Clear Breakpoints",
  },

  {
    "<leader>dg",
    function()
      require("dap").list_breakpoints(0)
    end,
    mode = "n",
    desc = "Set REPL Highlight",
  },
}

return M
