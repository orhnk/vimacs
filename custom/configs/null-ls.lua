local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- Generally<F11>
  b.code_actions.refactoring,

  -- All
  b.diagnostics.codespell, -- Smart spell checker, Does not check code, checks text. (comment only probably)
  -- b.completion.spell, -- txt LSP
  b.diagnostics.todo_comments, -- TODO: viewer
  b.diagnostics.trail_space,
  -- b.diagnostics.cspell, -- A bit too annoting. In programming it is common to use acronyms
  b.code_actions.cspell,

  -- Git
  b.diagnostics.gitlint,
  -- b.diagnostics.commitlint, -- look at https://ec.europa.eu/component-library/v1.15.0/eu/docs/conventions/git/ don't use a linter for this

  -- Markdown + Text
  b.formatting.deno_fmt, -- Markdown + Typescript + Javascript
  -- b.formatting.prettier, --[[ .with { filetypes = { "html", "markdown", "css" } } ]] -- so prettier works only on these filetypes
  b.diagnostics.alex,
  b.diagnostics.write_good,
  b.diagnostics.textidote, -- LaTeX + Markdown | Grammar + Style
  b.diagnostics.textlint, -- Txt + Markdown | Grammar + Style
  b.diagnostics.markdownlint, -- Markdown | Style
  b.code_actions.proselint,
  b.diagnostics.proselint, -- LaTeX + Markdown | Grammar + Style
  -- b.formatting.remark,

  -- Json
  b.formatting.fixjson,

  -- TOML
  b.formatting.taplo,

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.code_actions.shellcheck,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Cpp
  b.formatting.clang_format,
  -- b.diagnostics.clang_check,
  -- b.diagnostics.clazy, -- Too much?
  b.diagnostics.cppcheck,

  -- Cmake
  b.formatting.cmake_format,
  b.diagnostics.cmake_lint,
  -- gccdiag is not needed because of NvChad <3

  -- Rust
  b.formatting.rustfmt, -- CHECKMEOUT: rust-tools.nvim does all for me!

  -- Python
  b.diagnostics.ruff,
  b.formatting.black, -- Note: flake8

  -- TreeSitter
  -- AWESOME THING!
  b.code_actions.ts_node_action,

  -- dictionary
  b.hover.dictionary
}

null_ls.setup {
  debug = true,
  sources = sources,
}
