return { -- Hello
   "uga-rosa/translate.nvim", -- Переводчик текста
   keys = {
      -- Переводчик
      -- Параметры для опции -output=
      -- split - раздельное окно
      -- floating - плавающее окно (не показывается если юзать на vim.lsp.buf.hover)
      -- replace - заменять ориг. текст (не работает на vim.lsp.buf.hover)
      -- Как использовать режимы внутри keys: https://www.reddit.com/r/neovim/comments/15lrahk/lazynvim_and_choosing_multiple_modes_for_keys/
      { "ts", ":Translate RU -source=EN -output=split<CR>",   mode = { "v", "x" }, silent = true },
      { "tr", ":Translate RU -source=EN -output=replace<CR>", mode = { "v", "x" }, silent = true },
   }
}
