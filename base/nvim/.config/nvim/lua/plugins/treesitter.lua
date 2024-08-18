return {
   "nvim-treesitter/nvim-treesitter", -- Продвинутый синтаксис кода
   build = ":TSUpdate",
   config = function()
      -- [[ Настройка Treesitter ]] См. `:help nvim-treesitter`
      require("nvim-treesitter.configs").setup({
         -- Список имен парсеров или «все»
         -- Чтобы увидеть колличество установленных парсеров `:TSInstallInfo`
         ensure_installed = {
            "c",
            "cpp",
            "make",
            "meson",
            "cmake",
            'qmljs', -- qml файлы
            "yaml", -- синтаксис файла cmake-format
            "bash",
            "html",
            "htmldjango",
            "css",
            "lua",
            "vim",
            "markdown",
            "markdown_inline",
            "vimdoc"
         },

         -- Устанавливать парсеры синхронно (применяется только к `ensure_installed`)
         sync_install = false,

         -- Автоматически устанавливать недостающие парсеры при входе в буфер
         -- Рекомендация: установите значение false, если у вас не установлен CLI `tree-sitter` локально.
         auto_install = true,

         highlight = {
            -- `false` отключит всё расширение
            enable = true,

            -- Установка значения true приведет к одновременному запуску `:h syntax` и Tree-sitter.
            -- Установите для этого параметра значение true, если вы зависите от включения синтаксиса (например, для отступов).
            -- Использование этой опции может замедлить работу вашего редактора, и вы можете увидеть дублирующиеся выделения.
            -- Вместо true это также может быть список языков
            additional_vim_regex_highlighting = false,
         },
      })
      -- Существуют дополнительные модули nvim-treesitter, которые вы можете
      -- использовать для взаимодействия с nvim-treesitter. Вам следует изучить
      -- несколько и посмотреть, что вас интересует:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
   end
}
