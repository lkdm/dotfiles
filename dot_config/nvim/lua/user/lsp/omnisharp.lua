-- ~/.config/nvim/lua/user/lsp/config/omnisharp.lua

return {
  cmd = {
    -- Use the absolute path to the OmniSharp binary installed by Mason,
    -- or the path to your manually downloaded OmniSharp executable.
    -- Example for Mason on Unix:
    "/var/home/luke/.local/bin/omnisharp",
    "--languageserver",
    -- Optional: add other supported arguments
    -- "--hostPID", tostring(vim.fn.getpid()),
    -- "--encoding", "utf-8"
  },
  filetypes = { "cs", "vb" },
  init_options = {},
  root_markers = { ".sln", ".csproj", "omnisharp.json", "function.json" },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    },
    MsBuild = {},
    RenameOptions = {},
    RoslynExtensionsOptions = {},
    Sdk = {
      IncludePrereleases = true,
    },
  },
  capabilities = {
    workspace = {
      workspaceFolders = false,
    },
  },
}
