-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter
local is_vscode = pcall(require, "vscode")
if is_vscode then return {} end
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not is_vscode,
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "go",
      -- "ocaml",
      "rust",
      "typescript",
      -- "haskell",
      "sql",
      -- add more arguments for adding more treesitter parsers
    })
    -- opts.indent = { disable = { "python" } }
  end,
}
