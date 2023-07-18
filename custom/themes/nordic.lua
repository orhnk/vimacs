-- Credits to original https://github.com/arcticicestudio/nord-vim
-- This is modified version of it

local M = {}

M.base_30 = {
  white = "#D8DEE9",
  darker_black = "#100C10",
  black = "#191C24", --  nvim bg
  black2 = "#2a303c",
  one_bg = "#2E3440",
  one_bg2 = "#3B4252",
  one_bg3 = "#434C5E",
  grey = "#4C566A",
  grey_fg = "#545a66",
  grey_fg2 = "#595f6b",
  light_grey = "#606672",
  red = "#BF616A",
  baby_pink = "#D06F79",
  pink = "#A54E56",
  line = "#414753", -- for lines like vertsplit
  green = "#8AA872",
  vibrant_green = "#B1D196",
  blue = "#69A7BA",
  nord_blue = "#81A1C1",
  yellow = "#D9B263",
  sun = "#F0D399",
  purple = "#C895BF",
  dark_purple = "#9D7495",
  teal = "#8FBCBB",
  orange = "#D89079",
  cyan = "#93CCDC",
  statusline_bg = "#333945",
  lightbg = "#3f4551",
  pmenu_bg = "#A3BE8C",
  folder_bg = "#7797b7",
}

M.base_16 = {
  base00 = "#2a303c",
  base01 = "#2E3440",
  base02 = "#3B4252",
  base03 = "#434C5E",
  base04 = "#4C566A",
  base05 = "#B1D196",
  base06 = "#c7cdd8",
  base07 = "#ced4df",
  base08 = "#EBCB8B",
  base09 = "#81A1C1",
  base0A = "#D06F79", --#d57780
  base0B = "#F0D399",
  base0C = "#97b7d7",
  base0D = "#B48EAD",
  base0E = "#D89079",
  base0F = "#D06F79",
}

--
-- -- The Nord palette: https://www.nordtheme.com/.
-- -- This file has a bunch of added colors.
-- -- Some of the colors are from @nightfox.nvim.
--
-- local O = require('nordic.config').options
--
-- local palette = {
--
--     none = 'NONE',
--
--     -- Darker colors.
--     -- Not in base Nord.
--     black = '#191C24',
--     -- This color is actually used on their website's dark theme.
--     gray0 = '#242933',
--
--     -- Polar Night.
--     gray1 = '#2E3440',
--     gray2 = '#3B4252',
--     gray3 = '#434C5E',
--     gray4 = '#4C566A',
--
--     -- A light blue/gray.
--     -- From @nightfox.nvim.
--     gray5 = '#60728A',
--
--     -- Dim white.
--     white0 = '#BBC3D4',
--
--     -- Snow storm.
--     white1 = '#D8DEE9',
--     white2 = '#E5E9F0',
--     white3 = '#ECEFF4',
--
--     -- Frost.
--     -- Bright & dim @nightfox.nvim.
--     blue0 = '#5E81AC',
--     blue1 = '#81A1C1',
--     blue2 = '#88C0D0',
--     blue = {
--         bright = '#8CAFD2',
--         dim = '#668AAB',
--     },
--     cyan = {
--         base = '#8FBCBB',
--         bright = '#93CCDC',
--         dim = '#69A7BA',
--     },
--
--     -- Aurora.
--     -- These colors are used a lot, so we need variations for them.
--     -- Base colors are from original Nord palette.
--     -- Bright & dim from @nightfox.nvim.
--     red = {
--         base =   '#BF616A',
--         bright = '#D06F79',
--         dim =    '#A54E56',
--     },
--     orange = {
--         base = '#D08770',
--         bright = '#D89079',
--         dim = '#B46950',
--     },
--     yellow = {
--         base =  '#EBCB8B',
--         bright ='#F0D399',
--         dim =   '#D9B263',
--     },
--     green = {
--         base =   '#A3BE8C',
--         bright = '#B1D196',
--         dim =    '#8AA872',
--     },
--     magenta = {
--         base =   '#B48EAD',
--         bright = '#C895BF',
--         dim =    '#9D7495',
--     },
-- }
--

M.type = "dark"

M = require("base46").override_theme(M, "nordic")

return M
