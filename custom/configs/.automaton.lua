-- This file is going to get deprecated soon
-- And replaced with Overseer.nvim

M = {}

M.opts = {
  debug = false,
  saveall = true,
  ignore_ft = {},

  terminal = {
    position = "botright",
    size = 10,
  },

  integrations = {
    luasnip = false,
    cmp = false,
  },

  icons = {
    buffer = "",
    close = "",
    launch = "",
    task = "",
    workspace = "",
  },

  events = {
    workspacechanged = function(ws)
      -- "ws" is the current workspace object (can be nil)
    end,
  },
}

M.keys = {
  { "<F5>", "<CMD>Automaton launch default<CR>", mode = "n", desc = "Exec Default Launcher" },
  { "<F6>", "<CMD>Automaton debug default<CR>", mode = "n", desc = "Debug Default Launcher" },
  { "<F8>", "<CMD>Automaton tasks default<CR>", mode = "n", desc = "Exec Default Task" },

  { "<leader>iC", "<CMD>Automaton create<CR>", mode = "n", desc = "Create New Workspace" },
  { "<leader>iI", "<CMD>Automaton init<CR>", mode = "n", desc = "Init Workspace" },
  { "<leader>iL", "<CMD>Automaton load<CR>", mode = "n", desc = "Load CWD Workspace" },

  { "<leader>ic", "<CMD>Automaton config<CR>", mode = "n", desc = "Edit Workspace Settings" },
  { "<leader>ir", "<CMD>Automaton recents<CR>", mode = "n", desc = "Recent Workspaces" },
  { "<leader>iw", "<CMD>Automaton workspaces<CR>", mode = "n", desc = "Manage Loaded Workspaces" },
  { "<leader>ij", "<CMD>Automaton jobs<CR>", mode = "n", desc = "Manage Running Tasks" },
  { "<leader>il", "<CMD>Automaton launch<CR>", mode = "n", desc = "Exec Launcher" },
  { "<leader>id", "<CMD>Automaton debug<CR>", mode = "n", desc = "Debug Launcher" },
  { "<leader>it", "<CMD>Automaton tasks<CR>", mode = "n", desc = "Exec Task" },

  { "<leader>iol", "<CMD>Automaton open launch<CR>", mode = "n", desc = "Open launch.json" },
  { "<leader>iov", "<CMD>Automaton open variables<CR>", mode = "n", desc = "Open tasks.json" },
  { "<leader>iot", "<CMD>Automaton open tasks<CR>", mode = "n", desc = "Open variables.json" },
  { "<leader>ioc", "<CMD>Automaton open config<CR>", mode = "n", desc = "Open config.json" },

  -- -- Visual Mode
  -- { "<F5>", "<CMD><C-U>Automaton launch default<CR>", mode = "v", desc = "Exec Default Launcher" },
  -- { "<F6>", "<CMD><C-U>Automaton debug default<CR>", mode = "v", desc = "Debug Default Launcher" },
  -- { "<F8>", "<CMD><C-U>Automaton tasks default<CR>", mode = "v", desc = "Exec Default Task" },
  -- { "<leader>il", "<CMD><C-U>Automaton launch<CR>", mode = "v", desc = "" },
  -- { "<leader>id", "<CMD><C-U>Automaton debug<CR>", mode = "v", desc = "" },
  -- { "<leader>it", "<CMD><C-U>Automaton tasks<CR>", mode = "v", desc = "" },
}

return M

-- :Automaton create         -- Create a new workspace
--            recents        -- Shows recent workspaces
--            init           -- Initializes a workspace in "cwd"
--            load           -- Loads a workspace in "cwd"
--            workspaces     -- Manage loaded workspaces
--            jobs           -- Shows running tasks/launch (can be killed too)
--            config         -- Show/Edit workspace settings
--            tasks default  -- Exec default task
--            tasks          -- Select and exec task
--            launch default -- Exec default launch configuration
--            launch         -- Select and exec a launch configuration
--            debug default  -- Debug default launch configuration
--            debug          -- Select and debug a launch configuration
--            open launch    -- Open workspace's launch.json
--            open tasks     -- Open workspace's tasks.json
--            open variables -- Open workspace's variables.json
--            open config    -- Open workspace's config.json
