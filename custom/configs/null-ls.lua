local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- All
  b.diagnostics.codespell,
  b.comlpetion.spell,
  b.diagnostics.todo_comments, -- TODO: veiwer
  b.diagnostics.trail_space,

  -- Git
  b.diagnostics.gitlint,
  b.diagnostics.commitlint,

  -- Markdown + Text
  b.diagnostics.alex,
  b.diagnostics.write_good,
  b.diagnostics.texidote, -- LaTeX + Markdown | Grammar + Style
  b.diagnostics.textlint, -- Txt + Markdown | Grammar + Style
  b.diagnostics.markdownlint, -- Markdown | Style
  b.diagnostics.proselint, -- LaTeX + Markdown | Grammar + Style
  b.formatting.remark,

  -- Json
  b.formatting.fixjson,

  -- Toml
  b.formatting.taplo

  -- -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  -- b.formatting.prettier.with { filetypes = { "html", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Cpp
  b.formatting.clang_format,
  b.diagnostics.clang_check,
  b.diagnostics.clazy,
  b.diagnostics.cppcheck,

  -- Cmake
  b.formatting.cmake_format,
  b.diagnostics.cmake_lint, -- gccdiag is not needed because of NvChad <3

  -- Rust
  b.formatting.rustfmt,

  -- Python
  b.diagnostics.ruff,
  b.formatting.black, -- Note: flake8
}

null_ls.setup {
  debug = true,
  sources = sources,
}
