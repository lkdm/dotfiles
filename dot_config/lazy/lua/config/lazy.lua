-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Disable compatibility with vi which can cause unexpected issues
vim.opt.compatible = false
-- Set options
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- case matters if capital letter
vim.opt.inccommand = "split" -- highlights search pattern as you type it
vim.opt.hlsearch = true -- Disable all highlighted search results
vim.opt.incsearch = true -- Enable incremental searching
vim.opt.tabstop = 4 -- Tabs = 4 spaces
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.number = true -- Turn on line numbers
vim.opt.relativenumber = true -- Turn on relative line numbers
vim.opt.signcolumn = "number" -- specify use number as sign col
vim.opt.wildmode = "longest,list"
vim.opt.cc = "80"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ttyfast = true
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8
vim.opt.lazyredraw = true
vim.opt.regexpengine = 1
vim.opt.path:append("**")
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.fileencoding = "utf-8"
-- vim.opt.clipboard = unamedplus
vim.opt.splitbelow = true -- If split, new window goes to bottom
vim.opt.splitright = true -- If split, new window goes on right

-- Undo and redo
vim.opt.undofile = true -- save undo history
local keyset = vim.keymap.set

-- Enable filetype detection, plugin, and indent
vim.cmd("filetype plugin indent on")

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Set statusline
vim.opt.statusline = "%f%m%=%y 0x%B %l:%c %p%%"
-- Ignore node_modules in wildmenu
vim.opt.wildignore:append("*node_modules*")

-- Create MakeTags command
vim.cmd("command! MakeTags !ctags -R .")

-- Netrw settings
-- Example: https://github.com/doom-neovim/doom-nvim/blob/d878cd9a69eb86ad10177d3f974410317ab9f2fe/lua/doom/modules/features/netrw/init.lua
vim.g.netrw_winsize = -22
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4444
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_localcopydircmd = "cp -r" -- default to recursive copy
vim.g.netrw_keepdir = 0

-- show directories first
vim.g.netrw_sort_sequence = [[[\/]$,*]]
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()
vim.g.netrw_list_hide = vim.g.netrw_list_hide .. ",\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"

-- Set colorscheme
-- vim.cmd("colorscheme quiet")

-- Highlight settings
vim.cmd("highlight Keyword gui=bold")
vim.cmd("highlight Comment gui=italic")
-- vim.cmd("highlight Constant guifg=#999999")
-- vim.cmd("highlight NormalFloat guibg=#333333")

-- Rust-specific settings
vim.cmd("autocmd Filetype rust set comments^=:///")

-- Fix non-standard clipboard behaviour on Mac OS
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- Skip loading a lot of the default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1

vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
