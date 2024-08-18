return {                  -- Completion & Snippets
   "hrsh7th/nvim-cmp",    -- Движок завершений
   -- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events#4495
   event = "InsertEnter", -- Активирует только если переключишься в режим вставки (Insert)
   cmd = { "SnipList" },
   dependencies = {
      -- Snippet движок и связанный с ним источник nvim-cmp
      "L3MON4D3/LuaSnip",         -- Движок сниппетов (для опции snippets)
      "saadparwaiz1/cmp_luasnip", -- snippet завершения

      -- Добавляет другие возможности cmp.
      --   nvim-cmp по умолчанию поставляется не со всеми источниками. Они
      --   разделены на несколько репозиториев в целях обслуживания.
      "hrsh7th/cmp-nvim-lsp", -- Добавляет новые различные возможности (capabilities) для cmp в зависимости от клиента lsp
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",     -- path completions
      "hrsh7th/cmp-buffer",   -- buffer completions
      "hrsh7th/cmp-calc",     -- calc completions
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature function completions

      -- Если вы хотите добавить несколько предварительно настроенных сниппетов,
      --   вы можете использовать этот плагин, чтобы помочь вам.
      --   У него даже есть сниппеты — для различных фреймворков/библиотек/и т.д.
      --   НО вам придется настроить те, которые вам пригодятся.
      "rafamadriz/friendly-snippets", -- Куча сниппетов для использования
   },
   config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      -- Активирует сниппеты как в VS Code
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Функция для проверки пробела для key мапинга cmp
      local check_backspace = function()
         local col = vim.fn.col(".") - 1
         return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end

      -- Отсюда: https://www.reddit.com/r/neovim/comments/109018y/comment/j3vdaux
      -- Показывает список снипетов из плагина luasnip
      local list_snips = function()
         local ft_list = require("luasnip").available()[vim.o.filetype]
         local ft_snips = {}
         for _, item in pairs(ft_list) do
            ft_snips[item.trigger] = item.name
         end
         print(vim.inspect(ft_snips))
      end
      vim.api.nvim_create_user_command("SnipList", list_snips, {})

      cmp.setup({
         experimental = {
            ghost_text = false, -- подсвечивание автозаполнения
         },
         snippet = {
            -- ОБЯЗАТЕЛЬНО - необходимо указать движок для сниппетов
            expand = function(args)
               luasnip.lsp_expand(args.body) -- Для пользователей luasnip.
            end,
         },
         completion = { completeopt = "menu,menuone,noinsert" },

         -- Чтобы понять, почему были выбраны эти маппинги, вам нужно
         -- будет прочитать `:help ins-completion`
         --
         -- Нет, но серьезно. Пожалуйста, прочтите `:help ins-completion`, это действительно полезно!
         mapping = cmp.mapping.preset.insert({
            -- Прокрутка вверх и вниз документацию по cmp
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),

            -- Перемещаться по элементам в списке cmp
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),

            -- Принять ([y]es) завершение.
            -- Это будет автоматически импортировано, если ваш LSP поддерживает это.
            -- Это расширит сниппет, если LSP отправил сниппет.
            -- INFO: Также можно использовать <C-y> т.е Ctrl+y для принятия
            ["<CR>"] = cmp.mapping.confirm({ select = true }),

            -- Вручную запустить завершение из nvim-cmp.
            -- Обычно вам это не нужно, потому что nvim-cmp будет отображать
            -- завершения всякий раз, когда у него есть доступные параметры завершения.
            ["<C-Space>"] = cmp.mapping.complete({}),

            -- TODO: Изменить бинды с Tab/S-Tab на <C-l>/<C-h> как сделано ниже?
            -- ["<C-l>"] = cmp.mapping(function()
            --    if luasnip.expand_or_locally_jumpable() then
            --       luasnip.expand_or_jump()
            --    end
            -- end, { "i", "s" }),
            -- ["<C-h>"] = cmp.mapping(function()
            --    if luasnip.locally_jumpable(-1) then
            --       luasnip.jump(-1)
            --    end
            -- end, { "i", "s" }),

            -- Думайте о <Tab> как о перемещении вправо от расширения места сниппета.
            -- Итак, если у вас есть фрагмент вроде:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <Tab> переместит вас вправо от каждого места расширения.
            -- <S-Tab> аналогичен, за исключением перемещения назад.
            ["<Tab>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_next_item()
               elseif luasnip.expandable() then
                  luasnip.expand()
               elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
               elseif check_backspace() then
                  fallback()
               else
                  fallback()
               end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
               else
                  fallback()
               end
            end, { "i", "s" }),
         }),
         sources = {
            { name = "nvim_lsp" },
            { name = 'nvim_lsp_signature_help' }, -- Отображает в списке cmp сигнатуру функций с выделенным текущим параметром (группа text)
            { name = "nvim_lua" }, -- complete neovim's Lua runtime API such vim.lsp.*
            { name = "luasnip" },  -- For luasnip users.
            { name = "path" },     -- (cmp-path) Автозавершения путей Linux
            {
               name = "buffer",    -- (cmp-buffer)
               option = {
                  -- Избегать случайного запуска на больших файлах
                  get_bufnrs = function()
                     local buf = vim.api.nvim_get_current_buf()
                     local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                     if byte_size > 1024 * 1024 then -- Максимум 1 mb
                        return {}
                     end
                     return { buf }
                  end,
               },
            },
            { name = "calc" }, -- (cmp-calc) source for math calculation
         },
      })

      -- Показывать всегда виртуальный текст (на буффере)
      vim.diagnostic.config({
         -- update_in_insert = true, -- На микросекунду ломает синтаксис при пролистывании cmp
         virtual_text = true,
      })
   end,
}
