return {
   -- Вы можете легко перейти на другую цветовую схему.
   -- Измените имя плагина цветовой схемы ниже, а затем измените
   -- vim.cmd('colorscheme <name_colorscheme>') команду в конфигурации.
   --
   -- Если вы хотите увидеть, какие цветовые схемы уже установлены, вы можете использовать `:Telescope colorscheme`
   "folke/tokyonight.nvim", -- Цветовая схема
   lazy = false,            -- Убедиться, что мы загружаем это во время запуска, если это ваша основная цветовая схема
   priority = 1000,         -- Обязательно загрузите его перед всеми остальными стартовыми плагинами
   opts = {
      transparent = true,
   },
   -- Вызов специфичных пользовательских параметров
   config = function()

      -- Глобальное выставление цветовой схемы
      vim.cmd('colorscheme tokyonight')

      -- Вы можете настроить выделения, выполнив что-то вроде
      vim.cmd.hi("Comment gui=none")

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })                    -- Делает neovim прозрачным
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })               -- Делает плавающее окно neovim прозрачным
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })                -- nvim-gitgutter прозрачная линия
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })                  -- Прозрачное окно буффера
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "none" }) -- Прозрачная Debugger панель codelldb
      --vim.api.nvim_set_hl(0, "CursorLine", { blend = 0 }) -- background of dressing of nvim input prompt?
   end
}
