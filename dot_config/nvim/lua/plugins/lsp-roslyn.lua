if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Fix: goto definition does not work
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.cs",
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "roslyn" then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    end
  end,
})

return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  opts = {},
}
