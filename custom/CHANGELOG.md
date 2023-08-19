### Prerequisites

- Neovim v0.10+ (Nightly)
- Node.js
- Basic commandline tools (e.g `git`, `unzip` etc.)
- Basic knowledge of Lua

### Features

- Advanced:
  - [x] Built-in AI Assistant (It's free! check it out [here](https://github.com/sourcegraph/sg.nvim))

- Efficient:
  - [x] Lazy loading
  - [x] Async
  - [x] Insane fast jumping (Via `leap.nvim`)
  - [x] Blazing fast movement using LSP declarations (Via `symbols-outline.nvim`)
  - [x] File navigation
  - [x] Paired Files (e.g `.cpp` and `.hpp`)

- IDE:
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

- Code Generation:
  - [x] C++ TS tools
  - [x] Github Copilot
  - [x] Built-in refactoring engine

- String Manipulation:
  - [x] Surrounding manipulation

- Misc:
  - [x] Built in language Translator
  - [x] Gigantic Gylph Picker (Nerdfonts, emojis, alt characters etc.)
  - [x] Built-in color picker
  - [x] Undo Search

### Installation

1. Neotest:
   ```sh
   cargo install cargo-nextes
   ```

2. LSP Clients:
   ```sh
   npm i -g vscode-langservers-extracted
   ```
3. Github CLI integration

```sh
export GITHUB_TOKEN="..." # OR
gh auth # gh is required (github-cli)
```

### Future Ideas:

- https://github.com/dbeniamine/cheat.sh-vim
- https://github.com/monaqa/dial.nvim -> better C-a C-x
- https://github.com/uga-rosa/ccc.nvim -> Advanced Color picker
- https://github.com/krady21/compiler-explorer.nvim -> Godbolt inside nvim
- https://github.com/Saecki/crates.nvim -> Rust crates.io integration

### TODO

- <leader>ca broke due to change surround (i think)
