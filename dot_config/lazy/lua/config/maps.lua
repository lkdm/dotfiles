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

-- Example usage
map("n", "<leader>fd", ":Telescope live_grep search_dirs=<CR>", nil, "Live Grep in Directory")
