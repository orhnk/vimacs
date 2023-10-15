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

  green = "#ec9f0d",
  red = "#f87c2a",
  nord_blue = "#fbb323",
  blue = "#48b8d0",

  baby_pink = "#b33951",
  pink = "#f76f8e",
  line = "#4d3f32", -- for lines like vertsplit
  vibrant_green = "#acbb4f",
  yellow = "#ec9f0d",
  sun = "#fbb323",
  purple = "#f76f8e",
  dark_purple = "#bc4e78",
  teal = "#65f69c",
  orange = "#f87c2a",
  cyan = "#8bf8b5",
  statusline_bg = "#3a3124",
  lightbg = "#4d3f32",
  pmenu_bg = "#7dccde",
  folder_bg = "#ec9f0d",
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
  base08 = "#cc005c",
  base09 = "#F9883D",
  base0A = "#ec9f0d",
  base0B = "#acbb4f",
  base0C = "#8bf8b5",
  base0D = "#48b8d0",
  base0E = "#bc4e78",
  base0F = "#F87C2A",
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
