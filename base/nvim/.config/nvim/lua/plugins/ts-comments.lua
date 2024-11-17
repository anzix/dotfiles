-- Улучшает нативное комментирование neovim (commentstring)
-- В особенности для Си исправля с /* на //
-- TODO: В 0.11.+ версии neovim этот плагин не нужен будет
return {
   "folke/ts-comments.nvim",
   event = "VeryLazy",
   opts = {},
}
