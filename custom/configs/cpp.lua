local M = {}

    -- "Badhi/nvim-treesitter-cpp-tools",
-- C++ development
-- Nice but limited cpp codegen features which I'll (probably) not use (if you want create keymapps)
M.treesitter = {}
M.treesitter.keys = {
  { "<leader>cpl", ":TSCppDefineClassFunc<CR>", mode = "n", desc = "Define Class function" },
  { "<leader>cpm", ":TSCppMakeConcreteClass<CR>", mode = "n", desc = "Make Concrete Class" },
  { "<leader>cpo", ":TSCppRuleOf3<CR>", mode = "n", desc = "Rule of 3" },
  { "<leader>cpp", ":TSCppRuleOf5<CR>", mode = "n", desc = "Rule of 5" },

  { "<leader>cpl", ":TSCppDefineClassFunc<CR>", mode = "v", desc = "Define Class function" },
  { "<leader>cpm", ":TSCppMakeConcreteClass<CR>", mode = "v", desc = "Make Concrete Class" },
  { "<leader>cpo", ":TSCppRuleOf3<CR>", mode = "v", desc = "Rule of 3" },
  { "<leader>cpp", ":TSCppRuleOf5<CR>", mode = "v", desc = "Rule of 5" },
}

M.treesitter.opts = {
  preview = {
    quit = "q", -- optional keymapping for quit preview
    accept = "<tab>", -- optional keymapping for accept preview
  },
  --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
}

return M
