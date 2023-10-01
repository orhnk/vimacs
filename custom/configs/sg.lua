local M = {}
M.opts = {
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

M.keys = {

  {
    "<leader>ai",
    ":CodyChat<CR>",
    mode = "n",
    desc = "AI Assistant",
  },

  {
    "<leader>ad",
    function()
      local line = vim.fn.getline "."
      local start = vim.fn.col "."
      local finish = vim.fn.col "$"
      local text = line:sub(start, finish)
      vim.fn.setreg('"', text)
      vim.cmd [[CodyTask 'Write document for current context']]
    end,
    mode = "n",
    desc = "Generate Document with AI",
  },

  {
    "<leader>ac",
    ':CodyTask ""<Left>',
    mode = "n",
    desc = "Let AI Write Code",
  },

  {
    "<leader>aa",
    ":CodyTaskAccept<CR>",
    mode = "n",
    desc = "Confirm AI work",
  },

  {
    "<leader>as",
    "<cmd> lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
    mode = "n",
    desc = "AI Search",
  },

  {
    "<leader>ai",
    "y:CodyChat<CR><ESC>pG$a<CR>",
    mode = "v",
    desc = "Chat Selected Code",
  },

  -- {
  --   "<leader>ad",
  --   "{:CodyTask 'Write document for current context<CR>'",
  --   mode = "n",
  --   desc = "Generate Document with AI",
  -- },

  {
    "<leader>ar",
    "y:CodyChat<CR>refactor following code:<CR><ESC>p<CR>",
    mode = "v",
    desc = "Request Refactoring",
  },

  {
    "<leader>ae",
    "y:CodyChat<CR>explain following code:<CR><ESC>p<CR>",
    mode = "v",
    desc = "Request Explanation",
  },

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
}

return M
