-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.diagnostic.config {
  -- Only update diagnostics when leaving insert mode or after a delay
  update_in_insert = false,
  -- This is the "Debounce" equivalent for the display logic
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  severity_sort = true,
}

-- 2. Apply a universal debounce to ALL servers
-- local lspconfig = require("lspconfig")

-- -- Safely get capabilities from nvim-cmp if it exists
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if status_ok then
--   capabilities = cmp_nvim_lsp.default_capabilities()
-- end

-- -- This is the list of servers you use
-- local servers = { "rust_analyzer", "vtsls", "bashls", "lua_ls" }

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     capabilities = capabilities,
--     flags = {
--       debounce_text_changes = 500,
--     },
--   }
-- end

require "lazy_setup"
require "polish"
