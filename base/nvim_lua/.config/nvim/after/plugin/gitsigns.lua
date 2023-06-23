local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "≃" },
		untracked = { text = "┆" },
	},
	preview_config = { border = "double" },
	watch_gitdir = { interval = 1000 },
})

local goto_hunk_cmd = function(direction)
	local unfold_and_center =
		[[if MiniAnimate ~= nil then MiniAnimate.execute_after('scroll', 'normal! zvzz') else vim.cmd('normal! zvzz') end]]
	return string.format([[<Cmd>lua require("gitsigns").%s_hunk(); %s<CR>]], direction, unfold_and_center)
end

vim.keymap.set("n", "[h", goto_hunk_cmd("prev"), { desc = "Backward hunk" })
vim.keymap.set("n", "]h", goto_hunk_cmd("next"), { desc = "Forward hunk" })
