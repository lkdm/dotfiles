-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

local is_vscode = pcall(require, "vscode")
if not is_vscode then
  vim.g.everforest_background = "hard"
  vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
  })
  vim.g.copilot_no_tab_map = true
else
  -- vim.opt.clipboard = "unnamedplus"
  require("lazy").setup {
    { "mg979/vim-visual-multi" },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup {
          -- Configuration here, or leave empty to use defaults
        }
      end,
    },
  }
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
  end,
})

vim.opt.termguicolors = true
vim.opt.scrolloff = 12
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt_global.expandtab = false
vim.bo.tabstop = 4
vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
