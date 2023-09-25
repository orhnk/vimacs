# Vimacs

Neovim configuration heavily inspired by emacs philosophy

## Philosophy

- Full featured experience without the bloat.
- Lazy loading of plugins to pay what you use. (`~%97.5`)

## Showcase

![image](https://github.com/UTFeight/CamelVim/assets/101834410/e2a8faa1-8231-4fb2-a1d3-dfe672bf89ce)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/f16cfff5-61c9-4ab4-99a1-eb37601ba6f5)

<details><summary><b>
    More Themes (Click to expand!)
</b></summary>

> There are 50+ themes that comes out of the box with NvChad. This is just a
> showcase that'll give you some idea about the look.

## Dark

### Nord

![image](https://github.com/UTFeight/vimacs/assets/101834410/e1b59631-02b9-4bf5-8f27-d97ce0c5ace3)

### Rosepine

![image](https://github.com/UTFeight/vimacs/assets/101834410/f2f79475-2429-49a7-aa78-c793e30e7129)

### Onedark

![image](https://github.com/UTFeight/vimacs/assets/101834410/36279d57-2cfb-4ccd-870b-5ca1b612dc93)

### Catpuccin

![image](https://github.com/UTFeight/vimacs/assets/101834410/2a391b43-8322-4ef0-a56a-22a87250ae4f)

### Everforest

![image](https://github.com/UTFeight/vimacs/assets/101834410/2e8714aa-1e82-4f3a-8dbf-8cdd92e833f3)

## Light

### Ayu Light

![image](https://github.com/UTFeight/vimacs/assets/101834410/1c3be5cf-4380-4523-8824-1565d3ba7622)

</details>

<details><summary><b>
    Feature Showcase (Click to expand!)
</b></summary>

1. Built-in AI Assistant:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/4290f494-3c9f-4464-8acc-83259a302e81)

2. Inline AI requests:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/1efa7bc4-8b59-422f-b987-891920b4e7b1)

3. Magit Clone:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/ce49b11c-8c45-4cfa-b0ec-a8d39d051bd3)

4. Github Integration:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/fbc4293a-0d82-436d-8682-c84e27efad35)

5. Github Actions Viewer:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/5325df4e-9329-4f72-bb0c-64e2303e86b6)

6. Code Refactoring:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/707bc295-2a4b-493d-a797-4ed223e0dd3c)

7. Icon :
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/309a2c44-e378-4658-8647-1ab29f9ef238)

8. Markdown preview:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/18407719-e8cc-4c05-8b08-0179b20d7d3d)

9. LSP:
   ![image](https://github.com/UTFeight/CamelVim/assets/101834410/2c473d95-66b4-4296-a772-5cf5d91e1461)

10. Built-in PasteBin Client:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/464778a9-840e-401f-b7c6-bc3da597020f)

11. Easy navigation with `symbols-outline.nvim`:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/e3a53403-1b68-46a4-922e-4a74b723bcd5)

12. Tens of Themes Built-in:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/243ef818-520a-4566-bdca-b8cf3fbaeb0d)

13. Terminal Integrated with Themes:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/22a05ffc-9040-4c34-9889-9ab60472c715)

14. Github Copilot:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/22dd023c-866b-42de-a3fb-be11c69d0920)

