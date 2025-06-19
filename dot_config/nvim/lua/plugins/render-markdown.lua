-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local enable_prose = os.getenv "ENABLE_PROSE" == 1

return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = enable_prose,
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    paragraph = {
      enabled = true,
      left_margin = 4,
    },
  },
}
