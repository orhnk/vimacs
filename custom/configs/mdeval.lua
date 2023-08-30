local M = {}

M.keys = {
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
}

return M
