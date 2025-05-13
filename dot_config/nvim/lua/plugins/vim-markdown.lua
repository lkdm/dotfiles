return {
  "preservim/vim-markdown",
  branch = "master",
  ft = { "markdown" }, -- Load only for markdown files
  dependencies = {
    "godlygeek/tabular", -- Required for vim-markdown
  },
  config = function()
    -- Add any custom configuration here, for example:
    vim.g.vim_markdown_folding_disabled = 0 -- Enable folding (default)
    vim.g.vim_markdown_conceal = 0 -- Show all markdown syntax
    vim.g.lazyredraw = 1
    vim.g.regexpengine = 1
    -- Add more vim.g.* options as needed
  end,
}
