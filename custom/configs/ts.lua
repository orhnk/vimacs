local M = {}

--- Debug Node
---@param node TSNode
local function D(node)
  print(vim.inspect(getmetatable(node)))
end

--- Node to String
---@param node TSNode
---@return string
local function S(node)
  return require("ts-node-action.helpers").node_text(node)
end

--- Prints the node
---@param node node TSNode
local function print_node(node)
  vim.print(S(node))
end

local function CCat(text_buf)
  -- if type is table:
  if type(text_buf) == "table" then
    return table.concat(text_buf, "\n")
  end
  return text_buf
end

-- fn abc = -> { blah blah } <-
---@param node TSNode
---@return string
local function till_first_brace(node)
  local text = CCat(S(node))
  local first_brace = string.find(text, "{")
  local till_curly = string.sub(text, 1, first_brace - 1)
  local trimmed = string.gsub(till_curly, "%s*$", "")
  return trimmed
end

local function cpp_extract_block(node)
  local node_type_parent = "function_definition"
  -- If we are on a type of a function, we need to go up one level
  -- recurse
  local type = S(node)
  vim.print(type)
  while node:type() ~= node_type_parent do
    -- NOTE: node is not a function
    node = node:parent()
    if node == nil then
      vim.print("No parent function found")
      return
    end
  end

  if node:type() == node_type_parent then
    local replacement = {}

    table.insert(replacement, till_first_brace(node) .. ";")
    -- a table line represents a \n
    table.insert(replacement, type)
    return replacement
  end
  local signature = till_first_brace(node)
  return signature .. ";"
end

local function rust_extract_braced(node)
  D(node)
  local signature = till_first_brace(node)
  return signature .. ";"
end

-- TODO: Add ts-node-action.actions to actions
M.lang = {}
M.lang.rust = function()
  return {
    ["block"] = { { rust_extract_braced, name = "Extract" } },
    ["function_item"] = { { rust_extract_braced, name = "Extract Function" } },
  }
end

M.lang.cpp = function()
  return {
    ["compound_statement"] = { { cpp_extract_block, name = "Extract" } },
    ["function_definition"] = { { cpp_extract_block, name = "Extract Function" } },
    ["type_identifier"] = { { cpp_extract_block, name = "Extract Function" } },
    ["primitive_type"] = { { cpp_extract_block, name = "Extract Function" } },
    ["auto"] = { { cpp_extract_block, name = "Extract Function" } },
    ["namespace_identifier"] = { { cpp_extract_block, name = "Extract Function" } },
  }
end

M.opts = {

  cpp = M.lang.cpp(),
  rust = M.lang.rust(),

  -- ["*"] = { -- Global table is checked for all langs
  --   ["node_type"] = fn,
  --   ...,
  -- },
  -- lang = {
  --   ["node_type"] = fn,
  --   ...,
  -- },
  -- ...,
}

-- NOTE: To Debug the tsnode:
-- print(vim.inspect(getmetatable(node)))

-- NOTE: To Debug the text:
-- vim.print(text)

return M
