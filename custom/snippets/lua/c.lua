local luasnip = require "luasnip"
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
-- local utils = require "luasnip_snippets.utils"

return {
  c = {
    s("INCLUDE", {
      d(1, function(args, snip)
        -- Create a table of nodes that will go into the header choice_node
        local headers_to_load_into_choice_node = {}

        -- Step 1: get companion .h file if the current file is a .c or .cpp file excluding main.c
        local extension = vim.fn.expand "%:e"
        local is_main = vim.fn.expand("%"):match "main%.cp?p?" ~= nil
        if (extension == "c" or extension == "cpp") and not is_main then
          local matching_h_file = vim.fn.expand("%:t"):gsub("%.c", ".h")
          local companion_header_file = string.format('#include "%s"', matching_h_file)
          table.insert(headers_to_load_into_choice_node, t(companion_header_file))
        end

        -- Step 2: get all the local headers in current directory and below
        local current_file_directory = vim.fn.expand "%:h"
        local local_header_files = require("plenary.scandir").scan_dir(
          current_file_directory,
          { respect_gitignore = true, search_pattern = ".*%.h$" }
        )

        -- Clean up and insert the detected local header files
        for _, local_header_name in ipairs(local_header_files) do
          -- Trim down path to be a true relative path to the current file
          local shortened_header_path = local_header_name:gsub(current_file_directory, "")
          -- Replace '\' with '/'
          shortened_header_path = shortened_header_path:gsub([[\+]], "/")
          -- Remove leading forward slash
          shortened_header_path = shortened_header_path:gsub("^/", "")
          local new_header = t(string.format('#include "%s"', shortened_header_path))
          table.insert(headers_to_load_into_choice_node, new_header)
        end

        -- Step 3: allow for custom insert_nodes for local and system headers
        local custom_insert_nodes = {
          sn(
            nil,
            fmt(
              [[
                         #include "{}"
                         ]],
              {
                i(1, "custom_insert.h"),
              }
            )
          ),
          sn(
            nil,
            fmt(
              [[
                         #include <{}>
                         ]],
              {
                i(1, "custom_system_insert.h"),
              }
            )
          ),
        }
        -- Add the custom insert_nodes for adding custom local (wrapped in "") or system (wrapped in <>) headers
        for _, custom_insert_node in ipairs(custom_insert_nodes) do
          table.insert(headers_to_load_into_choice_node, custom_insert_node)
        end

        -- Step 4: finally last priority is the system headers
        local system_headers = {
          t "#include <assert.h>",
          t "#include <complex.h>",
          t "#include <ctype.h>",
          t "#include <errno.h>",
          t "#include <fenv.h>",
          t "#include <float.h>",
          t "#include <inttypes.h>",
          t "#include <iso646.h>",
          t "#include <limits.h>",
          t "#include <locale.h>",
          t "#include <math.h>",
          t "#include <setjmp.h>",
          t "#include <signal.h>",
          t "#include <stdalign.h>",
          t "#include <stdarg.h>",
          t "#include <stdatomic.h>",
          t "#include <stdbit.h>",
          t "#include <stdbool.h>",
          t "#include <stdckdint.h>",
          t "#include <stddef.h>",
          t "#include <stdint.h>",
          t "#include <stdio.h>",
          t "#include <stdlib.h>",
          t "#include <stdnoreturn.h>",
          t "#include <string.h>",
          t "#include <tgmath.h>",
          t "#include <threads.h>",
          t "#include <time.h>",
          t "#include <uchar.h>",
          t "#include <wchar.h>",
          t "#include <wctype.h>",
        }
        for _, header_snippet in ipairs(system_headers) do
          table.insert(headers_to_load_into_choice_node, header_snippet)
        end

        return sn(1, c(1, headers_to_load_into_choice_node))
      end, {}),
    }),

    -- s("all fn", {
    --   -- Simple static text.
    --   t "//Parameters: ",
    --   -- function, first parameter is the function, second the Placeholders
    --   -- whose text it gets as input.
    --   f(utils.copy, 2),
    --   t { "", "function " },
    --   -- Placeholder/Insert.
    --   i(1),
    --   t "(",
    --   -- Placeholder with initial text.
    --   i(2, "int foo"),
    --   -- Linebreak
    --   t { ") {", "\t" },
    --   -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
    --   i(0),
    --   t { "", "}" },
    -- }),

    s("class", {
      -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
      c(1, {
        t "public ",
        t "private ",
      }),
      t "class ",
      i(2),
      t " ",
      c(3, {
        t "{",
        -- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
        -- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
        sn(nil, {
          t "extends ",
          i(1),
          t " {",
        }),
        sn(nil, {
          t "implements ",
          i(1),
          t " {",
        }),
      }),
      t { "", "\t" },
      i(0),
      t { "", "}" },
    }),

    -- s({ trig = "fn" }, { -- Specific to a repo
    --   d(6, utils.jdocsnip, { 2, 4, 5 }),
    --   t { "", "" },
    --   c(1, {
    --     t { "public " },
    --     t { "private " },
    --   }),
    --   c(2, {
    --     t { "void" },
    --     i(nil, { "" }),
    --     t { "String" },
    --     t { "char" },
    --     t { "int" },
    --     t { "double" },
    --     t { "boolean" },
    --   }),
    --   t { " " },
    --   i(3, { "myFunc" }),
    --   t { "(" },
    --   i(4),
    --   t { ")" },
    --   c(5, {
    --     t { "" },
    --     sn(nil, {
    --       t { "", " throws " },
    --       i(1),
    --     }),
    --   }),
    --   t { " {", "\t" },
    --   i(0),
    --   t { "", "}" },
    -- }),

    s("#if", {
      t "#if ",
      i(1, "1"),
      t { "", "" },
      i(0),
      t { "", "#endif // " },
      f(function(args)
        return args[1]
      end, 1),
    }),
  },
}
