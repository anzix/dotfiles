-- WARN: Здесь только форматтеры
return {
   "stevearc/conform.nvim",
   event = {
      -- Плагин будет загружен до того, как файл будет прочитан ИЛИ когда я создам новый файл.
      "BufReadPre",
      "BufNewFile",
   },
   cmd = { 'ConformInfo', 'Format' },
   config = function()
      local conform = require("conform")
      conform.setup({
         -- Для вызова информации о использованном форматтере вызовите :ConformInfo
         -- Вызов форматтеров на тип файла
         formatters_by_ft = {
            yaml = { "prettierd", "prettier" },
            json = { "prettierd", "prettier" },
            markdown = { "prettier", "prettierd" },
            -- toml = { "taplo" },
            -- tex = { "latexindent" },
            -- python = function(bufnr)
            --    if conform.get_formatter_info("ruff_format", bufnr).available then
            --       -- return { "ruff_format" } -- not supported by ruff as of yet
            --       return { "isort", "ruff_format" }
            --    else
            --       return { "isort", "black" }
            --    end
            -- end,
            cmake = { "gersemi" }, -- форк cmake_format
            -- glsl = { 'clang_format' },
            -- Conform будет запускать несколько форматтеров последовательно
            -- Вы можете настроить некоторые параметры формата для типа файла (:help conform.format).
            -- Conform запустит первый доступный форматтер
            -- rust = { "rustfmt", lsp_format = "fallback" },
         },
         -- Настройка форматтеров
         formatters = {
            ["gersemi"] = {
               prepend_args = {
                  -- Отступы, чтобы cmake-lint не возмущался
                  "--indent",
                  "2",
               }
            }
         },

         -- Автоматическое форматирование на сохранении файла
         -- (lsp_format = "fallback" автоматически использует
         -- vim.lsp.buf.format функцию)
         -- format_on_save = {
         --    -- Эти параметры будут переданы в `conform.format()`
         --    async = false,
         --    timeout_ms = 5000,
         --    lsp_format = 'fallback',
         -- },
      })

      -- Создаёт комманду Format, полезно вручную использовать
      vim.api.nvim_create_user_command("Format", function(args)
         local range = nil
         if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
               start = { args.line1, 0 },
               ["end"] = { args.line2, end_line:len() },
            }
         end
         require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      -- Клавиша для форматирования используя conform.format, если какие-то
      -- форматтеры в списке Conform отстутствуют, то будет использоваться
      -- форматтер из LSP
      -- Увеличен timeout_ms с 500 на 5000 чтобы форматировать длинные файлы
      vim.keymap.set({ "n", "v" }, "TT", function()
         conform.format({
            lsp_format = "fallback",
            async = false,
            timeout_ms = 5000,
         })
      end, { desc = "Format file (in normal mode) or range (in visual mode)" })
   end,
}
