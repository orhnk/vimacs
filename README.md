# CamelVim

A Neovim configuration heavily inspired by JetBrains products.

## Philosophy

- Full featured experience without the bloat.
- Lazy loading of plugins to pay what you use.

## Showcase

![image](https://github.com/UTFeight/CamelVim/assets/101834410/e2a8faa1-8231-4fb2-a1d3-dfe672bf89ce)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/f16cfff5-61c9-4ab4-99a1-eb37601ba6f5)

<details><summary><b>Feature Showcase (Click to expand!)</b></summary>

![image](https://github.com/UTFeight/CamelVim/assets/101834410/4290f494-3c9f-4464-8acc-83259a302e81)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/1efa7bc4-8b59-422f-b987-891920b4e7b1)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/ce49b11c-8c45-4cfa-b0ec-a8d39d051bd3)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/fbc4293a-0d82-436d-8682-c84e27efad35)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/5325df4e-9329-4f72-bb0c-64e2303e86b6)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/707bc295-2a4b-493d-a797-4ed223e0dd3c)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/309a2c44-e378-4658-8647-1ab29f9ef238)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/18407719-e8cc-4c05-8b08-0179b20d7d3d)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/2c473d95-66b4-4296-a772-5cf5d91e1461)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/464778a9-840e-401f-b7c6-bc3da597020f)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/e3a53403-1b68-46a4-922e-4a74b723bcd5)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/243ef818-520a-4566-bdca-b8cf3fbaeb0d)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/22a05ffc-9040-4c34-9889-9ab60472c715)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/22dd023c-866b-42de-a3fb-be11c69d0920)

</details>

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
  - [x] Word motions (Via `vim-wordmotion`)

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

- Rust:
  ```sh
  cargo install cargo-nextes
  ```
