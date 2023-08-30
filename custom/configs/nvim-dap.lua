local M = {}

M.keys = {
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
}

return M
