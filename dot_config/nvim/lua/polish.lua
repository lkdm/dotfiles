-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- Line wrapping in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
    vim.opt_local.wrapmargin = 0
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_au"
    vim.opt_local.conceallevel = 2
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
vim.opt.cmdheight = 1 -- Make notifications 2 lines

-- My functions
--
--
-- Prose
local ns_id = vim.api.nvim_create_namespace "prose-mode"
local prose_mode_enabled = false

local function update_visual_indent(buf)
  vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
  if not prose_mode_enabled then return end
  for i = 0, vim.api.nvim_buf_line_count(buf) - 1 do
    vim.api.nvim_buf_set_extmark(buf, ns_id, i, 0, {
      virt_text = { { "  ", "NonText" } },
      virt_text_pos = "inline",
      hl_mode = "combine",
    })
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TextChanged", "TextChangedI", "InsertLeave" }, {
  callback = function(args) update_visual_indent(args.buf) end,
})

vim.api.nvim_create_user_command("ToggleProseMode", function()
  prose_mode_enabled = not prose_mode_enabled
  local buf = vim.api.nvim_get_current_buf()
  update_visual_indent(buf)
  if prose_mode_enabled then
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.breakindentopt = { "shift:-2" }
    vim.cmd "vertical resize 80"
    vim.notify "Prose mode ON"
  else
    vim.opt_local.linebreak = false
    vim.opt_local.breakindent = false
    vim.opt_local.breakindentopt = {}
    vim.notify "Prose mode OFF"
  end
end, {})

-- Chezmoi syntax highlighting passthrough
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function(args)
    local filename = vim.fn.expand "<afile>"
    -- Hardcoded file-to-filetype map for specific tmpl files without extensions
    local special_map = {
      ["dot_profile.tmpl"] = "bash",
      ["dot_zprofile"] = "zsh",
      ["dot_zaliases"] = "zsh",
      ["dot_zfunctions"] = "zsh",
      ["dot_zshrc"] = "zsh",
      [".*/git/config%.tmpl$"] = "gitconfig",
      -- add other explicit mappings here
    }

    if special_map[filename] then
      vim.bo.filetype = special_map[filename]
      return
    end

    -- General handler for *.*.tmpl files (e.g. config.toml.tmpl)
    if filename:match ".+%..+%.tmpl$" then
      local ft = filename:match "^.+%.(.+)%.tmpl$"
      if ft then vim.bo.filetype = ft end
    end
  end,
})
