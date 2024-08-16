-- WARN: Здесь только форматтеры
return {
   "stevearc/conform.nvim",
   event = "BufWritePre",
   cmd = { 'ConformInfo', 'Format' },
   keys = {
      -- Клавиша для форматирования используя conform.format, если какие-то
      -- форматтеры в списке Conform отстутствуют, то будет использоваться
      -- форматтер из LSP
      -- FIXME: Форматирование в диапазоне выделения строк не работает почему-то
      { "TT", function()
         require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500, })
      end, { mode = { "n", "v" }, desc = "Format file (in normal mode) or range (in visual mode)" } }
   },
   opts = {},
   config = function()
      local conform = require("conform")
      conform.setup({
         -- Для вызова информации о использованном форматтере вызовите :ConformInfo
         -- Вызов форматтеров на тип файла
         formatters_by_ft = {
            markdown = { "prettier" },
            -- Conform будет запускать несколько форматтеров последовательно
            -- python = { "isort", "black" },
            -- Вы можете настроить некоторые параметры формата для типа файла (:help conform.format).
            -- Conform запустит первый доступный форматтер
            -- rust = { "rustfmt", lsp_format = "fallback" },
         },
         -- Настройка форматтеров
         formatters = {},

         -- Автоматическое форматирование на сохранении файла
         -- format_on_save = {
         --    -- Эти параметры будут переданы в `conform.format()`
         --    async = false,
         --    timeout_ms = 500,
         --    lsp_fallback = true,
         -- },

         -- Создаёт комманду Format, полезно вручную использовать
         -- vim.api.nvim_create_user_command("Format", function(args)
         --    local range = nil
         --    if args.count ~= -1 then
         --       local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
         --       range = {
         --          start = { args.line1, 0 },
         --          ["end"] = { args.line2, end_line:len() },
         --       }
         --    end
         --    conform.format({ async = true, lsp_fallback = true, range = range })
         -- end, { range = true }),
      })
   end,
}
