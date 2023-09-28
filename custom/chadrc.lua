---@type ChadrcConfig
local M = {}

local round = { left = "", right = "" }
local block = { left = "█", right = "█" }
local arrow = { left = "", right = "" }
local angle = { left = "", right = "" }
local slant = { left = "", right = "" }
local group_margin = "  "

local status = require("custom.utils").status

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "darcula",
  theme_toggle = { "darcula", "darcula" },

  cmp = {
    style = "default", -- flatt_dark | flat_light | default | atom | atom_colored
    selected_item_bg = "colored",
  },

  -- transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    -- theme = "vscode_colored", -- default/vscode/*vscode_colored*/minimal
    -- separator_style = "round", -- default/*round*/*block*/arrow
    -- modules arg here is the default table of modules
    overriden_modules = function(modules)


      table.insert( -- Right
        modules,
        3,
        (function()
          local hl = "%#StEncoding#"
          local encoding = vim.bo.fileencoding or vim.bo.encoding
          return hl .. encoding .. "  "
        end)()
      )

      -------------------------------------------------------
      --                    ICONS START                    --
      -------------------------------------------------------
      -- table.insert(
      --   modules,
      --   8,
      --   (function()
      --     local hl = "%#StGroup#"
      --     return hl .. round.right
      --   end)()
      -- )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StBg#"
          return hl .. " "
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StKernel#"
          local icon = "" --                               
          return hl .. icon--[[  .. " " ]]
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StDebug#"
          local icon = ""
          if status.debug then
            icon = hl .. "󱇪" .. group_margin
          end
          return icon
        end)()
      )

      -- -- If in ~/
      -- table.insert(
      --   modules,
      --   8,
      --   (function()
      --     local hl = "%#StHome#"
      --     local icon = ""
      --     local cwd = vim.fn.getcwd()
      --     local homedir = vim.loop.os_homedir()
      --     if cwd == homedir then
      --       icon = hl .. "󰋜" .. group_margin
      --     end
      --     return icon
      --   end)()
      -- )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StWorld#"
          local icon = "" -- 󰅏
          if status.worldmap then
            icon = hl .. "󰇧" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StReddit#"
          local icon = ""
          if status.reddit then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StGames#"
          local icon = ""
          if status.games then
            icon = hl .. "󰊗" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StHN#"
          local icon = ""
          if status.hn then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StWhatsapp#"
          local icon = ""
          if status.whatsapp then
            icon = hl .. "󰖣" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StStackOverflow#"
          local icon = ""
          if status.stackoverflow then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StDiscord#"
          local icon = ""
          if status.discord then
            icon = hl .. "󰙯" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StIRC#"
          local icon = ""
          if status.irc then
            icon = hl .. "󰻞" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StGit#"
          local icon = ""
          if status.git then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StMail#"
          local icon = "" -- 󰛮
          if status.mail then
            icon = hl .. "󰶌" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StBrowser#"
          local icon = ""
          if status.browser then
            icon = hl .. "󰖟" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StGithub#"
          local icon = ""
          if status.github then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StTranslate#"
          local icon = ""
          if status.translate then
            icon = hl .. "" .. group_margin
          end
          return icon
        end)()
      )

      table.insert(
        modules,
        8,
        (function()
          local hl = "%#StCody#"
          local icon = "" -- 

          if status.cody then
            icon = hl .. "󱜙" .. group_margin
          end

          return icon
        end)()
      )

      table.insert( -- Right
        modules,
        8,
        (function()
          local icon = ""
          local hl = "%#StCopilot#"

          if status.copilot == true then
            icon = hl .. "" .. group_margin --   |  
            -- else
            --   icon = " " .. ""
          end

          return icon
        end)()
      )

      -- table.insert(
      --   modules,
      --   8,
      --   (function()
      --     local hl = "%#StBg#"
      --     return hl .. " "
      --   end)()
      -- )

      -- table.insert(
      --   modules,
      --   8,
      --   (function()
      --     local hl = "%#StGroup#"
      --     return hl .. round.left
      --   end)()
      -- )
    end,

    -----------------------------------------------------
    --                    ICONS END                    --
    -----------------------------------------------------
  },

  nvdash = {
    load_on_startup = true,
    header = {

      -- Useful: https://emojicombos.com/

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
      -- "⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢦⠙⢿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⢯⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⠛⢿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⢧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡕⠂⠈⢻⣿⣿⣿⣿",
      -- "⣿⣿⡅⣻⡿⢿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠿⢿⣿⡇⠀⠀⠈⣿⣿⣿⣿",
      -- "⣿⣿⠀⠀⠀⠘⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⣹⣿⣿⣿",
      -- "⣿⣿⠀⠀⠀⠀⣿⣿⡿⠿⠛⠻⣿⣿⣿⣿⡿⠟⠁⠈⠀⠉⠻⡆⠀⠀⠀⣿⣿⣿",
      -- "⣿⣯⠄⠂⠀⠀⣿⡋⠀⢀⠀⠀⠀⠉⣿⣿⡀⠀⠀⠘⠓⣠⣶⣿⡀⠀⠀⠘⣿⣿",
      -- "⣿⣫⡆⠀⠀⢀⣿⣷⣶⣄⠀⢀⣤⣴⣿⣿⣿⣶⣄⠀⣴⣿⣿⣿⠁⠀⠀⠀⠘⣿",
      -- "⣿⣿⠁⠀⠀⡤⠙⢿⣿⣿⣷⣾⣿⡿⣿⣿⢿⠿⣿⣧⣿⣿⡿⢣⠀⠀⠀⠀⢠⣿",
      -- "⣷⣌⠈⠀⠀⠀⠀⣆⠈⡉⢹⣿⣿⣆⡀⠀⠀⢠⣿⣿⣿⡿⢃⣼⠀⠀⠀⠀⣸⣿",
      -- "⣿⣿⡇⠀⠀⠀⠀⠙⢿⣿⣆⠈⠛⠛⠛⠀⠀⠈⠉⠁⠀⢠⣿⠇⠀⠀⠀⠹⢿⡇",
      -- "⣿⡫⠀⠀⠁⠀⠀⠀⠈⠻⣿⢢⣄⠀⠀⠀⠀⠀⣀⣠⣾⡾⠋⠀⠀⠀⠀⢀⠴⠋",
      -- "⣿⣁⠄⠀⠀⠀⣀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⠿⡿⠋⠀⠀⠀⠀⠀⣀⠬⠆⢀",
      -- "⣿⣿⣧⣄⠀⠀⠉⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠠⠙",

      -- "⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠊⠉⠉⢉⠏⠻⣍⠑⢲⠢⠤⣄⣀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⣻⣿⢟⣽⠿⠯⠛⡸⢹⠀⢹⠒⣊⡡⠜⠓⠢⣄⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⢀⡜⣿⣷⣽⠓⠀⢠⢂⣣⠋⠂⣾⠼⢌⠳⢄⢀⡠⠜⣣⡀⠀⠀",
      -- "⠀⠀⠀⠀⠀⢠⢻⢱⣭⠷⠤⢅⠴⣡⡻⠃⠀⢠⠁⠀⢀⡱⠜⠍⢔⠊⠀⠹⡄⠀",
      -- "⠀⠀⠀⠀⢀⣷⠌⠚⠷⠆⠠⠶⠭⢒⣁⠀⣤⠃⣀⢔⢋⡤⠊⠑⣄⠳⣄⠀⣧⠀",
      -- "⠀⠀⠀⠀⠀⠑⠦⣀⡤⣄⠄⢄⣀⣠⣒⢦⡄⠩⠷⠦⠊⠀⠀⠀⠈⠣⡏⠢⣿⠀",
      -- "⠀⠀⠀⠀⠀⠀⣸⢫⠟⣝⠞⣼⢲⡞⣞⠋⠋⠉⠋⠓⡄⠀⠀⠀⠀⠀⣨⠂⢸⡅",
      -- "⠀⠀⠀⠀⠀⣰⠃⡨⠊⢀⡠⡌⢘⢇⠞⠀⠀⠀⠀⠂⠡⡄⠀⠀⢀⠞⢁⠔⢹⡇",
      -- "⠀⠀⠀⠀⣰⣣⠞⢀⠔⢡⢢⠇⡘⠌⠀⠀⠀⠀⠀⠀⠠⡌⠢⡔⢁⡴⠁⠀⢸⠃",
      -- "⠀⠀⠀⢠⠟⠁⠠⢊⠔⣡⢸⠀⠃⠁⠀⠀⠀⠀⠀⠀⠀⣯⠂⡀⢪⡀⠀⠀⢸⠀",
      -- "⠀⢀⠔⣁⠐⠨⠀⠀⠈⠀⢄⠘⡀⠀⠈⢆⠀⠀⠀⠀⡠⢁⠜⠙⢦⠙⣦⠀⢸⠀",
      -- "⡴⠁⠘⡁⣀⡡⠀⠀⠴⠒⠗⠋⠉⠉⡆⠀⠆⠄⠄⠘⠀⡎⠀⠀⠀⠑⢅⠑⢼⡀",
      -- "⢯⣉⣓⠒⠒⠤⠤⣄⣀⣀⣀⣀⡀⠐⠁⠀⠀⠀⠒⠀⢀⡀⠀⠀⠀⠀⠀⠑⣌⣇",
      -- "⠀⠈⢳⠄⠈⠀⠤⢄⣀⠀⢈⣉⡹⠯⡟⠁⠀⠀⠀⠀⢸⠀⠀⠂⠀⠀⡠⠚⣡⡿",
      -- "⠀⢠⣋⣀⣀⣀⣀⠤⠭⢛⡩⠄⠒⠩⠂⢀⠄⠀⠀⠀⠈⢢⡀⠀⡠⠋⡩⠋⠀⢳",
      -- "⠀⢹⠤⠬⠤⠬⠭⣉⣉⢃⠀⠀⣀⣀⠀⠁⠀⠀⠀⠀⡞⢺⡈⠋⡢⠊⠀⠀⠀⢸",
      -- "⠀⠈⡆⠁⢀⠀⠀⠀⠉⠋⠉⠓⠂⠤⣀⡀⠀⠀⠀⠀⡧⠊⡠⠦⡈⠳⢄⠀⠀⠈",
      -- "⠀⠀⢹⡜⠀⠁⠀⠀⠒⢤⡄⠤⠔⠶⠒⠛⠧⠀⠀⡼⡠⠊⠀⠀⠙⢦⡈⠳⡄⠀",
      -- "⠀⠀⢸⠆⠀⠈⠀⠠⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⡜⢸⠀⠀⠀⠀⠀⠀⠑⢄⠈⢲",
      -- "⠀⠀⢸⢀⠇⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⡄⠊⢠⠃⠀⠀⠀⠀⠀⠀⠀⠈⡢⣸",
      -- "⠀⠀⠈⠳⣤⣄⡀⠀⠀⠀⠈⠉⠉⠁⠒⠁⠀⠠⣏⠀⠀⠀⠀⠀⠀⢀⣔⠾⡿⠃",
      -- "⠀⠀⠀⠀⠀⠉⠙⠛⠒⠤⠤⣤⣄⣀⣀⣀⣔⣢⣀⣉⣂⣀⣀⣠⠴⠿⠛⠋⠀ ",

      -- "⠀⠀⢀⣤⣶⣶⣤⣄⡀                               ",
      -- "⠀⢀⣿⣿⣿⣿⣿⣿⣿⡆                              ",
      -- "⠀⠸⣿⣿⣿⣿⣿⡟⡟⡗ ⣿⠉⣿⠉⣿⡏⠹⡏⢹⡏⢹⣿⣿⠉⣿⠉⣿⡟⢋⠛⣿⠉⡟⢉⡏⠹⠏⣹⣿",
      -- "⠀⠀⠙⠏⠯⠛⣉⢲⣧⠟ ⣿⠄⣿⠄⣿⡇⡄⠁⢸⡇⢸⣿⣿⠄⣿⠄⣿⠄⣿⣿⣿⠄⡀⢻⣿⡄⢠⣿⣿",
      -- "⠀⠀⠠⢭⣝⣾⠿⣴⣿⠇ ⣿⣦⣤⣴⣿⣧⣿⣤⣼⣧⣬⣭⣿⣦⣤⣴⣿⣧⣤⣤⣿⣤⣷⣤⣿⣧⣼⣿⣿",
      -- "⠀⠀⢐⣺⡿⠁⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀                      ",
      -- "⠀⠀⣚⣿⠃                                   ",
      -- "⢀⣿⣿⣿⣷⢒⣢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣶⣶⣄⠄                ",
      -- "⢰⣿⣿⡿⣿⣦⠬⢝⡄⠀⠀⠀⠀⠀⠀⢠⣿⠿⠿⠟⠛⠋⠁                 ",
      -- "⠠⢿⣿⣷⠺⣿⣗⠒⠜⡄⠀⠀⠀⠀⣴⠟⠁                       ",
      -- "⠀⣰⣿⣷⣍⡛⣯⣯⣙⡁⠀⠀⣠⡾⠁                         ",
      -- "⠀⠨⢽⣿⣷⢍⣛⣶⢷⣼⣠⣾⠋                           ",
      -- "⠀⠀⠘⢿⣿⣖⠬⣹⣶⣿⠟⠁                            ",
      -- "⠀⠀⠀⠚⠿⠿⡒⠨⠛⠋                              ",
      -- "⠀⠀⠀⠐⢒⣛⣷                                 ",
      -- "⠀⠀⠀⢘⣻⣭⣭                                 ",
      -- "⠀⠀⠀⡰⢚⣺⣿                                 ",
      -- "⠀⠀⢠⣿⣿⣿⣿⣦⡄                               ",
      -- "⠀⠀⢸⡿⢿⣿⢿⡿⠃                               ",
      -- "⠀⠀⠘⡇⣸⣿⣿⣿⣆                               ",
      -- "⠀⠀⠀⠀⠸⣿⡿⠉⠁                               ",
      -- "⠀⠀⠀⠀⠀⢿⡟                                 ",

      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⢀⣴⠟⠉⠀⠀⠀⠈⠻⣦⡀⠀⠀⠀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣀⢀⣾⠿⠻⢶⣄⠀⠀⣠⣶⡿⠶⣄⣠⣾⣿⠗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⢻⣿⣿⡿⣿⠿⣿⡿⢼⣿⣿⡿⣿⣎⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡟⠉⠛⢛⣛⡉⠀⠀⠙⠛⠻⠛⠑⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣧⣤⣴⠿⠿⣷⣤⡤⠴⠖⠳⣄⣀⣹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣀⣟⠻⢦⣀⡀⠀⠀⠀⠀⣀⡈⠻⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡿⠉⡇⠀⠀⠛⠛⠛⠋⠉⠉⠀⠀⠀⠹⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡟⠀⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠈⠑⠪⠷⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣦⣼⠛⢦⣤⣄⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠢⡀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠲⠖⠛⠻⣿⡿⠛⠉⠉⠻⠷⣦⣽⠿⠿⠒⠚⠋⠉⠁⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⢀⣾⠛⠁⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⠀⠀⠀",
      -- "⠀⠀⠀⠀⣰⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇⠀⠀",
      -- "⠀⠀⠀⣰⣿⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣧⣄⠀⠀⠀⠀⠀⠀⢳⡀⠀",
      -- "⠀⠀⠀⣿⡾⢿⣀⢀⣀⣦⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⣫⣿⡿⠟⠻⠶⠀⠀⠀⠀⠀⢳⠀",
      -- "⠀⠀⢀⣿⣧⡾⣿⣿⣿⣿⣿⡷⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢿⣿⣧⠀⡀⠀⢀⣀⣀⢒⣤⣶⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇",
      -- "⠀⠀⡾⠁⠙⣿⡈⠉⠙⣿⣿⣷⣬⡛⢿⣶⣶⣴⣶⣶⣶⣤⣤⠤⠾⣿⣿⣿⡿⠿⣿⠿⢿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇",
      -- "⠀⣸⠃⠀⠀⢸⠃⠀⠀⢸⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⠟⡉⠀⠀⠀⠈⠙⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇",
      -- "⠀⣿⠀⠀⢀⡏⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠉⠠⠿⠟⠻⠟⠋⠉⢿⣿⣦⡀⢰⡀⠀⠀⠀⠀⠀⠀⠁",
      -- "⢀⣿⡆⢀⡾⠀⠀⠀⠀⣾⠏⢿⣿⣿⣿⣯⣙⢷⡄⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣿⣻⢿⣷⣀⣷⣄⠀⠀⠀⠀⢸⠀",
      -- "⢸⠃⠠⣼⠃⠀⠀⣠⣾⡟⠀⠈⢿⣿⡿⠿⣿⣿⡿⠿⠿⠿⠷⣄⠈⠿⠛⠻⠶⢶⣄⣀⣀⡠⠈⢛⡿⠃⠈⢿⣿⣿⡿⠀⠀⠀⠀⠀⡀",
      -- "⠟⠀⠀⢻⣶⣶⣾⣿⡟⠁⠀⠀⢸⣿⢅⠀⠈⣿⡇⠀⠀⠀⠀⠀⣷⠂⠀⠀⠀⠀⠐⠋⠉⠉⠀⢸⠁⠀⠀⠀⢻⣿⠛⠀⠀⠀⠀⢀⠇",
      -- "⠀⠀⠀⠀⠹⣿⣿⠋⠀⠀⠀⠀⢸⣧⠀⠰⡀⢸⣷⣤⣤⡄⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡆⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⢼⡇",
      -- "⠀⠀⠀⠀⠀⠙⢻⠄⠀⠀⠀⠀⣿⠉⠀⠀⠈⠓⢯⡉⠉⠉⢱⣶⠏⠙⠛⠚⠁⠀⠀⠀⠀⠀⣼⠇⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⡇",
      -- "⠀⠀⠀⠀⠀⠀⠻⠄⠀⠀⠀⢀⣿⠀⢠⡄⠀⠀⠀⣁⠁⡀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⢀⣐⡟⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⢠⡇",

      -- "⠀⢀⣀⣀⣀⣀⣠⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⣿⣿⣿⣏⠉⠈⣿⣿⣿⢦⣀⠀⠀⠀⠀⠀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⢿⠋⠻⣿⣷⣄⡙⠛⠋⠀⠈⠹⣷⠚⠛⣟⠽⣯⠝⠋⠙⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠉⠉⠙⢿⠲⠤⣼⡿⡆⠀⢢⠀⠉⠲⠏⠀⠀⠀⣇⢻⠙⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⢸⡇⢀⡼⠁⠀⠀⢸⠟⠉⠉⠛⢦⠀⠀⢿⡼⠿⡚⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⢀⣠⣶⡶⠿⢿⡿⣿⠟⢁⣀⣠⠔⠋⠀⠀⠀⠀⠈⡇⠀⠀⠀⠀⠉⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⢀⣾⡞⠁⢀⣴⡯⠞⣡⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⣠⠄⣸⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠈⠙⠀⠀⢿⣤⠤⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠃⢰⡖⠒⢤⣧⣤⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠖⠋⠀⠀⠈⡧⠀⣏⠁⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠋⠁⠀⠀⠀⠀⠀⠈⠓⢦⣷⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠚⠁⠀⠀⢴⠒⠒⠢⡀⠀⠀⢠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⣠⠶⠋⠀⠀⠀⠀⠀⡼⢀⡶⠆⢳⣤⠔⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠸⡀⠹⣀⣸⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⡶⠛⠁⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠒⢿⡉⠛⢍⠛⠒⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⢰⠃⠀⠀⠀⠀⢠⡤⢤⣀⣠⠎⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢯⡀⠀⠀⠀⢹⡆⠻⠦⠴⠃⢈⣣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⣼⠀⠀⠀⠀⢀⣼⣀⡖⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⢅⣸⠁⠀⠀⠀⠸⡦⠖⠤⣀⠜⠁⠈⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⡟⠀⠀⠀⠀⡏⠹⡗⢺⢻⡀⠀⠀⠀⠀⠀⠀⠀⣠⠿⠖⣉⣀⣱⠀⣀⡤⠤⢤⣄⠀⠀⠀⢀⣀⣸⠀⠀⠀⠐⠻⣗⠲⣄⠀",
      -- "⠀⠀⠀⠀⣿⠀⠀⠀⠀⠈⠉⠉⢹⠚⢷⣀⠀⠀⠀⠀⣀⡴⠛⠒⠊⠀⠀⣠⠎⠁⠀⠀⠀⠈⢳⡀⠀⣿⣸⡿⠀⠀⠀⠀⠀⠈⣇⠘⡆",
      -- "⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠸⡇⢸⠙⡟⠲⡖⠋⣯⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⡧⣎⣈⣿⠃⠀⠀⠀⠀⠀⠀⣼⣆⢻",
      -- "⠀⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇⢼⡤⠃⡔⠁⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⣯⠀⠀⠀⠀⠀⠀⢠⠷⠼⢺",
      -- "⠀⠀⠀⠀⠀⠈⢳⣄⠀⠀⠀⠀⠀⠀⠐⠖⠚⠒⠞⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⠸⠽⠷⣄⣀⣀⣠⡶⠋⠀⢠⡟",
      -- "⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⢯⡛⡷⠚⠁⢀⡴⠋⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠒⠒⠦⠤⠤⠤⠴⠖⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠒⠲⠿⠷⠒⠛⠉⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",

      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠰⠛⠻⢿⣿⠿⠿⠟⡿⠿⢿⣿⠿⠿⣿⠃⠀⠟⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣴⡄⠀⠘⡇⠀⣤⣤⡇⠀⣼⣿⠀⢠⡏⠀⢠⣦⠀⠀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠛⠃⠀⡼⠀⠀⣿⣿⠀⠀⠛⠃⠀⢸⠁⠀⣼⡏⠀⢠⡟⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣾⣷⣶⣾⣿⣿⣷⣶⣶⣶⣶⣿⣶⣶⣿⣷⣶⣾⣷⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",

      "⠀⠀⠀⠀⣀⣀⣤⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⡄⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⣿⡟⠡⠂⠀⢹⣿⣿⣿⣿⣿⣿⡇⠘⠁⠀⠀⣿⡇⠀⢠⣄⠀⠀⠀⠀",
      "⠀⠀⠀⠀⢸⣗⢴⣶⣷⣷⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣴⣿⣗⣄⣼⣷⣶⡄⠀⠀",
      "⠀⠀⠀⢀⣾⣿⡅⠐⣶⣦⣶⠀⢰⣶⣴⣦⣦⣶⠴⠀⢠⣿⣿⣿⣿⣿⣿⡇⠀⠀",
      "⠀⠀⢀⣾⣿⣿⣷⣬⡛⠷⣿⣿⣿⣿⣿⣿⣿⠿⠿⣠⣿⣿⣿⣿⣿⠿⠛⠀⠀⠀",
      "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣶⣦⣭⣭⣥⣭⣵⣶⣿⣿⣿⣿⡟⠉⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠙⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣛⠛⠛⠛⠛⠛⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠿⣿⣿⣿⠿⠿⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠿⠇⠀  ⠀⠀⠀⠀",
      "                              ",
      "  There is no place like ~/   ",

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
    },

    buttons = {
      {
        "  New Project",
        "Spc n n",
        "ProjectNew"
      },
      {
        "󰁯  Restore Session",
        "Spc q l",
        function()
          require("persistence").load { last = true }
        end,
      },
      {
        "  File Manager",
        "Spc .",
        "Telescope file_browser path=%:p:h select_buffer=true",
        -- FIXME cmd doesn't work with lazy loading!
      },
      {
        "  Find File",
        "Spc f f",
        "Telescope find_files",
      },
      {
        "  Find Project",
        "Spc f p",
        "lua require('telescope').extensions.project.project({display_type = 'full'})",
      },
      {
        "  Find Command",
        "Spc f c",
        "Telescope builtin",
      },
      {
        "󰈚  Recent Files",
        "Spc f r",
        "Telescope oldfiles",
      },
      {
        "󰈭  Find Word",
        "Spc f w",
        "Telescope live_grep",
      },
      {
        "  Bookmarks",
        "Spc m a",
        "Telescope marks",
      },
      {
        "  Themes",
        "Spc h t",
        "Telescope themes",
      },
      {
        "  Config",
        "Spc o c",
        "next ~/.config/nvim/lua/custom/*.lua",
      },
      {
        "  Mappings",
        "Spc c h",
        "NvCheatsheet",
      },
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
