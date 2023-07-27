---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "everforest",
  theme_toggle = { "everforest", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
    header = {
      "         ___    ___        ",
      "      ./ .-'   '-. \\.      ",
      "    .'   '/     \\'   '.    ",
      "    |.-../ o   o \\..-.|    ",
      " (| |   /  _\\ /_  \\   | |) ",
      "  \\\\\\  (_.'.'\"'.'._)  ///  ",
      "   \\\\'._(..:   :..)_.'//   ",
      "    \\'.__\\ .:-:. /__.'/   ",
      "     '---->.___.<----'     ",
      "     .'.-'/.=^=.\\'-.'.     ",
      "    /.'  //     \\\\  `.\\    ",
      "   ||   ||       ||   ||   ",
      "    \\)  ||       ||  (/    ",
      "        \\)       (/        ",
      "                           ",
      " There is no place like ~/ ",
      -- "            ,--'\\                         ",
      -- "         .-/__ / \\.-\\           .--.     ",
      -- "         \\/      / _/    .-''-./  .'\\    ",
      -- "         (\\__.-')   \\    | /-'|.'-   \\  ",
      -- "         \\/  \\--'    |  _/|   |      |   ",
      -- "          /.. /  .-'  |-'  /   |      |    ",
      -- "         \\__/  /     /   |            \\  ",
      -- "         \\__/-''    .   .'   ' \\       \\",
      -- "           |.'\\-        /   .           \\",
      -- "          /, - /    \\_.'                | ",
      -- "          |\\/-'                      |  | ",
      -- "          |            /             /   \\",
      -- "         .|           |             /     |",
      -- "        / |               ______.--'   __.'",
      -- "       |   \\ __/    /---''    `-.---'-'   ",
      -- "       \\__/ /      /                      ",
      -- "            `-____-'                       ",

      -- "                                   ",
      -- "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
      -- "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
      -- "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
      -- "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀ ⠢⣀⡀⠈⠙⠿⠄    ",
      -- "          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
      -- "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
      -- "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
      -- " ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
      -- " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
      -- "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
      -- "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
      -- "                                   ",
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


-- -- Credits to original https://github.com/sainnhe/everforest
-- -- This is modified version of it
--
-- local M = {}
--
-- M.base_30 = {
--   white =      "#ECEFF4",
-- darker_black = "#191C24",
--   black   =    "#240417", --  nvim bg
--   black2  =    "#2E3440",
--   one_bg  =    "#3B4252",
--   one_bg2 =    "#434C5E",
--   one_bg3 =    "#4C566A",
--   grey =       "#60728A",
--   grey_fg =    "#BBC3D4",
--   grey_fg2 =   "#D8DEE9",
--   light_grey = "#E5E9F0",
--   red =        "#BF616A",
--   baby_pink =  "#D06F79",
--   pink =       "#A54E56",
--   line =       "#3a4248", -- for lines like vertsplit
--   green =      "#A3BE8C",
-- vibrant_green= "#B1D196",
--   nord_blue =  "#8FBCBB",
--   blue =       "#93CCDC",
--   yellow =     "#EBCB8B",
--   sun =        "#F0D399",
--   purple =     "#C895BF",
--   dark_purple ="#9D7495",
--   teal =       "#8AA872",
--   orange =     "#D89079",
--   cyan =       "#93CCDC",
-- statusline_bg ="#2e363c",
--   lightbg =    "#3d454b",
--   pmenu_bg =   "#83c092",
--   folder_bg =  "#7393b3",
-- }
--
-- M.base_16 = {
--   base00 = "#242933",
--   base01 = "#2E3440",
--   base02 = "#3B4252",
--   base03 = "#434C5E",
--   base04 = "#4C566A",
--   base05 = "#D8DEE9",
--   base06 = "#E5E9F0",
--   base07 = "#ECEFF4",
--   base08 = "#88C0D0",
--   base09 = "#D06F79",
--   base0A = "#B1D196",
--   base0B = "#F0D399",
--   base0C = "#D89079",
--   base0D = "#A3BE8C",
--   base0E = "#D06F70",
--   base0F = "#C895BF",
-- }
--
-- M.type = "dark"
--
-- M.polish_hl = {
--   ["@tag"] = { fg = M.base_30.orange },
--   ["@tag.delimiter"] = { fg = M.base_30.green },
-- }
--
-- M = require("base46").override_theme(M, "everforest")
--
-- return M

