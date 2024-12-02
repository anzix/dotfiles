# README.md для nvim

- [Arch Wiki LSP](https://wiki.archlinux.org/title/Language_Server_Protocol)

## TODO: Что я должен изменить в моём nvim конфиге

1. ~Узнать что за плагин добавляющий виртуальный текст для функций как в LazyVim~
2. ~Узнать как в изменить режим массового коментирования используя `gcc` и `gc`\
   с `/*` на `//` как в LazyVim~
3. ~Изменить lualine как в LazyVim~
4. dap с gdb не работает нормально
5. [Заценить](https://github.com/Zeioth/dooku.nvim)
6. Какого-то фига перестал работать `friendly-snippets` сниппеты для cdoc документации

   Была похожая [проблема](https://github.com/L3MON4D3/LuaSnip/issues/1168) но\
   для Windows и вряд-ли относиться ко мне
7. Найти метод как в neovim внутри файла перейти на запись которая указывает на\
   другой файл

8. Найти метод создания шаблонов Makefile Си в Neovim как это сделано в VSCode

   [Например](https://youtu.be/YwBPQNYaqWg?si=9dwnAVlX5GFl5x07&t=80)

9. (На будущее) Отказаться от LuaSnip в пользу нативного api vim.snippet который\
   поставляет 0.10 версия neovim

   [Источник](https://www.reddit.com/r/neovim/comments/1cxfhom/builtin_snippets_so_good_i_removed_luasnip/)

   Использовать эти плагины если буду использовать `vim.snippet`:

   - [nvim-snippets](https://github.com/garymjr/nvim-snippets)
   - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) есть\
     поддержка `vim.snippet`

## Проблемы с способы их решения

1. neovim lsp cmp иногда выдает мне путь linux каталогов при завершении кода, что\
   мешает и раздражает

   [Источник проблемы](https://www.reddit.com/r/neovim/comments/r7ckjm/nvimcmp_path_completion_starts_as_soon_as_or_is/)
   [Источник решения](https://github.com/hrsh7th/cmp-path/issues/64)

   Решение:

   Необходимо править исходник плагина который находится по пути

   ```txt.
   $HOME/.local/share/nvim/site/pack/packer/start/cmp-path/lua/cmp_path/init.lua
   ```

   Вставляем в секцию ниже

   ```lua
   local accept = true
   ...
    -- Ignore CPP closing block comments
       accept = accept and not prefix:match('\\*/$')
   ...
   ```
