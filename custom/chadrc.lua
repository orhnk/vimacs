---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "one_light" },

  -- transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
    header = {
      -- "         ___    ___        ",
      -- "      ./ .-'   '-. \\.      ",
      -- "    .'   '/     \\'   '.    ",
      -- "    |.-../ o   o \\..-.|    ",
      -- " (| |   /  _\\ /_  \\   | |) ",
      -- "  \\\\\\  (_.'.'\"'.'._)  ///  ",
      -- "   \\\\'._(..:   :..)_.'//   ",
      -- "    \\'.__\\ .:-:. /__.'/   ",
      -- "     '---->.___.<----'     ",
      -- "     .'.-'/.=^=.\\'-.'.     ",
      -- "    /.'  //     \\\\  `.\\    ",
      -- "   ||   ||       ||   ||   ",
      -- "    \\)  ||       ||  (/    ",
      -- "        \\)       (/        ",

      -- F_P
      -- "          ,--'\\                          ",
      -- "       .-/__ / \\.-\\           .--.       ",
      -- "       \\/      / _/    .-''-./  .'\\      ",
      -- "       (\\__.-')   \\    | /-'|.'-   \\     ",
      -- "       \\/  \\--'    |  _/|   |      |     ",
      -- "       /.. /  .-'  |-'  /   |      |     ",
      -- "       \\__/  /     /   |            \\    ",
      -- "        \\__/-''    .   .'   ' \\       \\   ",
      -- "         |.'\\-        /   .           \\  ",
      -- "        /, - /    \\_.'                |  ",
      -- "        |\\/-'                      |  |  ",
      -- "        |            /             /   \\ ",
      -- "       .|           |             /     |",
      -- "      / |               ______.--'   __.'",
      -- "     |   \\ __/    /---''    `-.---'-'    ",
      -- "     \\__/ /      /                       ",
      -- "          `--..-'                        ",

      -- "                                   ",
      "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀ ⠢⣀⡀⠈⠙⠿⠄    ",
      "          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
      " ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
      "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
      "                                   ",
      "     There is no place like ~/     ",
    },
  },

  lsp = {
    -- show function signatures i.e args as you type
    signature = {
      disabled = false,
      silent = true, -- silences 'no signature help available' message from appearing
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
