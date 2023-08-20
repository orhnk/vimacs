-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Snippet paths
vim.g.vscode_snippets_path = "~/.config/nvim/lua/custom/snippets/json"
vim.g.lua_snippets_path = "~/.config/nvim/lua/custom/snippets/lua"
vim.g.snipmate_snippets_path = "~/.config/nvim/lua/custom/snippets/snipmate"

-- -- Remove terminal padding when inside nvim:
---- For st:
function Sed(from, to, fname)
  vim.cmd(string.format("silent !sed -i 's/%s/%s/g' %s", from, to, fname))
end

function Reload()
    vim.cmd(string.format("silent !xrdb merge ~/.Xresources && kill -USR1 $(xprop -id $(xdotool getwindowfocus) | grep '_NET_WM_PID' | grep -oE '[[:digit:]]*$')"))
end

function DecreasePadding()
  Sed('st.borderpx: 20', 'st.borderpx: 0', '~/.Xresources')
  Reload()
  Sed('st.borderpx: 0', 'st.borderpx: 20', '~/.Xresources')
end

function IncreasePadding()
  Reload()
end

vim.cmd[[
  augroup ChangeStPadding
   au!
   au VimEnter * lua DecreasePadding()
   au VimLeavePre * lua IncreasePadding()
  augroup END
]]

---- For alacritty:
-- local function sed(from, to)
--   vim.cmd(string.format("silent !sed -i 's/%s/%s/g' %s", from, to, "~/.config/alacritty/alacritty.yml"))
-- end
--
-- local autocmd = vim.api.nvim_create_autocmd
--
-- autocmd("VimEnter", {
--   callback = function()
--     sed("x: 25", "x: 0")
--     sed("y: 25", "y: 0")
--   end,
-- })
--
-- autocmd("VimLeavePre", {
--   callback = function()
--     sed("x: 0", "x: 25")
--     sed("y: 0", "y: 25")
--   end,
-- })

