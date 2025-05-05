-- Turns a TSV snippet into a Markdown table
local function tsv_to_markdown_table()
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Process rows and count columns
  local column_count = 0
  local processed = {}
  for i, line in ipairs(lines) do
    local row = "| " .. line:gsub("\t", " | ") .. " |"
    if i == 1 then column_count = select(2, line:gsub("\t", "\t")) + 1 end
    table.insert(processed, row)
  end

  -- Generate proper separator line
  local separator = "|" .. (" :--- |"):rep(column_count)
  separator = separator:gsub(" :--- |$", " :---|") -- Fix last column

  -- Insert separator after header
  table.insert(processed, 2, separator)

  -- Replace buffer content
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, processed)
end

-- Turns multi lined string into an ordered list
local function markdown_ordered_list()
  vim.cmd [[
    %s/^/1. /g
    %s/^\%(1\. .*\n\)\+/\=map(split(submatch(0), '\n'), {i,v->substitute(v,'^1\.',i+1.'.','')})->join("\n")."\n"/g
  ]]
end

-- Find in directory functions
local function get_neotree_selected_path()
  -- Try to get the Neo-tree state for the current tab
  local ok, manager = pcall(require, "neo-tree.sources.manager")
  if not ok or not manager then return nil end
  local state = manager.get_state("filesystem", vim.api.nvim_get_current_tabpage())
  if not state or not state.tree then return nil end
  local node = state.tree:get_node()
  if not node then return nil end
  return node.type == "directory" and node:get_id() or vim.fn.fnamemodify(node:get_id(), ":h")
end

local function find_word_in_dir()
  local path = get_neotree_selected_path()
  if not path then
    -- fallback: use current file's directory
    path = vim.fn.expand "%:p:h"
  end
  require("telescope.builtin").live_grep { search_dirs = { path } }
end

local function find_file_in_dir()
  local path = get_neotree_selected_path()
  if not path then
    -- fallback: use current file's directory
    path = vim.fn.expand "%:p:h"
  end
  require("telescope.builtin").find_files { search_dirs = { path } }
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { desc = "Buffers" },

          ["<Leader>fd"] = { desc = "Find in directory..." },
          ["<Leader>fdw"] = { find_word_in_dir, desc = "Find word in directory" },
          ["<Leader>fdf"] = { find_file_in_dir, desc = "Find file in directory" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          ["<Leader>O"] = { desc = "Obsidian" },
          ["<Leader>Od"] = { ":ObsidianToggleCheckbox<CR>", desc = "Toggle checkbox" },
          ["<Leader>Of"] = { ":ObsidianQuickSwitch<CR>", desc = "Open a note by filename" },
          ["<Leader>Ow"] = { ":ObsidianSearch<CR>", desc = "Search notes" },
          ["<Leader>On"] = { ":ObsidianNew ", desc = "New note" },
          ["<Leader>Ot"] = { ":ObsidianToday<CR>", desc = "Today's note" },

          -- Opens or creates a TMS note for a given branch
          ["<Leader>OT"] = {
            function()
              -- Get current branch safely
              local branch = vim.fn.system("git branch --show-current"):gsub("%s+", "")

              -- Strict pattern matching
              local tms = branch:match "^dev/[^/]+/([^/]+)$"

              if not tms then
                vim.notify("❌ Not a valid TMS branch: " .. branch, vim.log.levels.ERROR)
                return
              end

              -- Option 1: Using command with explicit path
              vim.cmd(("ObsidianNew company/tms/tms-%s.md"):format(tms))

              -- Option 2: Using API (preferred)
              -- local ok, obsidian = pcall(require, "obsidian")
              -- if ok then
              --   obsidian.new_note({ id = tms, dir = "company/tms" })
              -- else
              --   vim.notify("Obsidian.nvim not loaded", vim.log.levels.ERROR)
              -- end
            end,
            desc = "TMS note from branch",
          },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = { -- Visual mode
          ["<Leader>m"] = { desc = "Markdown" },
          ["<leader>mt"] = { tsv_to_markdown_table, desc = "Convert TSV table" },
          ["<Leader>mo"] = { markdown_ordered_list, desc = "Create ordered list" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
