require('tokyonight').setup({
    transparent = true
})

function ColorFix(color)
	color = color or "tokyonight-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Делает neovim прозрачным
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" }) -- nvim-gitgutter прозрачная линия
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Прозрачное окно буффера
end

ColorFix()
