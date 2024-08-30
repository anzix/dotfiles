return {
   "uga-rosa/translate.nvim", -- Переводчик текста
   -- (default) 'google': Он использует Google Translate. Требуется установленный Curl.
   -- 'translate_shell': Работает быстрее
   --   Требуется установка команды [trans](https://github.com/soimort/translate-shell).
   --   Также рекомендуется установить [config](https://github.com/soimort/translate-shell/wiki/Configuration) конфиг файл.
   -- 'deepl_pro' или 'deepl_free':
   --   Вам понадобится ключ авторизации для DeepL API Pro/Free.
   --   Требуется установленный Curl.
   --
   -- FIXME: При настройке конфигурационного файла ~/.config/translate-shell/init.trans
   -- с указанием движка yandex не переводит текст. Это проблема translate-shell
   -- Issue: https://github.com/soimort/translate-shell/issues/359
   -- Как временное решение использовать Google Translate
   cmd = "Translate",
   keys = {
      -- Параметры для опции -output=
      -- split - раздельное окно
      -- floating - плавающее окно (не показывается если юзать на vim.lsp.buf.hover)
      -- replace - заменять ориг. текст (не работает на vim.lsp.buf.hover)
      -- Как использовать режимы внутри keys: https://www.reddit.com/r/neovim/comments/15lrahk/lazynvim_and_choosing_multiple_modes_for_keys/
      { "ts", ":Translate RU -source=EN -output=split<CR>",   mode = { "v", "x" }, silent = true },
      { "tr", ":Translate RU -source=EN -output=replace<CR>", mode = { "v", "x" }, silent = true },
   },
   config = function()
      local options = {
         default = {
            command = "translate_shell",
         },
         silent = true,
      }
      require("translate").setup(options)
   end
}
