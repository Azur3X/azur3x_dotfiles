# Neovim Keybindings Reference

This document lists all custom keybindings configured in your Neovim setup. Leader key is `<Space>`.

## Table of Contents
- [Basic Editing](#basic-editing)
- [Window Management](#window-management)
- [Buffer Management](#buffer-management)
- [Terminal Management](#terminal-management)
- [LSP (Language Server Protocol)](#lsp-language-server-protocol)
- [Diagnostics & Errors](#diagnostics--errors)
- [Telescope Integration](#telescope-integration)
- [Trouble (Diagnostics UI)](#trouble-diagnostics-ui)
- [Session Management](#session-management)

---

## Basic Editing

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `jk` | Insert | Exit insert mode | Quick escape alternative |
| `;` | Normal | Enter command mode | Types `:` for you |
| `<C-s>` | Normal/Insert/Visual | Save file | Quick save |
| `<leader>h` | Normal | Clear search highlights | Remove search highlighting |

### Visual Mode Improvements

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<` | Visual | Decrease indent | Stays in visual mode after indent |
| `>` | Visual | Increase indent | Stays in visual mode after indent |
| `p` | Visual | Paste without yanking | Paste without overwriting your register |

---

## Window Management

### Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h>` | Normal | Move to left window | Navigate windows with Ctrl+hjkl |
| `<C-j>` | Normal | Move to bottom window | |
| `<C-k>` | Normal | Move to top window | |
| `<C-l>` | Normal | Move to right window | |

### Resizing

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-Up>` | Normal | Increase height | Make window taller |
| `<C-Down>` | Normal | Decrease height | Make window shorter |
| `<C-Left>` | Normal | Decrease width | Make window narrower |
| `<C-Right>` | Normal | Increase width | Make window wider |

---

## Buffer Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<S-l>` | Normal | Next buffer | Shift+L to go forward |
| `<S-h>` | Normal | Previous buffer | Shift+H to go back |

---

## Terminal Management

### Opening Terminals

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>th` | Normal | Horizontal terminal | Opens terminal in horizontal split |
| `<leader>tv` | Normal | Vertical terminal | Opens terminal in vertical split |
| `<C-\>` | Normal/Terminal | Toggle terminal | ToggleTerm floating/horizontal |
| `<leader>tf` | Normal | Floating terminal | ToggleTerm in floating window |

### Terminal Mode Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Esc><Esc>` | Terminal | Exit terminal mode | Return to normal mode |
| `<C-h>` | Terminal | Move to left window | Navigate from terminal without exiting |
| `<C-j>` | Terminal | Move to bottom window | |
| `<C-k>` | Terminal | Move to top window | |
| `<C-l>` | Terminal | Move to right window | |

---

## LSP (Language Server Protocol)

All LSP features work with **Haskell**, **C/C++**, and **Python** files.

### Documentation & Information

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `K` | Normal | **Hover documentation** | Show docs for symbol under cursor |
| `<C-k>` | Normal | Signature help | Show function signature while typing |
| `<leader>D` | Normal | Type definition | Jump to type definition |

### Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to where symbol is defined |
| `gD` | Normal | Go to declaration | Jump to declaration (headers in C/C++) |
| `gi` | Normal | Go to implementation | Jump to implementation |
| `gr` | Normal | Find references | Show all references to symbol |

### Code Actions

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ca` | Normal/Visual | Code action | Show available code actions (auto-import, quick fixes) |
| `<leader>ra` | Normal | Rename symbol | Rename symbol across project (basic) |
| `<leader>rn` | Normal | Incremental rename | Rename with live preview (inc-rename) |
| `<leader>fm` | Normal | Format code | Format current buffer using LSP |

---

## Diagnostics & Errors

### Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `[d` | Normal | Previous diagnostic | Jump to previous error/warning |
| `]d` | Normal | Next diagnostic | Jump to next error/warning |
| `[e` | Normal | Previous error | Jump to previous error only |
| `]e` | Normal | Next error | Jump to next error only |

### Display

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>e` | Normal | Show diagnostic float | Show error/warning details in popup |
| `<leader>q` | Normal | Diagnostic location list | Open diagnostics in quickfix list |

---

## Telescope Integration

Fuzzy finding for LSP features.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ls` | Normal | Document symbols | Fuzzy search symbols in current file |
| `<leader>lw` | Normal | Workspace symbols | Fuzzy search symbols across workspace |
| `<leader>ld` | Normal | Diagnostics | Fuzzy search all diagnostics |

**NvChad Default Telescope Keybindings:**
- `<leader>ff` - Find files
- `<leader>fa` - Find all files (including hidden)
- `<leader>fw` - Live grep (search text)
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files (recent)
- `<leader>fz` - Find in current buffer
- `<leader>cm` - Git commits
- `<leader>gt` - Git status
- `<leader>pt` - Pick hidden term
- `<leader>th` - Themes

---

## Trouble (Diagnostics UI)

Modern diagnostics viewer with better UX than quickfix.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>xx` | Normal | Toggle diagnostics | Show all diagnostics in workspace |
| `<leader>xX` | Normal | Buffer diagnostics | Show diagnostics for current buffer only |
| `<leader>xs` | Normal | Symbols | Document symbols viewer |
| `<leader>xl` | Normal | LSP definitions/refs | LSP definitions and references |
| `<leader>xL` | Normal | Location list | Open location list in Trouble |
| `<leader>xQ` | Normal | Quickfix list | Open quickfix list in Trouble |

---

## Session Management

Automatic session persistence (from persistence.nvim).

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>qs` | Normal | Restore session | Restore session for current directory |
| `<leader>ql` | Normal | Restore last session | Restore last session |
| `<leader>qd` | Normal | Don't save session | Don't save current session on exit |

---

## Quick Reference Card

### Most Important Keybindings

```
🔍 SEARCH & NAVIGATE
  <leader>ff   Find files
  <leader>fw   Search text (live grep)
  gd           Go to definition
  gr           Find references
  K            Hover docs (SHIFT+K)

⚠️  ERRORS & DIAGNOSTICS
  ]d           Next diagnostic
  [d           Previous diagnostic
  ]e           Next error only
  [e           Previous error only
  <leader>xx   Open Trouble diagnostics

✏️  CODE EDITING
  <leader>ca   Code actions
  <leader>rn   Rename (with preview)
  <leader>fm   Format code

💻 TERMINAL
  <leader>th   Horizontal terminal
  <leader>tv   Vertical terminal
  <C-\>        Toggle terminal
  <Esc><Esc>   Exit terminal mode

🪟 WINDOWS
  <C-h/j/k/l>  Navigate windows
  <C-arrows>   Resize windows
  <S-h/l>      Previous/Next buffer
```

---

## LSP Server Status

Check if LSP is running:
```vim
:LspInfo         " Show attached LSP clients
:LspRestart      " Restart LSP if issues occur
```

View Mason-installed servers:
```vim
:Mason           " Open Mason UI for LSP management
```

---

## Tips

1. **Hover twice**: Press `K` twice to jump into the hover window for scrolling
2. **Code actions**: Use `<leader>ca` frequently - it shows auto-imports, quick fixes, refactorings
3. **Diagnostic navigation**: Use `]e` / `[e` to jump only to errors, skipping warnings
4. **Telescope is your friend**: Most things are easier with Telescope fuzzy finding
5. **Terminal workflow**: Use `<C-\>` for quick terminal, `<Esc><Esc>` to exit
6. **Trouble for overview**: Use `<leader>xx` to see all errors/warnings at once

---

## Language-Specific Notes

### C/C++ (clangd)
- `gD` is especially useful for jumping to headers
- Code actions include auto-import, header generation
- Requires `compile_commands.json` for best results

### Python (pyright)
- Type checking shows inline with diagnostics
- Auto-import available via code actions
- Works best with virtual environments

### Haskell (HLS)
- Rich type information with `K`
- Code actions for adding imports, case splits
- Signature help very useful for complex types

---

*Generated for NvChad v2.5 configuration*
