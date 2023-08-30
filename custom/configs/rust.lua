local M = {}

M.keys = {
  {
    "<leader>cxt",
    function()
      require("crates").toggle()
    end,
    mode = "n",
    desc = "Toggle UI elements",
  },

  {
    "<leader>cxr",
    function()
      require("crates").reload()
    end,
    mode = "n",
    desc = "Reload",
  },

  {
    "<leader>cxv",
    function()
      require("crates").show_versions_popup()
    end,
    mode = "n",
    desc = "Show Version",
  },

  {
    "<leader>cxf",
    function()
      require("crates").show_features_popup()
    end,
    mode = "n",
    desc = "Show Feature",
  },

  {
    "<leader>cxd",
    function()
      require("crates").show_dependencies_popup()
    end,
    mode = "n",
    desc = "Show Dependencies",
  },

  {
    "<leader>cxu",
    function()
      require("crates").update_crate()
    end,
    mode = "n",
    desc = "Update Crate",
  },

  {
    "<leader>cxu",
    function()
      require("crates").update_crates()
    end,
    mode = "v",
    desc = "Update Selected Crates",
  },

  {
    "<leader>cxa",
    function()
      require("crates").update_all_crates()
    end,
    mode = "n",
    desc = "Update All Crates",
  },

  {
    "<leader>cxU",
    function()
      require("crates").upgrade_crate()
    end,
    mode = "n",
    desc = "Upgrade Crate",
  },

  {
    "<leader>cxU",
    function()
      require("crates").upgrade_crates()
    end,
    mode = "v",
    desc = "Upgrade Selected Crates",
  },
  {
    "<leader>cxA",
    function()
      require("crates").upgrade_all_crates()
    end,
    mode = "n",
    desc = "Upgrade All Crates",
  },

  {
    "<leader>cxe",
    function()
      require("crates").expand_plain_crate_to_inline_table()
    end,
    mode = "n",
    desc = "Inline Crate to Table",
  },

  {
    "<leader>cxE",
    function()
      require("crates").extract_crate_into_table()
    end,
    mode = "n",
    desc = "Extract Crate to table",
  },

  {
    "<leader>cxH",
    function()
      require("crates").open_homepage()
    end,
    mode = "n",
    desc = "Open Crate Home Page",
  },

  {
    "<leader>cxR",
    function()
      require("crates").open_repository()
    end,
    mode = "n",
    desc = "Open Crate Repository",
  },

  {
    "<leader>cxD",
    function()
      require("crates").open_documentation()
    end,
    mode = "n",
    desc = "Open Crate Documentation",
  },

  {
    "<leader>cxC",
    function()
      require("crates").open_crates_io()
    end,
    mode = "n",
    desc = "Open Crate on crates.io",
  },

  {
    "<leader>cxK",
    function()
      local filetype = vim.bo.filetype
      if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
      elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
      elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
      else
        vim.lsp.buf.hover()
      end
    end,
    mode = "n",
    desc = "Open Crate Documentation in a PopUp",
  },
}

M.opts = {
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
}

return M
