local M = {}

M.keys = { -- TODO: p -> Profiling | pl -> Load
  {
    "<leader>plf",
    ":PerfLoadFlat<CR>",
    mode = "n",
    desc = "Load perf.data",
  },

  {
    "<LEADER>plg",
    ":PerfLoadCallGraph<CR>",
    mode = "n",
    desc = "Load Full Call Graph",
  },

  {
    "<LEADER>plo",
    ":PerfLoadFlameGraph<CR>",
    mode = "n",
    desc = "Load perf.log",
  },

  {
    "<LEADER>pe",
    ":PerfPickEvent<CR>", -- switch between cpu cycles, branch mispredictions, and cache misses
    mode = "n",
    desc = "Cycle Profile Mode",
  },

  {
    "<LEADER>pi",
    ":PerfCycleFormat<CR>", -- toggle percentage & absolute counts ( configurable! )
    mode = "n",
    desc = "Cycle Count Mode",
  },

  {
    "<LEADER>pa",
    ":PerfAnnotate<CR>",
    mode = "n",
    desc = "Annotate All Buffers",
  },

  {
    "<LEADER>pf",
    ":PerfAnnotateFunction<CR>",
    mode = "n",
    desc = "Annotate Function",
  },

  {
    "<LEADER>pa",
    ":PerfAnnotateSelection<CR>",
    mode = "v",
    desc = "Anotate Selection",
  },

  {
    "<LEADER>pt",
    ":PerfToggleAnnotations<CR>",
    mode = "n",
    desc = "Toggle All Buffers Annotations",
  },

  {
    "<LEADER>ph",
    ":PerfHottestLines<CR>",
    mode = "n",
    desc = "Hottest Lines",
  },

  {
    "<LEADER>ps",
    ":PerfHottestSymbols<CR>",
    mode = "n",
    desc = "Hottest Symbols",
  },

  {
    "<LEADER>pc",
    ":PerfHottestCallersFunction<CR>",
    mode = "n",
    desc = "Hottest Symbols from Selection",
  },

  {
    "<LEADER>pc",
    ":PerfHottestCallersSelection<CR>",
    mode = "v",
    desc = "Hottest Lines from Selection",
  },

  {
    "<LEADER>pn",
    "<cmd> PerfLuaProfileStart<CR>",
    mode = "n",
    desc = "Start Profiling Lua",
  },

  {
    "<LEADER>pk",
    "<cmd> PerfLuaProfileStop<CR>",
    mode = "n",
    desc = "Stop Profiling Lua",
  },

  --[[
    :PerfCacheSave <name> saves the currently loaded callgraph in the cache under the given name.
    :PerfCacheLoad <name> loads the callgraph in the cache of the given name. Automatically annotates all buffers if annotate_after_load is set. If an empty name is supplied, the most recently cached callgraph is loaded.
    :PerfCacheDelete <name> deletes the callgraph in the cache of the given name.
]]
}

M.opts = {
  -- List of highlights that will be used to highlight hot lines (or nil to disable highlighting)
  -- line_highlights = require("perfanno.util").make_bg_highlights(bgcolor, "#CC3300", 10),
  -- Highlight used for virtual text annotations (or nil to disable virtual text)
  -- vt_highlight = require("perfanno.util").make_fg_highlight("#CC3300"),

  -- Annotation formats that can be cycled between via :PerfCycleFormat
  --   "percent" controls whether percentages or absolute counts should be displayed
  --   "format" is the format string that will be used to display counts / percentages
  --   "minimum" is the minimum value below which lines will not be annotated
  -- Note: this also controls what shows up in the telescope finders
  formats = {
    {
      percent = true,
      format = "%.2f%%",
      minimum = 0.5,
    },
    {
      percent = false,
      format = "%d",
      minimum = 1,
    },
  },

  -- Automatically annotate files after :PerfLoadFlat and :PerfLoadCallGraph
  annotate_after_load = true,
  -- Automatically annotate newly opened buffers if information is available
  annotate_on_open = true,

  -- Options for telescope-based hottest line finders
  telescope = {
    -- Enable if possible, otherwise the plugin will fall back to vim.ui.select
    enabled = pcall(require, "telescope"),
    -- Annotate inside of the preview window
    annotate = true,
  },

  -- Node type patterns used to find the function that surrounds the cursor
  ts_function_patterns = {
    -- These should work for most languages (at least those used with perf)
    default = {
      "function",
      "method",
    },
    -- Otherwise you can add patterns for specific languages like:
    -- weirdlang = {
    --     "weirdfunc",
    -- }
  },
}

return M
