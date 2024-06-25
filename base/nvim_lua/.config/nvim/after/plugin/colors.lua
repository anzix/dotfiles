local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
  return
end


tokyonight.setup({
	style = "moon",
    transparent = true
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Делает neovim прозрачным
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" }) -- nvim-gitgutter прозрачная линия
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Прозрачное окно буффера
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" }) -- Прозрачная Debugger панель codelldb
-- vim.api.nvim_set_hl(0, "CursorLine", { blend = 0 }) -- background of dressing of nvim input prompt?
