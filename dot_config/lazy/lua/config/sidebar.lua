-- config/sidebar.lua
local M = {}

function M.toggle_netrw()
	local flag = false
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local e, v = pcall(function()
			return vim.api.nvim_buf_get_var(buf, "current_syntax")
		end)
		if
			(e and v == "netrwlist")
			and not vim.api.nvim_buf_get_option(buf, "modified")
			and vim.api.nvim_buf_is_loaded(buf)
		then
			flag = true
			vim.api.nvim_buf_delete(buf, {})
		end
	end
	if not flag then
		vim.cmd(":Lexplore")
	end
end

-- function M.open_netrw_sidebar()
-- 	-- Check if the current buffer is a netrw buffer
-- 	if vim.bo.filetype == "netrw" then
-- 		-- Close the current buffer
-- 		vim.cmd("bdelete")
-- 	else
-- 		-- Check if a netrw buffer is already open in another window
-- 		local netrw_bufnr = vim.fn.bufnr("^Netrw")
-- 		if netrw_bufnr ~= -1 then
-- 			-- Close the existing netrw buffer
-- 			vim.cmd("bdelete " .. netrw_bufnr)
-- 		end
--
-- 		-- Open a new vertical split on the left and start netrw
-- 		vim.cmd("leftabove vsplit")
-- 		vim.cmd("Ex")
-- 	end
-- end

return M
