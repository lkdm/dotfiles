return {
  "junegunn/goyo.vim",
  cmd = { "Goyo" }, -- lazy-load when command is used
  keys = {
    { "<leader>tg", "<cmd>Goyo<cr>", desc = "Toggle Goyo writing mode" },
  },
  config = function()
    -- optional: auto behavior hooks
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoEnter",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = "80"
        vim.opt_local.signcolumn = "yes"
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
      end,
    })
  end,
}
