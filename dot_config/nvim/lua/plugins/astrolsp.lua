-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      filter = function(client)
        if client.name == "eslint" then return false end
        if client.name == "tsserver" then return false end
        if client.name == "ts_ls" then return false end
        return true
      end,
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   -- "go",
        -- },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
        "pyright",
      },
      timeout_ms = 1000, -- default format timeout
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "ionide",
      -- "dartls",
      -- "haskell-tools.nvim",
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        on_attach = function(client, bufnr)
          -- Check if organize imports is already attached
          if vim.b[bufnr].organize_imports_attached then return end
          -- Move the organize imports function here
          local function organizeImports()
            local params = {
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(bufnr) },
              title = "Organize Imports",
            }

            client.request_sync("workspace/executeCommand", params, 1000, bufnr)
          end

          -- Run organize imports before other formatters
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              organizeImports()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(c) return c.name == "null-ls" end,
              }
            end,
          })
          vim.b[bufnr].organize_imports_attached = true
        end,
      },
      eslint = {
        root_dir = require("lspconfig.util").root_pattern(
          ".eslintrc.js",
          ".eslintrc.json",
          ".eslintrc.yml",
          ".eslintrc.yaml",
          ".eslintrc",
          ".git",
          "/home/roblarnach/Documents/TriOnline/typescript/config/base.eslintrc"
        ),
      },
      eslint_d = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_dir = require("lspconfig.util").root_pattern(
          ".eslintrc.js",
          "base.eslintrc",
          ".eslintrc.json",
          ".eslintrc.yml",
          ".eslintrc.yaml",
          ".eslintrc",
          ".git",
          "/home/roblarnach/Documents/TriOnline/typescript/config/base.eslintrc"
        ),
      },
      -- rust_analyzer = {
      --   init_options = {
      --     cargo = {
      --       features = { "ssr", "csr", "hydrate" },
      --     },
      --     procMacro = { ignored = { leptos_macro = { "server" } } },
      --   },
      -- },
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt_global.expandtab = false
      vim.bo.tabstop = 4
      vim.bo.expandtab = false
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
      -- -- this would disable semanticTokensProvider for all clients
      -- -- client.server_capabilities.semanticTokensProvider = nil
      -- if client.name == "tsserver" or client.name == "ts_ls" then
      --   -- Check if organize imports is already attached
      --   if vim.b[bufnr].organize_imports_attached then return end
      --   -- Move the organize imports function here
      --   local function organizeImports()
      --     local params = {
      --       command = "_typescript.organizeImports",
      --       arguments = { vim.api.nvim_buf_get_name(bufnr) },
      --       title = "Organize Imports",
      --     }
      --
      --     client.request_sync("workspace/executeCommand", params, 1000, bufnr)
      --   end
      --
      --   -- Run organize imports before other formatters
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     buffer = bufnr,
      --     callback = function()
      --       organizeImports()
      --       vim.lsp.buf.format {
      --         bufnr = bufnr,
      --         filter = function(c) return c.name == "null-ls" end,
      --       }
      --     end,
      --   })
      --   vim.b[bufnr].organize_imports_attached = true
      -- end
    end,
  },
}
