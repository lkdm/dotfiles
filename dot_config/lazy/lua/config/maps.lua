local wk = require("which-key")

-- Ergonomic fn for declaring a remap
function map(mode, lhs, rhs, opts, desc)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)

	-- Document the mapping using which-key if desc is provided
	if desc then
		wk.add({
			{ lhs, rhs, desc = desc, mode = mode },
		})
	end
end

-- map("n", "<leader>e", ":lua require('config.sidebar').open_netrw_sidebar()<CR>", nil, "Open Netrw Sidebar")
map("n", "<leader>e", ":lua require('config.sidebar').toggle_netrw()<CR>", nil, "Toggle Netrw sidebar")
