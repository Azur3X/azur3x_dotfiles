# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on top of **NvChad v2.5**, a modular Neovim configuration framework. The setup follows NvChad's lazy-loading architecture using lazy.nvim as the plugin manager.

## Architecture

### Bootstrap & Entry Point (init.lua:1-37)

The configuration follows a specific initialization order:

1. **Base46 cache setup** - Theme system initialization
2. **Lazy.nvim bootstrap** - Auto-installs plugin manager if missing
3. **Plugin loading** - Loads NvChad core + custom plugins from `lua/plugins/`
4. **Theme application** - Applies cached theme files (defaults & statusline)
5. **Core modules** - Loads options, autocmds, and mappings (mappings are scheduled)

### Directory Structure

```
~/.config/nvim/
├── init.lua              # Bootstrap & initialization sequence
├── lua/
│   ├── options.lua       # Vim options (extends nvchad.options)
│   ├── mappings.lua      # Custom keymaps (extends nvchad.mappings)
│   ├── autocmds.lua      # Autocommands (extends nvchad.autocmds)
│   ├── chadrc.lua        # NvChad configuration (theme, UI settings)
│   ├── configs/          # Plugin configurations
│   │   ├── lazy.lua      # Lazy.nvim settings & disabled plugins
│   │   ├── lspconfig.lua # LSP server configurations
│   │   └── conform.lua   # Formatter configurations
│   └── plugins/          # Plugin specifications
│       ├── init.lua      # Core plugin list
│       ├── toogleterm.lua   # Terminal emulator plugin
│       └── persistence.lua  # Session management plugin
└── .stylua.toml          # Lua formatter settings
```

### Configuration Philosophy

- **Extends, not replaces**: All custom configs extend NvChad defaults via `require "nvchad.<module>"`
- **Lazy-loading**: Plugins use lazy-loading patterns (events, commands, keys) for performance
- **Modular**: Each plugin has its own file in `lua/plugins/` that returns a lazy.nvim spec

## Key Components

### Plugin System

Plugins are loaded through lazy.nvim with this import pattern (init.lua:17-26):
- NvChad core plugins via `import = "nvchad.plugins"`
- Custom plugins via `import = "plugins"` (loads all files in lua/plugins/)

### LSP Configuration (configs/lspconfig.lua)

Currently configured servers:
- **Haskell Language Server (hls)** - Full support for Haskell, Literate Haskell, and Cabal files (lspconfig.lua:8-13)
- **clangd** - C/C++ language server with clang-tidy integration, smart header insertion, and detailed completions (lspconfig.lua:15-28)
- **pyright** - Python language server with workspace diagnostics and basic type checking (lspconfig.lua:30-44)

To add new LSP servers, follow the pattern in `lua/configs/lspconfig.lua`:
```lua
lspconfig.<server_name>.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- server-specific options
})
```

### Formatters (configs/conform.lua)

Active formatters:
- **stylua** for Lua files (settings in .stylua.toml: 2-space indent, 120 col width, Unix line endings)

Format-on-save is currently disabled but can be enabled by uncommenting lines 8-12 in conform.lua.

### Terminal Configuration

Two terminal solutions are configured:

1. **Built-in terminal** (mappings.lua:13-23)
   - `<leader>th` - horizontal split terminal
   - `<leader>tv` - vertical split terminal
   - `<Esc><Esc>` - exit terminal mode
   - `<C-h/j/k/l>` - navigate from terminal to other windows

2. **ToggleTerm plugin** (plugins/toogleterm.lua)
   - `<C-\>` - toggle terminal
   - `<leader>tf` - floating terminal
   - `<leader>th` - horizontal terminal
   - `<leader>tv` - vertical terminal
   - Shell: `/usr/sbin/fish`

Terminal autocmds (autocmds.lua:7-25):
- Auto-enter insert mode on terminal open/enter
- Disable line numbers and sign column in terminal buffers

### Session Management (plugins/persistence.lua)

Sessions are automatically saved to `~/.local/state/nvim/sessions/`:
- `<leader>qs` - Restore session for current directory
- `<leader>ql` - Restore last session
- `<leader>qd` - Don't save current session on exit

### Custom Keymaps

Notable custom mappings (mappings.lua):
- `;` → `:` (enter command mode)
- `jk` → `<ESC>` in insert mode

## Development Commands

### Code Formatting

Format Lua files using stylua:
```bash
stylua lua/ init.lua
```

### Testing Configuration

Reload configuration changes:
```vim
:source ~/.config/nvim/init.lua
```

Or restart Neovim to fully reload the config including plugins.

### Plugin Management

```vim
:Lazy         " Open lazy.nvim UI
:Lazy sync    " Update plugins
:Lazy clean   " Remove unused plugins
:Lazy profile " Profile startup time
```

### LSP Management

NvChad provides Mason integration for installing LSP servers, but this config directly configures servers via lspconfig. Check available LSP commands:
```vim
:LspInfo      " Show active LSP clients
:LspRestart   " Restart LSP clients
```

## Adding New Components

### Adding a Plugin

1. Create a new file in `lua/plugins/<plugin-name>.lua`
2. Return a lazy.nvim plugin spec table:
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- or cmd, keys, ft, etc.
  opts = {
    -- plugin options
  },
}
```
3. Restart Neovim or run `:Lazy reload`

### Adding an LSP Server

Edit `lua/configs/lspconfig.lua`:
```lua
lspconfig.<server>.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- server-specific settings
})
```

### Adding a Formatter

Edit `lua/configs/conform.lua` and add to `formatters_by_ft`:
```lua
formatters_by_ft = {
  lua = { "stylua" },
  python = { "black" },  -- example
}
```

## Theme Configuration

Current theme: **onedark** (chadrc.lua:9)

To change themes, edit `lua/chadrc.lua` and set `M.base46.theme` to any NvChad-supported theme. Available themes can be viewed with `:Telescope themes`.

## Performance Optimizations

Lazy.nvim is configured to disable many default Vim plugins (configs/lazy.lua:16-44) including netrw, matchit, tar, zip, and others for faster startup.
