local M = {}

M.opts = {
  persist_settings = true, -- safe the settings under vim.fn.stdpath("data"), usually ~/.local/share/nvim,
  persist_games = true, -- persist a history of all played games
  default_mappings = true, -- if set to false you need to set your own, like the following:
  mappings = {
    { key = "x", action = "clear_cell" },
    { key = "r1", action = "insert=1" },
    { key = "r2", action = "insert=2" },
    { key = "r3", action = "insert=3" },
    -- ...
    { key = "r9", action = "insert=9" },
    { key = "gn", action = "new_game" },
    { key = "gr", action = "reset_game" },
    { key = "gs", action = "view=settings" },
    { key = "gt", action = "view=tip" },
    { key = "gz", action = "view=zen" },
    { key = "gh", action = "view=help" },
    { key = "u", action = "undo" },
    { key = "<C-r>", action = "redo" },
    { key = "+", action = "increment" },
    { key = "-", action = "decrement" },
  },
  custom_highlights = {
    board = { fg = "#7d7d7d" },
    number = { fg = "white", bg = "black" },
    active_menu = { fg = "white", bg = "black", gui = "bold" },
    hint_cell = { fg = "white", bg = "yellow" },
    square = { bg = "#292b35", fg = "white" },
    column = { bg = "#14151a", fg = "#d5d5d5" },
    row = { bg = "#14151a", fg = "#d5d5d5" },
    settings_disabled = { fg = "#8e8e8e", gui = "italic" },
    same_number = { fg = "white", gui = "bold" },
    set_number = { fg = "white", gui = "italic" },
    error = { fg = "white", bg = "#843434" },
  },
}

M.keys = {
  { "<leader>vs", "<cmd> Sudoku<CR>", mode = "n", desc = "Play Sudoku" },
}

return M
