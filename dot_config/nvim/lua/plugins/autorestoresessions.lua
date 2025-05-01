-- function for calculating the current session name
local get_session_name = function()
  local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t:r") -- Remove special chars
  local branch = vim.trim(vim.fn.system "git branch --show-current 2>/dev/null")
  branch = branch:gsub("[^%w%-]", "_") -- Sanitize branch names
  return (branch ~= "") and ("%s_%s"):format(name, branch) or name
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    sessions = {
      -- disable the auto-saving of directory sessions
      autosave = { cwd = false },
    },
    mappings = {
      n = {
        -- update save dirsession mapping to get the correct session name
        ["<Leader>SS"] = {
          function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        },
        -- update load dirsession mapping to get the correct session name
        ["<Leader>S."] = {
          function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        },
      },
    },
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      git_branch_sessions = {
        -- auto save directory sessions on leaving
        {
          event = "VimLeavePre",
          desc = "Save git branch directory sessions on close",

          callback = vim.schedule_wrap(function()
            -- Clean invalid buffers before saving
            vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })

            if require("astrocore.buffer").is_valid_session() then
              require("resession").save(get_session_name(), {
                dir = "dirsession",
                notify = false,
                filter = function(buf)
                  return vim.api.nvim_buf_is_valid(buf)
                    and vim.bo[buf].buflisted
                    and vim.api.nvim_buf_get_name(buf) ~= ""
                end,
              })
            end
          end),
        },
        -- auto restore previous previous directory session, remove if necessary
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open

          callback = function()
            if vim.fn.argc(-1) == 0 then
              local session_name = get_session_name()
              -- Use list() instead of exists()
              local sessions = require("resession").list { dir = "dirsession" }
              local session_exists = vim.tbl_contains(sessions, session_name)

              if session_exists then
                local ok, err = pcall(function()
                  require("resession").load(session_name, {
                    dir = "dirsession",
                    silence_errors = true,
                    filter = function(buf) return vim.api.nvim_buf_is_loaded(buf) end,
                  })
                end)
                if ok then vim.cmd "bufdo e" end
              end
            end
          end,
        },
      },
    },
  },
}
