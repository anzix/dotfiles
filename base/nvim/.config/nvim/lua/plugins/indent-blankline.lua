-- TODO: Зачем мне этот плагин если есть listchar где табы это мои направляющие?
return {
   "lukas-reineke/indent-blankline.nvim", -- Добавляет направляющие отступов ко всем строкам (включая пустые строки)
   enabled = false, -- Пока на время отключу его
   main = "ibl",
   ---@module "ibl"
   ---@type ibl.config
   opts = {},
}