15. Built-in Language Translator:
    ![image](https://github.com/UTFeight/CamelVim/assets/101834410/938faba6-7647-4649-95fb-60b2adc55961)

</details>

## Features

- Advanced:
  - [x] Stack Overflow Client
  - [x] Email Client
  - [x] Integrated Reddit Client (See
        [DEMO](https://github.com/UTFeight/vimacs/assets/101834410/85a24510-58a8-44e1-aa9b-8cfe96073b76))
  - [x] Discord Client (See [TOU](#discordo))
  - [x] Browser (#5)
        ([INSANE DEMO](https://github.com/UTFeight/CamelVim/issues/5))
  - [x] Browser (#6) (text-only)
  - [x] IRC Client
  - [x] Built-in AI Assistant (It's free! check it out
        [here](https://github.com/sourcegraph/sg.nvim)) [OPT]
  - Github Copilot
  - TabNine AI
  - [x] Leetcoding inside your editor
  - [x] Built-in code profiler (suitible for PGO optimizers) (`perfanno.nvim`)
  - [x] Built-in Compiler explorer (Byte-code, ASM etc. viewer)
        (`compiler-explorer.nvim`)
  - [x] crates.io integration (`crates.nvim`) [`RUST`]

<br>

- Efficient:
  - [x] Cheatsheets (where cheating is legal, inside your editor)
        (`cheatsheet.nvim`)
  - [x] Lazy loading
  - [x] Async
  - [x] Insane fast jumping (Via `flash.nvim`)
  - [x] Blazing fast movement using LSP declarations (Via
        `symbols-outline.nvim`)
  - [x] File navigation (`harpoon.nvim`)
  - [x] Paired Files (e.g `.cpp` and `.hpp`)
  - [x] Word motions (Via `vim-wordmotion`)
  - [x] Clipboard Manager (`nvim-neoclip.lua`)

<br>

Beautiful:

- [x] Mode indicator cursorline (`modicator.nvim`)

<br>

- IDE:
  - [x] On-Click Updates
  - [x] Efficient Plugin Manager
  - [x] LSP Package manager
  - [x] Decent Debugging Experience
  - [x] Auto-Complete
  - [x] Syntax Highlighting
  - [x] Smart Code Runner Applet (Via `compiler.nvim`)
  - [x] LSP Support (See [Installation section](#installation))
  - [x] Smart scrollbar (Via `satellite.nvim`) [OPT]
  - [x] Integrated Terminal
  - [x] Integrated Testing framework
  - [x] Advanced Task Runner (`Overseer.nvim`)
  - [x] Smooth bookmark navigation
  - [x] Minimap integrated with your config (Via `codewindow.nvim`)
  - [x] Advanced GitHub Integration (Reviewing, PRs, Issues etc.)
  - [x] Built-in file manager (Emacs-like) (`telescope-file-manager`)
  - [x] Project manager (Via `project.nvim`)
  - [x] Key stroke helper (Via `which-key.nvim`)
  - [x] Efficient Searching integrated with plugins (Via `Telescope.nvim`)
  - [x] Built-in Task runner (like Compiler.nvim)
  - [x] Syntax-Highlighting (`tree-sitter`)
  - [x] File Tree (`nvim-tree`)
  - [x] Beautiful UI for default nvim (`NvChadUI` + `dressing.nvim`)
  - [x] Vs-code like project dependant tasks (`automaton.nvim`)
  - [x] Improvised LSP experience (`lsp_signature.nvim` + `null-ls` +
        `lspconfig`)
  - [x] Folding code (`nvim-UFO` + `nvim-foldsign`)
  - [x] Biscuits (View complex code in ease) (`nvim-biscuits`)
  - [x] Improved quick-fix loc-list experience (`nvim-bqf`)
  - [x] Inline Snippet runner (`sniprun`)

<br>

- Git:
  - [x] Integrated Git management (Magit-like)
  - [x] CI viewer (`gh-actions`)
  - [x] Git Merge Conflict viewer (`git-conflict.nvim`)

<br>

- Code Generation:
  - [x] Document generation (`neogen`)
  - [x] C++ TS tools
  - [x] Github Copilot
  - [x] Built-in refactoring engine

<br>

- String Manipulation:
  - [x] Surrounding manipulation
  - [x] Regexplainer (`Hypersonic.nvim`)
  - [x] (inline formatting) Unjoining lines (`treesj`)
  - [x] Custom AST code actions (`ts-node-action`)
  - [x] Code Alignment

<br>

- Misc:

  - [x] Built in language Translator (With multiple backends)
  - [x] Gigantic Gylph Picker (Nerdfonts, emojis, alt characters etc.)
  - [x] Built-in color picker
  - [x] Undo Search
  - [x] Better escape
  - [x] Real-time colorscheme engine (create colorschemes on the fly)
        (`lush.nvim`)

<br>

- Modes:
  - [x] Argument highlighter (differentiate between args from vars)
  - [x] LSP Lens (Show references definitions etc. as virtual text)
        (`lsp-lens.nvim`)
  - [x] Twilight Mode (highlighting the place your cursor is on while dimming
        other places) (`twilight.nvim`)
  - [x] Zen-mode (distraction-free code editing in minimalism) (`zen-mode.nvim`)
  - [x] Smooth-scrolling (in `sine-mode`) (`neoscroll.nvim`)
  - [x] TODO-mode (beautiful todo manager + highlighter) (`todo-comments.nvim`)

<br>

- Document Writing:
  - [x] Markdown code evaluation (`mdeval.nvim`)
  - [x] Browser integrated markdown preview (`markdown-preview.nvim`)

## Installation

> [!TODO]: Make INSTALL Script more interactive

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

2. Debugger:
   ```sh
   yay -S codelldb # AUR
   ```

3. Project Surfing:

> **Warning**: This feature requires a `base_dirs` variable in
> `custom/plugins.lua` as in the `telescope-project.nvim`

4. Copilot

   - Github is a paid program that suggests code when you are typing. You need
     to authorize by using:

   ```vim
   :Copilot auth
   ```

5. Tabnine
   > [!important] Tabnine is free
   - When installing the editor, You need to authorize from your browser.

6. Null-ls
   ```sh
   yay -S codespell textlint markdownlint stylua ruff
   ```

7. Leet code:
   - [Must-do](https://github.com/Dhanus3133/Leetbuddy.nvim#login-to-your-account)

8. Email Client:
   - Gmail:
   <!-- deno-fmt-ignore -->
     > [!IMPORTANT]
     > You need Two factor authentication enabled!

   Then follow the instructions from
   [this site](https://seniormars.github.io/posts/neomutt/).

9. LLMs (Large Language Model):

   <!-- deno-fmt-ignore -->
   > [!NOTE]
   > This config uses hfc (huggingface) api by default.

   check:
   - [to generate API key](https://huggingface.co/settings/tokens)
   - [other backends](https://github.com/gsuuon/llm.nvim#providers)
   - [more info](https://github.com/gsuuon/llm.nvim)

   - setup: change the config src if you want to use a different backend than
     the default simply generate an API key from above link. Then set the
     appropriate environment variable (HUGGINGFACE_API_KEY is the default)

10. Markdown-maps:

    `yarn` is required for markmap.nvim plugin
    ```sh
    yay -S yarn # AUR
    ```

## Credits

- Thank you [siduck](https://github.com/siduck) for creating the wonderful
  neovim UI [NvChad](https://github.com/NvChad/NvChad)
- Thank you [sourcegraph](https://sourcegraph.com) team for the amazing
  [cody AI](https://sourcegraph.com/cody)
- Many Thanks to all plugin authors

---

## Terms of usage

### Discordo

Automated user accounts or "self-bots" are against Discord's Terms of Service. I
am not responsible for any loss caused by using "self-bots" or Discordo.

(See [Discordo](https://github.com/ayn2op/discordo#readme))
