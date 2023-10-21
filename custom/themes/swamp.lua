-- Credits to original https://github.com/morhetz/gruvbox
-- Customised to swamp.nvim by masroof-maindak.

local M = {}

M.base_30 = {
  white = "#ebe0bb",
  darker_black = "#211d13",
  black = "#272316", --  nvim bg
  black2 = "#3a3124",
  one_bg = "#4d3f32",
  one_bg2 = "#4d3f32",
  one_bg3 = "#5f4e41",
  grey = "#725c4f",
  grey_fg = "#856a5d",
  grey_fg2 = "#856a5d",
  light_grey = "#9f8875",

  statusline_bg = "#3a3124",
  lightbg = "#4d3f32",

  red           = "#ec6b64",
  baby_pink     = "#ce8196",
  pink          = "#ff75a0",
  line          = "#323536", -- for lines like vertsplit
  green         = "#89b482",
  vibrant_green = "#a9b665",
  nord_blue     = "#6f8faf",
  blue          = "#6d8dad",
  yellow        = "#d6b676",
  sun           = "#d1b171",
  purple        = "#9385b4",
  dark_purple   = "#887aa9",
  teal          = "#749689",
  orange        = "#e78a4e",
  cyan          = "#82b3a8",
  pmenu_bg      = "#89b482",
  folder_bg     = "#6d8dad",
}

M.base_16 = {
  base00 = "#272316",
  base01 = "#3A3124",
  base02 = "#4d3f32",
  base03 = "#5f4e41",
  base04 = "#B8A58C",
  base05 = "#D2C3A4",
  base06 = "#ebe0bb",
  base07 = "#F1E9D0",
  base08 = "#ec6b64",
  base09 = "#e78a4e",
  base0A = "#e0c080",
  base0B = "#a9b665",
  base0C = "#86b17f",
  base0D = "#7daea3",
  base0E = "#d3869b",
  base0F = "#d65d0e",
}

M.type = "dark"

M = require("base46").override_theme(M, "swamp")

M.polish_hl = {
  Operator = {
    fg = M.base_30.nord_blue,
  },

  ["@operator"] = {
    fg = M.base_30.nord_blue,
  },
}

return M
