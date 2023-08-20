local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local fmt = require('luasnip.extras.fmt').fmt
local types = require("luasnip.util.types")

local function node_with_virtual_text(pos, node, text)
    local nodes
    if node.type == types.textNode then
        node.pos = 2
        nodes = {i(1), node}
    else
        node.pos = 1
        nodes = {node}
    end
    return sn(pos, nodes, {
		node_ext_opts = {
			active = {
				-- override highlight here ("GruvboxOrange").
				virt_text = {{text, "GruvboxOrange"}}
			}
		}
    })
end

local function nodes_with_virtual_text(nodes, opts)
    if opts == nil then
        opts = {}
    end
    local new_nodes = {}
    for pos, node in ipairs(nodes) do
        if opts.texts[pos] ~= nil then
            node = node_with_virtual_text(pos, node, opts.texts[pos])
        end
        table.insert(new_nodes, node)
    end
    return new_nodes
end

local function choice_text_node(pos, choices, opts)
    choices = nodes_with_virtual_text(choices, opts)
    return c(pos, choices, opts)
end

local ct = choice_text_node

ls.add_snippets("python", {
	s('d', fmt([[
		def {func}({args}){ret}:
			{doc}{body}
	]], {
		func = i(1),
		args = i(2),
		ret = c(3, {
			t(''),
			sn(nil, {
				t(' -> '),
				i(1),
			}),
		}),
		doc = isn(4, {ct(1, {
			t(''),
			-- NOTE we need to surround the `fmt` with `sn` to make this work
			sn(1, fmt([[
			"""{desc}"""

			]], {desc = i(1)})),
			sn(2, fmt([[
			"""{desc}

			Args:
			{args}

			Returns:
			{returns}
			"""

			]], {
				desc = i(1),
				args = i(2),  -- TODO should read from the args in the function
				returns = i(3),
			})),
		}, {
			texts = {
				"(no docstring)",
				"(single line docstring)",
				"(full docstring)",
			}
		})}, "$PARENT_INDENT\t"),
		body = i(0),
	}))
})
