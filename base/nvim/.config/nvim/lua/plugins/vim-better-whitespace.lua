return {
   "ntpeters/vim-better-whitespace", -- Подсвечивает пробелы, не нужно (vim-scripts)
   enabled = false, -- Пока не используется
   config = function()
      -- Цвет пустых пробелов
      vim.g.better_whitespace_guicolor = "#3e32a8"
   end
}
