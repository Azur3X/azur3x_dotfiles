require("nvchad.configs.lspconfig").defaults()

local nvchad_lsp = require("nvchad.configs.lspconfig")

-- Setup Haskell Language Server
vim.lsp.config.hls = {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell", "cabal" },
  root_markers = { "*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml" },
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
}

-- Setup clangd for C/C++
vim.lsp.config.clangd = {
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    ".git",
  },
  -- Allow clangd to work on single files without project root
  single_file_support = true,
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
}

-- Setup pyright for Python
vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}

-- Enable the LSP servers
vim.lsp.enable("hls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
