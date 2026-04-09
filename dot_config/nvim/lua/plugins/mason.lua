---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "rust-analyzer",
        "omnisharp",
        "typescript-language-server",
        -- "pyright", -- install via uv tool install pyright
        "eslint-lsp",
        "stylua",
        "prettierd",
        "debugpy",
        "tree-sitter-cli",
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "folke/neoconf.nvim",
  --   },
  --   config = function()
  --     local lspconfig = require "lspconfig"
  --     local util = require "lspconfig.util"
  --
  --     lspconfig.pyright.setup {
  --       before_init = function(_, config)
  --         local root = config.root_dir
  --         if not root then return end
  --
  --         local venv_python = root .. "/.venv/bin/python"
  --         if vim.fn.executable(venv_python) == 1 then
  --           config.settings = config.settings or {}
  --           config.settings.python = config.settings.python or {}
  --           config.settings.python.pythonPath = venv_python
  --         end
  --       end,
  --       settings = {
  --         python = {
  --           analysis = {
  --             typeCheckingMode = "basic",
  --             autoSearchPaths = true,
  --             useLibraryCodeForTypes = true,
  --             diagnosticMode = "openFilesOnly",
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
}
