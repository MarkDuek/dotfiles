# Neovim config

Lua-based Neovim config managed with `lazy.nvim`.

Leader is `Space`.
Local leader is `\`.

## Plugins

Plugin specs live in `.config/nvim/lua/plugins/`.

| Plugin | Purpose |
| --- | --- |
| `folke/lazy.nvim` | Plugin manager |
| `nvim-telescope/telescope.nvim` | Fuzzy finder, grep, buffers, symbols, marks |
| `nvim-lua/plenary.nvim` | Shared Lua dependency for plugins |
| `nvim-neo-tree/neo-tree.nvim` | File tree |
| `MunifTanjim/nui.nvim` | Neo-tree UI dependency |
| `nvim-tree/nvim-web-devicons` | File icons |
| `ThePrimeagen/harpoon` | Fast project file marks/navigation |
| `neovim/nvim-lspconfig` | LSP client setup |
| `williamboman/mason.nvim` | External tool installer |
| `williamboman/mason-lspconfig.nvim` | Mason integration for LSP servers |
| `nvimtools/none-ls.nvim` | Formatting/linting integration |
| `nvimtools/none-ls-extras.nvim` | Extra none-ls sources |
| `jayp0521/mason-null-ls.nvim` | Mason integration for none-ls |
| `saghen/blink.cmp` | Completion engine |
| `rafamadriz/friendly-snippets` | Snippet collection |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting and indentation |
| `numToStr/Comment.nvim` | Comment toggling |
| `kylechui/nvim-surround` | Add/change/delete surrounding pairs |
| `folke/todo-comments.nvim` | Highlight and search TODO-style comments |
| `github/copilot.vim` | GitHub Copilot suggestions |
| `echasnovski/mini.nvim` | Mini statusline |
| `jpalardy/vim-slime` | Send code to tmux |
| `lervag/vimtex` | LaTeX editing |
| `sphamba/smear-cursor.nvim` | Cursor animation, currently disabled |
| `catppuccin/nvim` | Theme |
| `rebelot/kanagawa.nvim` | Theme |
| `vague2k/vague.nvim` | Theme |
| `jnurmine/Zenburn` | Theme |
| `RRethy/base16-nvim` | Theme |

Configured LSP servers:

| Server | Notes |
| --- | --- |
| `lua_ls` | Lua |
| `pyright` | Python type checking, using `pyenv which python` when available |
| `ruff` | Python linting; hover disabled in favor of Pyright |
| `clangd` | C/C++; installed through Mason |

Configured formatters:

| Tool | Source |
| --- | --- |
| `ruff` | Import sorting via `--extend-select I` |
| `ruff_format` | Python formatting |

Treesitter parsers:

`bash`, `c`, `cpp`, `lua`, `markdown`, `markdown_inline`, `python`, `vim`, `vimdoc`

## Keybind Cheat Sheet

### Core

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>pv` | Open netrw file explorer |
| Normal | `<leader>w` | Write current buffer |
| Normal | `<leader>qq` | Quit current window |
| Normal | `<leader>h` | Clear search highlight |
| Normal | `<C-d>` | Half-page down and center cursor |
| Normal | `<C-u>` | Half-page up and center cursor |
| Normal/Visual | `<leader>y` | Yank selection/text to system clipboard |
| Normal | `<leader>Y` | Yank current line to system clipboard |

### Buffers

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>n` | Next buffer |
| Normal | `<leader>p` | Previous buffer |
| Normal | `<leader>x` | Delete buffer |
| Normal | `<leader>ml` | Switch to alternate buffer |

### Search and Navigation

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<C-p>` | Telescope find files |
| Normal | `<C-f>` | Telescope live grep |
| Normal | `<C-s>` | Telescope document symbols |
| Normal | `<leader>fh` | Telescope help tags |
| Normal | `<leader>fb` | Telescope buffers |
| Normal | `<leader>dt` | Telescope colorschemes |
| Normal | `<leader>fm` | Telescope marks |
| Normal | `<leader>e` | Toggle Neo-tree and reveal current file |

### Harpoon

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>a` | Add current file to Harpoon |
| Normal | `<C-e>` | Toggle Harpoon quick menu |
| Normal | `<C-h>` | Jump to Harpoon file 1 |
| Normal | `<C-j>` | Jump to Harpoon file 2 |
| Normal | `<C-k>` | Jump to Harpoon file 3 |
| Normal | `<C-l>` | Jump to Harpoon file 4 |
| Normal | `<C-S-P>` | Previous Harpoon file |
| Normal | `<C-S-N>` | Next Harpoon file |

### LSP

These are available after an LSP server attaches to the buffer.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gd` | Go to definition |
| Normal | `grn` | Rename symbol |
| Normal/Visual | `gra` | Code action |
| Normal | `grr` | References |
| Normal | `gri` | Implementation |
| Normal | `gO` | Document symbols |
| Normal | `gld` | Format buffer |
| Insert | `<C-S>` | Signature help |
| Normal | `]g` | Next diagnostic |
| Normal | `[g` | Previous diagnostic |

### Completion and Copilot

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<C-Space>` | Open completion menu or docs |
| Insert | `<C-y>` | Accept selected completion |
| Insert | `<C-n>` | Next completion item |
| Insert | `<C-p>` | Previous completion item |
| Insert | `<C-e>` | Hide completion menu |
| Insert | `<C-k>` | Toggle signature help |
| Insert | `<S-Tab>` | Jump backward in snippet |
| Insert | `<Tab>` | Accept Copilot suggestion |

### TODO Comments

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>ff` | Open TODO quickfix list |
| Normal | `<leader>ft` | Search TODOs with Telescope |

### Plugin Defaults Worth Remembering

These come from plugin defaults rather than custom mappings in this config.

| Plugin | Key | Action |
| --- | --- | --- |
| Comment.nvim | `gcc` | Toggle current line comment |
| Comment.nvim | `gc` | Toggle comment for a visual selection/operator |
| nvim-surround | `ys` | Add surrounding pair |
| nvim-surround | `ds` | Delete surrounding pair |
| nvim-surround | `cs` | Change surrounding pair |
| vim-slime | `<C-c><C-c>` | Send selection/current paragraph to tmux target |
| VimTeX | `\ll` | Compile/toggle LaTeX build |
| VimTeX | `\lv` | View compiled PDF |
