local M = {}

M.keys = {
  {
    "<leader>lq",
    [[ <cmd> vimgrep /\w\+/j % | copen<CR> ]],
    mode = "n",
    desc = "QuickFix Window",--[[ { noremap = true, silent = true } ]]
  },

  {
    "<leader>li",
    function()
      vim.diagnostic.setloclist()
    end,
    mode = "n",
    desc = "Diagnostic SetLocList",--[[ { noremap = true, silent = true } ]]
  },

  -- -- FIXME: Doesn't work
  -- {
  --   "gr",
  --   function()
  --     vim.lsp.buf.references()
  --   end,
  --   mode = "n",
  --   desc = "LSP references",
  -- },
  --
  -- {
  --   "gi",
  --   function()
  --     vim.lsp.buf.implementation()
  --   end,
  --   mode = "n",
  --   desc = "LSP implementation",
  -- },
  --
  -- {
  --   "gd",
  --   function()
  --     vim.lsp.buf.definition()
  --   end,
  --   mode = "n",
  --   desc = "LSP definition",
  -- },
  --
  -- {
  --   "gD",
  --   function()
  --     vim.lsp.buf.declaration()
  --   end,
  --   mode = "n",
  --   desc = "LSP declaration",
  -- },
}

M.opts = {
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    show_title = false,
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 102k
        ret = false
      elseif bufname:match "^fugitive://" then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end,
  },
  -- make `drop` and `tab drop` to become preferred
  func_map = {
    drop = "o",
    openc = "O",
    split = "<C-s>",
    tabdrop = "<C-t>",
    -- set to empty string to disable
    tabc = "",
    ptogglemode = "z,",
  },
  filter = {
    fzf = {
      action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
    },
  },
}

return M
