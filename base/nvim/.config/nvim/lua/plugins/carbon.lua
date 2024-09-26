-- TODO: Может расмотреть замену? Например mini.files из https://github.com/echasnovski/mini.nvim
-- Потому-что может удалять файлы не перманентно а в козину
-- https://www.reddit.com/r/neovim/comments/1f9ymyw/recover_deleted_folder_in_minifiles/``
return {
   "SidOfc/carbon.nvim",     -- Минималистичное дерево каталогов
   opts = {
      auto_open = false,     -- Не открывать carbon при простом открытии nvim
      sync_pwd = true,       -- Запоминать раскрытые рабочие каталоги
      sidebar_width = 40,    -- Ширина бокового бара (default 30)
      indicators = { collapse = "▾", expand = "▸" },
      actions = { toggle_recursive = "<s-cr>" },
      file_icons = true,
      highlights = {
         -- Прозрачное плавующее окно буффера carbon
         CarbonFloat = { bg = "none" },
      },
   },
   keys = {
      -- Руководство по биндам
      -- `[` и `]` вверх и вниз на 1 уровень корневого каталога
      -- `t` - широкий обзор
      -- `ctrl+v` или `ctrl+s` Редактировать файл с вертикальным или горизонтально
      -- `c` или `%` Создание файлов и каталогов (в конце пути прописать /) (Подтвердить Enter, отменить Esc)
      -- `m` Перемещение файлов и каталогов (при промпте указываете назначение)
      -- `d` Удаление файлов и каталогов (с подтверждением)

      -- Ctrl+d: Бинд на открытие дерево каталогов, закрыть буфер carbon на `q`

      { "<C-d>", ":Lc<CR>", mode = { "n" }, silent = true }
   }
}
