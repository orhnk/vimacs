-- https://github.com/kevinhwang91/nvim-ufo

local M = {}

M.keys = {
  {
    "<leader>mu",
    mode = "n",
    desc = "UFO Mode",
  },
}

M.dependencies = {
  { "kevinhwang91/promise-async" },
  { -- Folds
    "yaocccc/nvim-foldsign",

    -- event = "CursorHold",

    config = function(_, opts)
      require("nvim-foldsign").setup(opts)
    end,

    opts = {
      offset = -3,
      foldsigns = {
        open = "", --   mark the beginning of a fold
        close = "", --  ↪ show a closed fold
        seps = {
          "▏",
          "▎",
          "▍",
          "▌",
          "▋",
          "▊",
          "▉",
          "█",
        }, -- open fold middle marker -- TODO: ADD MORE
        -- List of all vertical unicode characters: https://en.wikipedia.org/wiki/Box-drawing_character
        --  	"█", "▉", "▊", "▋", "▌", "▍", "▎", "▏",
        --    "│", "║", "┃", "▌", "█"
      },
    },
  },
}

M.opts = {
  -- enable_get_fold_virt_text = true, -- More info on https://github.com/kevinhwang91/nvim-ufo#setup-and-description
  open_fold_hl_timeout = 150,
  -- close_fold_kinds = { "imports", "comment" },
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  },

  provider_selector = function(bufnr, filetype, buftype)
    local ft_options = {
      norg = "", -- Neorg had the same issue
      org = "", -- We "disable" ufo in org files by giving back an empty provider to UFO
    }
    return ft_options[filetype] or { "treesitter", "indent" }
  end,

  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    -- local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local suffix = ("  %d "):format(endLnum - lnum) -- … 󱞣 󰧀  ⤵ ⤴ ⤶ ⤷ ⤸ ⤹ ⤺ ⤻ ⤼ ⤽ ⤾ ⤿

    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end,
}

return M
