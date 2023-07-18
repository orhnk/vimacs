local pallete = {
  Color0  = "#FF5555",
  Color1  = "#7F848E",
  Color2  = "#BD93F9",
  Color3  = "#20E3B2",
  Color4  = "#FF79C6",
  Color5  = "#8BE9FD",
  Color6  = "#F1FA8C",
  Color7  = "#F8F8F2",
  Color8  = "#FFB86C",
  Color9  = "#FF6BCB",
  Color10 = "#9A86FD",
  Color11 = "#2CCCFF",
  Color12 = "#000000",
  Color13 = "#F8F8F2",
  Color14 = "#000000",
  Color15 = "#1B312E",
  Color16 = "#5D2932",
  Color17 = "#44475A",
  Color18 = "#6272A4",
  Color19 = "#000000", --  nvim bg
}
--
--
local M = {}

M.base_30 = {
  white = "#FFFFFF",
  darker_black = "#000000", --  nvim bg
  black = "#000000", --  nvim bg
  black2 = "#000000", --  nvim bg
  one_bg = "#000000", -- real bg of onedark
  one_bg2 = "#191919",
  one_bg3 = "#33301A",
  grey = "#908F8F",
  grey_fg = "#838383",
  grey_fg2 = "#666666",
  light_grey = "#B3BCB6",
  red = "#FF0029",
  baby_pink = "#FF0072",
  pink = "#FF00D6",
  line = "#0002ff", -- for lines like vertsplit
  green = "#61ff00",
  vibrant_green = "#00FF4F",
  nord_blue = "#00D0FF",
  blue = "#00D0FF",
  yellow = "#BE00FF",
  sun = "#EBFF00",
  purple = "#00FF02",
  dark_purple = "#BD93F9",
  teal = "#92A2D4",
  orange = "#FFB86C",
  cyan = "#2CCCFF",
  statusline_bg = "#000000", --  nvim bg
  lightbg = "#000000", --  nvim bg
  pmenu_bg = "#6600FF",
  folder_bg = "#BD93F9",
}

M.base_16 = {
  base00 = "#000000", --  nvim bg
  base01 = "#3A3C4E",
  base02 = "#4D4F68",
  base03 = "#626483",
  base04 = "#62D6E8",
  base05 = "#E9E9F4",
  base06 = "#F1F2F8",
  base07 = "#F7F7FB",
  base08 = "#C197FD",
  base09 = "#FFB86C",
  base0A = "#62D6E8",
  base0B = "#EBFF00",
  base0C = "#00FF3B",
  base0D = "#20E3B2",
  base0E = "#FF6BCB",
  base0F = "#F8F8F2",
}

M.polish_hl = {
  ["@function.builtin"] = { fg = M.base_30.cyan },
  ["@number"] = { fg = M.base_30.purple },
  ["@variable"] = { fg = M.base_30.purple },
  ["@namespace"] = { fg = M.base_30.white },
  ["@function.call"] = { fg = M.base_30.vibrant_green },
  ["@function"] = { fg = M.base_30.green },
  ["@repeat"] = { fg = M.base_30.green },
  -- Overrides
  Include = { fg = M.base_30.pink },
  Error = { fg = pallete.Color0 },
  Comment = { fg = pallete.Color1 },
  Identifier = { fg = pallete.Color7 },
  Function = { fg = pallete.Color3 },
  String = { fg = pallete.Color8 },
  Keyword = { fg = pallete.Color9 },
  Constant = { fg = pallete.Color10 },
  Type = { fg = pallete.Color11 },
  DiffAdd = { fg = pallete.Color15 },
  DiffDelete = { fg = pallete.Color16 },
  ColorColumn = { fg = pallete.Color17 },
  SignColumn = { fg = pallete.Color14 },
  LineNr = { fg = pallete.Color18 },
  NvimTreeFolderIcon = { fg = pallete.Color1 },
  NvimTreeFolderName = { fg = pallete.Color13 },
  NvimTreeOpenedFolderName = { fg = pallete.Color13, bold = true },
  FoldColumn = { fg = pallete.Color13 },
  StatusLine = { fg = pallete.Color13, bg = pallete.Color14 },
  St_cwd = { fg = "white" },
  TSPunctDelimiter = { fg = pallete.Color13 },
}

M.type = "dark"

return M
