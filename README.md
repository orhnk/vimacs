# Vimacs

A Neovim Configuration. Inspired by JetBrains, Emacs, VS Code. Built on top of
NvChad's UI.

## Preface

This Neovim Distribution is heavily focused on performance, feature and beauty.

### Vimacs is _**Beautiful**_

Vimacs uses a base configuration called
[NvChad](https://github.com/NvChad/NvChad) which is beautiful out of the box.

### Vimacs is _**Feature-rich**_

Vimacs comes with dozens of neovim plugins optimized for your daily use

Vimacs uses external programse to enhance it's functionality. (e.g) Vimacs has
an optional mail client based on neomutt

The following image shows the which-key.nvim help for `<leader>` (aka space) key

<!-- deno-fmt-ignore -->
> [!NOTE]
> Green text means the top of the keymapping tree (e.g `<leader>a`
> includes everything related to AI, `<leader>ai` opens the Cody AI assistant in
> a vertical split) Red text means the direct cmd (e.g `<leader>.` opens the
> file manager)

<p align="center">
    <img src="https://github.com/UTFeight/vimacs/assets/101834410/4a70298b-0d9f-4e28-b720-627bc1512b30" align="middle">
</p>

### Vimacs is _**Performant**_?

Because of the extensive ecosystem of Vimacs, Performance optimizations are
crucial.

With the power of lazy loading (**~%97.5**), you only pay for what you use
([lazy.nvim](https://github.com/folke/lazy.nvim))

<!-- Vimacs You only pay for what you use thanks to lazy loading (**~%97.5**) -->

In addition to that, external programs use the system shell as an interface
which doesn't reduce performance.

## Showcase

![image](https://github.com/UTFeight/vimacs/assets/101834410/4e9f2023-dbb3-4b42-aec8-6c23b77a4b89)

![image](https://github.com/UTFeight/vimacs/assets/101834410/e3699d59-268c-4c7e-aaa5-b0886277780a)

![image](https://github.com/UTFeight/vimacs/assets/101834410/a7309d82-3083-44ef-bb6c-a39f95cac490)

<!--![image](https://github.com/UTFeight/CamelVim/assets/101834410/e2a8faa1-8231-4fb2-a1d3-dfe672bf89ce)

![image](https://github.com/UTFeight/CamelVim/assets/101834410/f16cfff5-61c9-4ab4-99a1-eb37601ba6f5)-->

<details><summary><b>
    More Themes (Click to expand!)
</b></summary>

<!-- deno-fmt-ignore -->
> [!NOTE]
> There are 50+ themes that come out of the box with NvChad. This is just a
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

## Prerequisites

Vimacs requires **Neovim Nightly** for all the features to work properly.
Although It's possible to use Vimacs with stable neovim, It's not recommended.

Also vimacs comes with a lot of dependencies. Follow the instructions on
[this](#installation) page to install them.

<!-- deno-fmt-ignore -->
> [!NOTE]
> Some of the vimacs features will require additional setup. (e.g AI
> Assistant, Project Surfing etc.) And some of the advanced features will
> require additional installation
> ([SEE](https://github.com/UTFeight/vimacs/blob/master/INSTALL.sh) for more
> info)

## Feature List

- [x] NvChad:
  - [x] Hot reloaded themes
        ([DEMO](https://github-production-user-asset-6210df.s3.amazonaws.com/101834410/271164200-0128b0db-3ef8-4988-9713-4103d106c5e6.mp4))
        ([base46](https://github.com/NvChad/base46))
  - [x] Search Engine
        ([IMAGE](https://github-production-user-asset-6210df.s3.amazonaws.com/101834410/271164656-9fd958c9-8c73-4885-ad86-ff76188931d7.png))
        ([telescope.nvim](https://github.com/nvim-telescope/telescope.nvim))
  - [x] Basic Git Integration
        ([gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim))
  - [x] Auto-Generated Cheatsheets
        ([IMAGE](https://github-production-user-asset-6210df.s3.amazonaws.com/101834410/271164822-a0b3b110-4f0e-44fc-b00e-5e8c18ba6c1b.png))
        ([native](https://github.com/NvChad/ui))
  - [x] Beautiful UI ([native](https://github.com/NvChad/ui))
  <!----------------------------------------------------------------->
  <!--        MOVED TO IDE FEATURES (notes as NvChad There)        -->
  <!----------------------------------------------------------------->
  <!-- - Snippet Engine (DEMO) ([LuaSnip](https://github.com/L3MON4D3/LuaSnip)) -->
  <!--   ([friendly-snippets](https://github.com/rafamadriz/friendly-snippets)) -->
  <!-- - LSP Completion ([nvim-cmp](https://github.com/hrsh7th/nvim-cmp)) -->
  <!--   ([nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)) -->
  <!--   ([mason.nvim](https://github.com/williamboman/mason.nvim)) -->
  <!-- - File Tree ([nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)) -->

<!---------------------------------------------------->
<!--                    MODIFIED                    -->
<!---------------------------------------------------->

- [x] IDE:
  - [x] On-Click Updates
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/94730e09-16dc-4df6-85c0-6c9bc0b23183))
        (NvChad)
  - [x] Plugin Manager (lazy.nvim)
  - [x] Inline Code Runner (sniprun)
  - [x] Profiler (perfanno.nvim)
  - [x] Project:
    - [x] Project Manager
          ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/010857c5-be4a-41ec-83b8-d2dc1bfa14d3))
          (native)
    - [x] Project Search (telescope-project.nvim)
  - [x] Smooth Debugging Experience
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/fe387337-1c62-4495-a5de-8aa245eadb94))
        (nvim-dap) (nvim-dap-ui) (nvim-dap-virtual-text) (cmp-dap)
        (nvim-dap-repl-highlights) (mason.nvim) (mason-nvim-dap.nvim) (native)
  - [x] Markdown Preview
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/0ac21127-6ae2-4176-a8c0-3ef58815044c))
        (markdown-preview.nvim)
  - [x] Undo History Fuzzy Search (telescope-undo.nvim)
  - [x] Undo Tree (undotree)
  - [x] Code Symbols Navigation (symbols-outline.nvim)
  - [x] Git:
    - [x] Github Integration (octo.nvim)
    - [x] Github Action Tracking (gh-actions.nvim)
    - [x] Magit (neogit)
    - [x] Git Conflict Viewer (git-conflict.nvim)
  - [x] Project Runner (compiler.nvim)
  - [x] Task Framework (overseer.nvim)
  - [x] Testing Framework (neotest)
        <!-- TODO: This requires a configuration, rust comes out of the box -->
  - [x] LSP
    - [x] Code Actions
    - [x] Diagnostics
    - [x] Hover
    - [x] Go-To Actions
    - [x] Rename
    - [x] Inline Signature Help (lsp_signature.nvim)
    - [x] Completion ([nvim-cmp](https://github.com/hrsh7th/nvim-cmp))
          ([nvim-lspconfig](https://github.com/neovim/nvim-lspconfig))
          ([mason.nvim](https://github.com/williamboman/mason.nvim))
  - [x] File Tree ([nvim-tree](https://github.com/kyazdani42/nvim-tree.lua))
  - [x] Folding Mode (nvim-ufo)
  - [x] Brace Hints (nvim-biscuits) <!-- Thing for a better name -->
  - [x] Tree-Sitter Hints
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/0bbb651e-e572-4daa-b7b6-62631b0891d0))
        (nvim_context_vt)
  - [x] Smooth Sine Scrolling (neoscroll.nvim)
  - [x] Session Manager (persistence.nvim)

<br>

- [x] Neovim:
  - [x] Language aware comments (`Comment.nvim`)
  - [x] Escape Insert Mode [`jj`, `jk`] (better-escape.nvim)
  - [x] Surround Manupilation (nvim-surround)
  - [x] Conditional + Smart File Switcher (DEMO)
        (other.[nvim](2023-09-29_nvim.md))
  - [x] Inline Bookmark Indicator (marks.nvim)
  - [x] Case Toggle (native)
  - [x] Inline UnJoining
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/02c9bdf9-a126-4c88-bf9c-080e1e2614e5))
        (treesj)
  - [x] QuickFix:
    - [x] QuickFix File Preview
          ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/d9469d87-d189-4151-bf29-02dd3e4594aa))
          (nvim-bqf)
    - [x] Prettier Quick Fix (nvim-pqf)
  - [x] Jump Navigation
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/23525515-56ae-47f8-ad63-dc98e56d6fde))
        (flash.nvim)
  - [x] File Marks
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/73987fac-133f-4104-9fa4-d0efdbe8cb7a))
        (harpoon)
  - [x] Align Actions
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/b5f23bb6-ff69-402c-af76-cd27336daa2c))
        (vim-easy-align)
  - [x] Window Manager (winshift.nvim)
  - [x] Text Objets:
    - [x] Additional Text Objects (ns-textobject.nvim) (nvim-various-textobjs)
  - [x] Custom Toggle (dial.nvim)
  - [x] Exchange Motions (vim-exchange)

<br>

- [x] Miscellaneous:
  - [x] Regular Expression Explainer (Hypersonic.nvim)
  - [x] File Manager (telescope-file-browser.nvim)
  - [x] Pop-up Language Translator (vim-translator)
  - [x] REPL Translate (pantran.nvim)
  - [x] LeetCode Integration (LeetBuddy.nvim)
  - [x] Advanced Color Picker (ccc.nvim)
  - [x] Nerd Font Picker (nerdy.nvim)
  - [x] Programming
    - [x] Function Argument Highlighter (hlargs.nvim)
    - [x] Virtual Reference Table (lsp-lens.nvim)
    - [x] CheatSheets (cheetsheets.nvim)
  - [x] Real-time Colorscheme Editor (lush.nvim)
  - [x] Clipboard Manager (nvim-neoclip.lua)
  - [x] ToDo Manager (todo-comments.nvim)
  - [x] Games:
    - [x] Sudoku (sudoku.nvim)
    - [x] VimBeGood (vim-be-good)
    - [x] Tetris (nvim-tetris)
    - [x] KillerSheep (killersheep.nvim)
    - [x] Buffer Text Animations (cellular-automaton.nvim)
    - [x] Mine Sweeper (nvimesweeper)
    - [x] MonkeyType (speedtyper.nvim)
  - [x] URL Manager (urlview.nvim)
  - [x] External Browser Search (browse.nvim)
  - [x] Apps:
    - [x] Daily Calendar (apc.nvim)
  - [x] Plugin Surf (telescope-lazy.nvim)
  - [x] Integrated:
    - [x] Browser (brow.sh)
    - [x] Lynx (lynx)
    - [x] Discord Client (discord) (TOU) <!-- TODO: Add no responsibility -->
    - [x] Hacker News Client (hacker_news_tui)
    - [x] IRC Client (weechat)
    - [x] Email Client (neomutt)
    - [x] World Map (mapscii)
    - [x] Music Player (ncmpcpp)
    - [x] Reddit Client (tuir)
    - [x] Stackoverflow (stackoverflow_tui)
    - [x] WhatsApp Client (nchat)

<br>

- [x] Advanced:
  - [x] Org-Mode (orgmode)
  - [x] Doc:
    - [x] Org:
      - [x] Code Block LSP (nvim-FeMaco.lua)
    - [x] Markdown:
      - [x] Markdown Mode (mkdnflow.nvim)
      - [x] Inline Code Evaluation (mdeval.nvim)
      - [x] Code Block LSP (nvim-FeMaco.lua)
      - [x] Toggle Checkbox (markdown-togglecheck)
      - [x] Mind Maps (markmap.nvim)
    - [x] Modes:
      - [x] Table Mode
            ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/0ee08c12-f70f-42b7-b075-c087ab6fbdfc))
            (vim-table-mode)
      - [x] Beautiful Comments (comment-box.nvim)
      - [x] Due Mode
            ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/a21e5a3e-384c-41f5-8007-da4802e01501))
            (due.nvim)
  - [x] Compiler Explorer (compiler-explorer.nvim)
  - [x] Tree-Sitter Explorer (neovim):
    - [x] Query Editor
    - [x] Parse Tree
    - [x] Hover Actions
  - [x] Language:
    - [x] C++:
      - [x] Doc Search (cppman.nvim)
    - [x] Rust:
      - [x] Advanced crates.io Integration (crates.nvim)
  - [x] Inline Document Generation
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/95de6196-f712-462e-8fae-cd86c9828ff7))
        (neogen)
  - [x] PasteBin Client with multi-backends (paperplanes.nvim)
  - [x] Refactoring:
    - [x] Generic Refactoring (refactoring.nvim)
    - [x] Smart Inline Actions
          ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/906e0412-9e7d-49b4-b67f-ecffb8c90831))
          (tree-sitter) (ts-node-action) (native)
    - [x] Custom Code Actions (ts-node-action)
    - [x] C++ native refactoring (nvim-treesitter-cpp-tools)
  - [x] Snippet Engine
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/4a9b582b-3d9e-4ca2-bad5-9d974daef383))
        ([LuaSnip](https://github.com/L3MON4D3/LuaSnip))
  - [x] AI:
    - [x] Github Copilot (copilot.lua)
    - [x] AI Assistant
          ([DEMO](https://github-production-user-asset-6210df.s3.amazonaws.com/101834410/271752414-4419f16e-1526-41e2-a0f8-443eaf23a538.mp4))
          (sg.nvim)
    - [x] Multi-backend LLM Integration (llm.nvim)

<br>

- [x] UI:
  - [x] Beautiful Neovim UI Wrapper (dressing.nvim)
  - [x] Code MiniMap (codewindow.nvim)
  - [x] Twilight Mode
        ([DEMO](https://github.com/UTFeight/vimacs/assets/101834410/554fef18-0b71-4420-bb0d-40564932934d))
        (twilight.nvim)
  - [x] Mode Indicator Line Number (modicator.nvim)
  - [x] Zen Mode (zen-mode.nvim)
  - [x] Narrow Mode (true-zen.nvim)
  - [x] Focus Mode (true-zen.nvim)
  - [x] Minimalist Mode (true-zen.nvim)
  - [x] Atarix Mode (true-zen.nvim)
  - [x] Goyo Mode (goyo.nvim)
  - [x] Smart Column (smartcolumn.nvim)

<!-- - Advanced: -->
<!--   - [x] Stack Overflow Client -->
<!--   - [x] Email Client -->
<!--   - [x] Integrated Reddit Client (See -->
<!--         [DEMO](https://github.com/UTFeight/vimacs/assets/101834410/85a24510-58a8-44e1-aa9b-8cfe96073b76)) -->
<!--   - [x] Discord Client (See [TOU](#discordo)) -->
<!--   - [x] Browser (#5) -->
<!--         ([INSANE DEMO](https://github.com/UTFeight/CamelVim/issues/5)) -->
<!--   - [x] Browser (#6) (text-only) -->
<!--   - [x] IRC Client -->
<!--   - [x] Built-in AI Assistant (It's free! check it out -->
<!--         [here](https://github.com/sourcegraph/sg.nvim)) [OPT] -->
<!--   - Github Copilot -->
<!--   - TabNine AI -->
<!--   - [x] Leetcoding inside your editor -->
<!--   - [x] Built-in code profiler (suitible for PGO optimizers) (`perfanno.nvim`) -->
<!--   - [x] Built-in Compiler explorer (Byte-code, ASM etc. viewer) -->
<!--         (`compiler-explorer.nvim`) -->
<!--   - [x] crates.io integration (`crates.nvim`) [`RUST`] -->
<!---->
<!-- <br> -->
<!---->
<!-- - Efficient: -->
<!--   - [x] Cheatsheets (where cheating is legal, inside your editor) -->
<!--         (`cheatsheet.nvim`) -->
<!--   - [x] Lazy loading -->
<!--   - [x] Async -->
<!--   - [x] Insane fast jumping (Via `flash.nvim`) -->
<!--   - [x] Blazing fast movement using LSP declarations (Via -->
<!--         `symbols-outline.nvim`) -->
<!--   - [x] File navigation (`harpoon.nvim`) -->
<!--   - [x] Paired Files (e.g `.cpp` and `.hpp`) -->
<!--   - [x] Word motions (Via `vim-wordmotion`) -->
<!--   - [x] Clipboard Manager (`nvim-neoclip.lua`) -->
<!--   - [x] Insert mode escape [`jj`, `jk`] (`better-escape.nvim`) -->
<!---->
<!-- <br> -->
<!---->
<!-- Beautiful: -->
<!---->
<!-- - [x] Mode indicator cursorline (`modicator.nvim`) -->
<!---->
<!-- <br> -->
<!---->
<!-- - IDE: -->
<!--   - [x] On-Click Updates -->
<!--   - [x] Efficient Plugin Manager -->
<!--   - [x] LSP Package manager -->
<!--   - [x] Decent Debugging Experience -->
<!--   - [x] Language aware comments -->
<!--   - [x] Auto-Complete -->
<!--   - [x] Syntax Highlighting -->
<!--   - [x] Featurefull Snippet -->
<!--   - [x] Smart Code Runner Applet (Via `compiler.nvim`) -->
<!--   - [x] LSP Support (See [Installation section](#installation)) -->
<!--   - [x] Smart scrollbar (Via `satellite.nvim`) [OPT] -->
<!--   - [x] Integrated Terminal -->
<!--   - [x] Integrated Testing framework -->
<!--   - [x] Advanced Task Runner (`Overseer.nvim`) -->
<!--   - [x] Smooth bookmark navigation -->
<!--   - [x] Minimap integrated with your config (Via `codewindow.nvim`) -->
<!--   - [x] Advanced GitHub Integration (Reviewing, PRs, Issues etc.) -->
<!--   - [x] Built-in file manager (Emacs-like) (`telescope-file-manager`) -->
<!--   - [x] Project manager (Via `project.nvim`) -->
<!--   - [x] Key stroke helper (Via `which-key.nvim`) -->
<!--   - [x] Efficient Searching integrated with plugins (Via `Telescope.nvim`) -->
<!--   - [x] Built-in Task runner (like Compiler.nvim) -->
<!--   - [x] Syntax-Highlighting (`tree-sitter`) -->
<!--   - [x] File Tree (`nvim-tree`) -->
<!--   - [x] Beautiful UI for default nvim (`NvChadUI` + `dressing.nvim`) -->
<!--   - [x] Vs-code like project dependant tasks (`automaton.nvim`) -->
<!--   - [x] Improvised LSP experience (`lsp_signature.nvim` + `null-ls` + -->
<!--         `lspconfig`) -->
<!--   - [x] Folding code (`nvim-UFO` + `nvim-foldsign`) -->
<!--   - [x] Biscuits (View complex code in ease) (`nvim-biscuits`) -->
<!--   - [x] Improved quick-fix loc-list experience (`nvim-bqf`) -->
<!--   - [x] Inline Snippet runner (`sniprun`) -->
<!---->
<!-- <br> -->
<!---->
<!-- - Git: -->
<!--   - [x] Integrated Git management (Magit-like) -->
<!--   - [x] CI viewer (`gh-actions`) -->
<!--   - [x] Git Merge Conflict viewer (`git-conflict.nvim`) -->
<!---->
<!-- <br> -->
<!---->
<!-- - Code Generation: -->
<!--   - [x] Document generation (`neogen`) -->
<!--   - [x] C++ TS tools -->
<!--   - [x] Github Copilot -->
<!--   - [x] Built-in refactoring engine -->
<!---->
<!-- <br> -->
<!---->
<!-- - String Manipulation: -->
<!--   - [x] Surrounding manipulation -->
<!--   - [x] Regexplainer (`Hypersonic.nvim`) -->
<!--   - [x] (inline formatting) Unjoining lines (`treesj`) -->
<!--   - [x] Custom AST code actions (`ts-node-action`) -->
<!--   - [x] Code Alignment -->
<!---->
<!-- <br> -->
<!---->
<!-- - Misc: -->
<!---->
<!--   - [x] Built in language Translator (With multiple backends) -->
<!--   - [x] Gigantic Gylph Picker (Nerdfonts, emojis, alt characters etc.) -->
<!--   - [x] Built-in color picker -->
<!--   - [x] Undo Search -->
<!--   - [x] Better escape -->
<!--   - [x] Real-time colorscheme engine (create colorschemes on the fly) -->
<!--         (`lush.nvim`) -->
<!---->
<!-- <br> -->
<!---->
<!-- - Modes: -->
<!--   - [x] Argument highlighter (differentiate between args from vars) -->
<!--   - [x] LSP Lens (Show references definitions etc. as virtual text) -->
<!--         (`lsp-lens.nvim`) -->
<!--   - [x] Twilight Mode (highlighting the place your cursor is on while dimming -->
<!--         other places) (`twilight.nvim`) -->
<!--   - [x] Zen-mode (distraction-free code editing in minimalism) (`zen-mode.nvim`) -->
<!--   - [x] Smooth-scrolling (in `sine-mode`) (`neoscroll.nvim`) -->
<!--   - [x] TODO-mode (beautiful todo manager + highlighter) (`todo-comments.nvim`) -->
<!---->
<!-- <br> -->
<!---->
<!-- - Document Writing: -->
<!--   - [x] Markdown code evaluation (`mdeval.nvim`) -->
<!--   - [x] Browser integrated markdown preview (`markdown-preview.nvim`) -->

## Installation

<!-- deno-fmt-ignore -->
> [!TODO]: 
> Make INSTALL Script more interactive

```sh
git clone https://github.com/NvChad/starter ~/.config/nvim 
git clone https://github.com/UTFeight/vimacs
cd vimacs && mv custom ~/.config/nvim/lua/custom
cd .. && rm -rf vimacs 
# Migration script for latest NvChad (custom folder not supported)
# Check https://nvchad.com/news/v2.5_release for details
git clone https://gist.github.com/048bed2e7570569e6b327b35d1715404.git upgradeNvChad2.5
cd upgradeNvChad2.5 && chmod +x migrate.sh && ./migrate.sh
cd .. && rm -rf upgradeNvChad2.5
```

1. Neotest:

- Rust:
  ```sh
  cargo install cargo-nextest
  ```

2. Debugger:
   ```sh
   # This is for unexpected scenarios only.
   # In general mason should install these X-platform

   #                  config.fish                  #
   #               Vimacs Mason PATH               #
    export PATH="$HOME/.local/share/nvim/mason/bin"
   ```

   Vimacs ships with default python, C/C++ and Rust debuggers. If you have any
   other to configure please look into `custom/plugins.lua` "nvim-dap" and
   `custom/configs/nvim-dap.lua`

3. Project Surfing:

<!-- deno-fmt-ignore -->
> [!Warning]
> This feature requires a `base_dirs` variable in
> `custom/plugins.lua` as in `telescope-project.nvim`

4. Github Copilot

   - Github Copilot is a paid program that suggests code when you are typing.
     You need to authorize by using:

   ```vim
   :Copilot auth
   ```

<!-- 5. Tabnine -->
<!---->
<!--    <!-- deno-fmt-ignore -->
<!--    > [!NOTE] -->
<!--    > Tabnine is free -->
<!---->
<!--    - When installing the editor, You need to authorize from your browser. -->

5. Null-ls
   ```sh
   yay -S codespell textlint markdownlint stylua ruff
   ```

6. LeetCode:
   - [Must-do](https://github.com/Dhanus3133/Leetbuddy.nvim#login-to-your-account)

7. Email Client:
   - Gmail:
   <!-- deno-fmt-ignore -->
     > [!IMPORTANT]
     > You need Two factor authentication enabled!

   Then follow the instructions from
   [this site](http://seniormars.com/posts/neomutt/).

<!-- inambiguous -->
<!-- 8. LLMs (Large Language Model): -->
<!---->
<!--    <!-- deno-fmt-ignore -->
<!--    > [!NOTE] -->
<!--    > This config uses hfc (huggingface) api by default. -->
<!---->
<!--    check: -->
<!--    - [to generate API key](https://huggingface.co/settings/tokens) -->
<!--    - [other backends](https://github.com/gsuuon/llm.nvim#providers) -->
<!--    - [more info](https://github.com/gsuuon/llm.nvim) -->
<!---->
<!--    - setup: change the config src if you want to use a different backend than -->
<!--      the default simply generate an API key from above link. Then set the -->
<!--      appropriate environment variable (HUGGINGFACE_API_KEY is the default) -->

8. Markdown-maps:

   `yarn` is required for markmap.nvim plugin
   ```sh
   yay -S yarn # AUR
   ```

## TroubleShooting

### Tree-Sitter

There is a bug in ts config which causes the tree-sitter to not install bash,
org, python parsers.

run the following command to fix it:

```vim
:TSInstall bash org python
```

In some markdown files bash scripts will give `not found (@heredoc_blabla)` like
chunky errors which you need to install bash parser like above

## Credits

- Thank you [siduck](https://github.com/siduck) for creating the wonderful
  neovim UI [NvChad](https://github.com/NvChad/NvChad)
- Thank you [folke](https://github.com/folke) for creating the excellent plugin
  manager, [lazy.nvim](https://github.com/folke/lazy.nvim)
- Thank you [sourcegraph](https://sourcegraph.com) team for the amazing
  [cody AI](https://sourcegraph.com/cody)
- Thank you all the plugin authors
- Thank you neovim dev team

---

## Terms of usage

### Discordo

Automated user accounts or "self-bots" are against Discord's Terms of Service. I
am not responsible for any loss caused by using "self-bots" or Discordo.

(See [Discordo](https://github.com/ayn2op/discordo#readme))
