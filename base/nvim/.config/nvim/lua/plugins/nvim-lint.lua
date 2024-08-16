return {
   "mfussenegger/nvim-lint",
   dependencies = {
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
   },
   event = {
      -- Плагин будет загружен до того, как файл будет прочитан ИЛИ когда я создам новый файл.
      "BufReadPre",
      "BufNewFile",
   },
   config = function()
      local lint = require("lint")
      local markdownlint = require('lint').linters.markdownlint

      -- Вызов линтеров на тип файла
      lint.linters_by_ft = {
         markdown = { "markdownlint" },
         javascript = { "eslint_d" },
         html = { "djlint" },
         -- Используйте тип файла "*" для запуска линтеров на всех типов файлов.
         -- ['*'] = { 'global linter' },
         -- Используйте тип файла "_" для запуска линтеров на типах файлов, для которых не настроены другие линтеры.
         -- ['_'] = { 'fallback linter' },
         -- ["*"] = { "typos" },
      }
      -- Параметры линтеров
      markdownlint.args = {
         -- Отключает Line length (MD013)
         '--disable',
         'MD013',
         '--'
      }

      -- Автоматически вызывать линтинг при входе в буфер, после записи и после выхода из режима Insert
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
         group = lint_augroup,
         callback = function()
            lint.try_lint()
         end,
      })
   end,
}
