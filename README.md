# CamelVim

A Neovim configuration heavily inspired by JetBrains products.

## Philosophy

- Full featured experience without the bloat.
- Lazy loading of plugins to pay what you use.


## Features

- Advanced:
  - [x] Built-in AI Assistant (It's free! check it out
        [here](https://github.com/sourcegraph/sg.nvim))

<br>

- Efficient:
  - [x] Lazy loading
  - [x] Async
  - [x] Insane fast jumping (Via `leap.nvim`)
  - [x] Blazing fast movement using LSP declarations (Via
        `symbols-outline.nvim`)
  - [x] File navigation
  - [x] Paired Files (e.g `.cpp` and `.hpp`)

<br>

- IDE:
  - [x] On-Click Updates
  - [x] Auto-Complete
  - [x] Syntax Highlighting
  - [x] Smart Code Runner Applet (Via `compiler.nvim`)
  - [x] LSP Support (See [Installation section](#installation))
  - [x] Smart scrollbar (Via `satellite.nvim`)
  - [x] Integrated Terminal
  - [x] Integrated Testing framework
  - [x] Advanced Task Runner
  - [x] Smooth bookmark navigation
  - [x] Minimap (Via `codewind.nvim`)
  - [x] Integrated Git management (Magit-like)
  - [x] Advanced GitHub Integration (Reviewing, PRs, Issues etc.)
  - [x] Browser integrated markdown preview

  > **Note** Going to deprecate Compiler.nvim
  - [x] Built-in Task runner (like Compiler.nvim)

<br>

- Code Generation:
  - [x] C++ TS tools
  - [x] Github Copilot
  - [x] Built-in refactoring engine

<br>

- String Manipulation:
  - [x] Surrounding manipulation

<br>

- Misc:
  - [x] Built in language Translator
  - [x] Gigantic Gylph Picker (Nerdfonts, emojis, alt characters etc.)
  - [x] Built-in color picker
  - [x] Undo Search

## Installation
```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
git clone https://github.com/UTFeight/CamelVim
cd CamelVim && mv custom ~/.config/nvim/lua/custom
cd .. && rm -rf CamelVim && nvim
```

1. Neotest:
   ```sh
   cargo install cargo-nextes
   ```

