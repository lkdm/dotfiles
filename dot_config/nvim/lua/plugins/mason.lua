-- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Must be run before lspconfig setups
require("neoconf").setup()

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "rust-analyzer",
        "omnisharp", -- does not work through Mason, see plugins/lsp-roslyn.lua
        "typescript-language-server",
        "pyright",

        -- linters
        "eslint-lsp",

        -- formatters
        "stylua",
        "prettierd",

        -- debuggers
        "debugpy",

        -- other tools
        "tree-sitter-cli",
      },
    },
  },

  -- configure lspconfig (including rust-analyzer)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      -- WARN: if goto definition not working, try commenting this out
      lspconfig.rust_analyzer.setup {
        settings = {
          ["rust-analyzer"] = {
            server = {
              extraEnv = {
                ["CHALK_OVERFLOW_DEPTH"] = "100000000",
                ["CHALK_SOLVER_MAX_SIZE"] = "100000000",
              },
            },
            lru = {
              capacity = 64,
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = {
              enable = true,
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            files = {
              excludeDirs = { "target", "tests" },
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
}
