-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
-- if is_vscode then return {
--   "AstroNvim/astrocommunity",
--   { import = "astrocommunity.recipes.disable-tabline" },
-- } end
---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  -- import/override with your plugins folder
}
