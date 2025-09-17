-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "rust-analyzer",
        "omnisharp", -- Omnisharp does not work through Mason, use plugins/lsp-roslyn.lua
        "typescript-language-server",
        "pyright",
        -- "gopls", -- Cannot get this one to install for some reason

        -- install formatters
        "stylua",
        "prettierd",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },

  -- WARN: goto definition not working? try commenting this block out
  require("lspconfig").rust_analyzer.setup {
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
          allFeatures = true, -- merged "features = 'all'" and "allFeatures = true"
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
          enable = true, -- enabled for better macro support
          -- ignored = { ... }            -- optionally add ignored proc macros here
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
  },
}
