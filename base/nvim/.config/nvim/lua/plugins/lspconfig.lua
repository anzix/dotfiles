-- Основано на этом видео: https://www.youtube.com/watch?v=m8C0Cq9Uv9o
-- И: https://github.com/reed-nvim/nvim-config/blob/main/lua/plugins/lsp.lua
return {                    -- LSP Configuration & Plugins
   "neovim/nvim-lspconfig", -- Движок для lsp
   dependencies = {
      -- Автоматическая установка LSP и связанных с ним инструментов в stdpath для neovim.
      "nvim-telescope/telescope.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Устанавливать другие инструменты mason такие как форматтеры/линтеры-диагностеры

      -- NOTE: `opts = {}` — то же самое, что вызов `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} }, -- Улучшенные уведомления Neovim и ход работы LSP.
   },
   keys = {
      -- INFO: Неиспользуется, так как используется conform.format, из плагина Conform
      -- Быстрое форматирование строк
      -- { "TT", function()
      --    vim.lsp.buf.format({ timeout_ms = 5000 }) -- timeout_ms, чтобы форматировал длинные файлы
      -- end, { mode = { "n" }}}

   },
   config = function()
      local configs = require "lspconfig.configs"
      local lspconfig = require "lspconfig"

      -- Функция для отключения возможности форматирования определённых lsp
      local disable_formatting = function(client)
         client.server_capabilities.documentFormattingProvider = false
         client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- Источник: https://github.com/neovim/nvim-lspconfig/issues/662
      -- Команда для переключения встроенной (inline) диагностики
      -- Бинд: <leader>ii
      vim.api.nvim_create_user_command(
         'DiagnosticsToggleVirtualText',
         function()
            local current_value = vim.diagnostic.config().virtual_text
            if current_value then
               vim.diagnostic.config({ virtual_text = false })
            else
               vim.diagnostic.config({ virtual_text = true })
            end
         end,
         {}
      )

      -- Команда для переключения диагностики
      -- Бинд: <leader>id
      vim.api.nvim_create_user_command(
         'DiagnosticsToggle',
         function()
            local current_value = vim.diagnostic.is_enabled()
            if current_value then
               vim.diagnostic.enable(false)
            else
               vim.diagnostic.enable(true)
            end
         end, { desc = "Toggle diagnostics" }
      )

      -- Серверы и клиенты LSP могут сообщать друг другу, какие функции они поддерживают.
      -- По умолчанию Neovim не поддерживает все, что указано в спецификации LSP.
      -- Когда вы добавляете nvim-cmp, luasnip и т. д, у Neovim теперь *больше* возможностей.
      -- Итак, мы создаем новые возможности с помощью nvim cmp, а затем транслируем их на серверы.
      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
         capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      -- Здесь указываются lsp которые не управляются mason, например это могут
      -- быть те lsp сервера которые установлены локально вашим пакетным менеджером.
      -- За помощью обращайтесь в `:h lspconfig-new`

      -- function def_conf(name, opt)
      --    if not configs[name] then
      --       configs[name] = opt
      --    end
      -- end

      -- superhtml
      -- Устаналивать нужно самому
      -- https://github.com/kristoff-it/superhtml
      -- def_conf('superhtml', {
      --    default_config = {
      --       name = "superhtml",
      --       cmd = { "superhtml", "lsp" },
      --       filetypes = { "html", "superhtml", "htm", "shtml" },
      --       root_dir = require("lspconfig.util").root_pattern(".git"),
      --    },
      -- })

      -- QML
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#qmlls
      -- Требования: Для работы должны быть скачаны пакеты
      -- qt6-declarative qt6-languageserver

      if not configs.qmlls then
         configs.qmlls = {
            default_config = {
               -- WARN: Обязательно пишите для шестой версии Qt и используйте для
               -- сборки команду qmake6, иначе lsp будет выдавать кучу предупреждений
               -- если ПО написана на пятой версии QT
               cmd = { "qmlls6" },
               filetypes = { "qml", "qmljs" },
               root_dir = function(fname)
                  return lspconfig.util.find_git_ancestor(fname)
               end,
               single_file_support = true, -- Если вдруг не инициализирован git
               docs = {
                  description = [[
      https://github.com/qt/qtdeclarative

      LSP implementation for QML (autocompletion, live linting, etc. in editors),
                       ]],
               },
               -- Здесь выставляются настройки непосредственно самого lsp
               settings = {},
            },
         }
      end
      -- INFO: Если будут другие локальные lsp сервера помимо qmlls, то мне надо
      -- строку lspconfig вызвать в массиве.
      lspconfig.qmlls.setup({
         capabilities = capabilities,
      })

      -- Включите следующие языковые серверы
      --  Не стесняйтесь добавлять/удалять любые LSP, которые вы хотите здесь. Они будут автоматически установлены.
      --
      --  Добавьте любую дополнительную конфигурацию переопределения в следующие таблицы. Доступные ключи:
      --  - cmd (table): Переопределить команду по умолчанию, используемую для запуска сервера
      --  - filetypes (table): Переопределить список связанных типов файлов по умолчанию для сервера.
      --  - capabilities (table): Переопределить поля в возможностях. Может использоваться для отключения определенных функций LSP.
      --  - settings (table): Переопределить настройки по умолчанию, переданные при инициализации сервера.
      --        Например, чтобы просмотреть параметры lua_ls, вы можете перейти по адресу: https://luals.github.io/wiki/settings/
      local server_settings = {
         -- LSP сервер/диагностер и линтер для C/C++
         clangd = {
            cmd = {
               "clangd",
               "--background-index",
               "--clang-tidy",
               "--header-insertion=iwyu",
               "--completion-style=detailed",
               "--function-arg-placeholders",
               "--fallback-style=llvm",
            },
            -- server_capabilities = {
            --    documentFormattingProvider = false, -- Отключить форматирование
            -- }
         },
         -- ... и т.д. См. `:help lspconfig-all` для получения списка всех предварительно настроенных LSP.
         --
         -- Некоторые языки (например, typescript) имеют целые языковые плагины, которые могут быть полезны:
         --    https://github.com/pmizio/typescript-tools.nvim
         --
         -- Но для многих настроек LSP («ts_ls») будет работать нормально.
         -- ts_ls = {},
         --

         -- Rust LSP
         -- rust_analyzer = {
         --    cmd = {
         --       "rustup", "run", "stable", "rust-analyzer",
         --    },
         --    -- Здесь выставляются настройки непосредственно самого lsp
         --    settings = {
         --       ["rust-analyzer"] = {
         --          diagnostics = {
         --             enable = true,
         --          }
         --       }
         --    }
         -- },

         -- Go
         gopls = {
            cmd = {"gopls"},
            filetypes = { "go", "gomod", "gowork", "gotmlp" },
            root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
            settings = {
               gopls = {
                  -- Можно указать кастомные флаги сборки для gopls, помогает избажать
                  -- ошибки: `no package metadata for file "buildFlags"`
                  -- buildFlags = { "-tags", "gui" },
                  -- completeUnimported не нужно добавлять оно уже есть
                  usePlaceholders = true,
                  -- В analyses не нужно добавлять unusedparams, оно уже есть
               }
            }
         },

         bashls = {
            filetypes = { 'sh', 'zsh', 'zshrc', 'bash', 'inc', 'command', 'zsh_*' },
            -- Здесь выставляются настройки непосредственно самого lsp
            settings = {
               bashIde = {
                  globPattern = "**/*@(.sh|.inc|.bash|.command|.zshrc|.zsh|zsh_*)"
               }
            }
         },

         lua_ls = {
            -- Здесь выставляются настройки непосредственно самого lsp
            settings = {
               Lua = {
                  telemetry = { enable = false },
                  workspace = {
                     checkThirdParty = false,
                     -- Сообщает lua_ls, где найти все загруженные вами файлы Lua
                     -- для вашей конфигурации neovim.
                     library = {
                        -- Настроен на быстрый запуск (для слабых ПК)
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library",
                        -- "${3rd}/busted/library",
                     },
                     -- Или вытягивает всё из 'runtimepath'
                     -- NOTE: Это на много медленнее и может вызвать проблемы с собственным конфигом
                     -- library = vim.api.nvim_get_runtime_file("", true), -- Уменьшает в 3 раза загрузку
                  },
                  completion = {
                     callSnippet = "Replace",
                  },
                  -- Вы можете переключиться ниже, чтобы игнорировать шумные предупреждения lua_ls об «отсутствующих полях».
                  diagnostics = {
                     disable = { "missing-fields" },
                     globals = { "vim" }, -- Get the language server to recognize the `vim` global
                  },
               },
            },
         },

         yamlls = { -- yaml
            -- Здесь выставляются настройки непосредственно самого lsp
            settings = {
               redhat = { telemetry = { enabled = false } }
            }
         },
         asm_lsp = true,  -- LSP для NASM/GAS/GO
         mesonlsp = true, -- LSP для системы сборки Meson
         neocmake = true, -- LSP для системы сборки Cmake
         html = true,     -- html-lsp
         cssls = true,    -- css lsp
         emmet_ls = true, -- доп. lsp (для html)
         jsonls = true,   -- json lsp
      }

      -- Отфильтровать таблицу server_settings подготавливая названия
      -- для установки из mason-tool-installer
      local servers_to_install = vim.tbl_filter(function(key)
         local t = server_settings[key]
         if type(t) == "table" then
            return not t.manual_install
         else
            return t
         end
      end, vim.tbl_keys(server_settings))

      -- Убедитесь, что указанные выше серверы и инструменты установлены.
      -- Чтобы проверить текущий статус установленных инструментов и/или вручную
      -- установить другие инструменты, вы можете запустить
      --    :Mason
      --
      --  Вы можете нажать `g?` для получения помощи в меню Mason.
      require("mason").setup()

      -- Вы можете добавить сюда другие инструменты которые вы хотите, чтобы
      -- Mason установил для вас, и чтобы они были доступны в Neovim.
      local ensure_installed = {
         -- Форматирование/Диагностика
         "cmakelint",    -- Диагностика CMake файлов
         "gersemi",      -- Форматирования CMake файлов
         "djlint",       -- Диагностика htmldjango
         "eslint_d",     -- Диагностика JavaScript
         "stylua",       -- Форматирования Lua файлов
         "prettier",     -- Форматирование Markdown файлов и не только
         "markdownlint", -- Диагностика Markdown файлов
         "shfmt",        -- Форматирование bash скриптов
         "shellcheck",   -- Диагностика bash скриптов
      }
      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      -- Это позволяет переопределить только значения, явно
      -- переданные в конфигурации сервера, указанной выше.
      -- Полезно при отключении некоторых функций LSP
      -- (например, при отключении форматирования для tsserver (ts_ls)).
      for name, config in pairs(server_settings) do
         if config == true then
            config = {}
         end

         config = vim.tbl_deep_extend("force", {}, {
            capabilities = capabilities,
         }, config)
         -- print("Настраиваю", name) -- DEBUG: Для тестирования
         lspconfig[name].setup(config)
      end

      -- Использовать LspAttach autocommand чтобы привязать только текущие клавиши
      -- после того как lsp подключится к текущему буфферу
      -- Помощь: `:h lspconfig-configurations`
      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
         callback = function(event)
            -- these will be buffer-local keybindings
            -- because they only work if you have an active language server

            -- В этом случае мы создаем функцию, которая позволяет нам легче определять
            -- бинды, специфичные для элементов, связанных с LSP. Он каждый
            -- раз устанавливает для нас режим, буфер и описание.
            local map = function(keys, func, desc)
               vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            -- TODO: рассмотреть возможность удаления при использовании neovim 0.11 nightly
            -- rename, action, references

            -- Перейдите к определению слова под курсором.
            -- Это то где *впервые* была объявлена переменная или определена функция и т.д.
            -- Чтобы вернуться назад, нажмите <C-T>.
            map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

            -- WARN: Это не определение Goto (Goto Definition), это декларация Goto (Goto Declaration).
            --  Например, в Си это приведет вас к заголовку (header)
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- Найдите референсы на слово под курсором.
            map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

            -- Перейти к *реализации* слова под курсором.
            --  Полезно, когда в вашем языке есть способы объявления типов без фактической *реализации*.
            map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

            -- Перейдите к типу слова под курсором.
            -- Полезно, когда вы не уверены, к какому типу относится переменная, и
            -- хотите увидеть определение ее *типа*, а не места, где она была *определена*.
            map("<space>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

            -- Fuzzy find всех символов в текущем документе.
            --  Символы — это такие вещи, как переменные, функции, типы и т. д.
            map("<space>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

            -- TODO: Найти другой бинд, не Space+ws (у меня сохранения будет долгим)
            -- Fuzzy find всех символов в вашем текущем рабочем пространстве.
            --  Аналогично символам документа, за исключением поиска по всему проекту.
            -- map("<space>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- Переименуйте переменную под курсором
            --  Большинство LSP поддерживают переименование файлов и т. д.
            map("<space>rn", vim.lsp.buf.rename, "[R]e[n]ame")

            -- Выполните действие кода. Обычно для этого курсор должен находиться
            -- над ошибкой или предложением вашего LSP.
            map("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            -- Открывает всплывающее окно, в котором отображается документация о слове под курсором.
            -- Это для темно синих и ярко синих текстов в синтаксисе neovim
            --  См. `:help K`, для помощи
            map("K", vim.lsp.buf.hover, "Hover Documentation")

            -- Отображает сигнатуру функций (пользовательская функция) с выделенным
            -- текущим параметром (внутри скобки) и показавает где я нахожусь выделением
            map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

            -- Следующие две автокоманды используются для выделения ссылок на
            -- слово под курсором, когда курсор находится там некоторое время.
            --    См. `:help CursorHold` для получения информации о том, когда это выполняется.
            --
            -- При перемещении курсора выделение будет очищено (вторая автокоманда).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
               local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
               vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.document_highlight,
               })

               vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.clear_references,
               })

               -- Команда для отключения LSP
               vim.api.nvim_create_autocmd('LspDetach', {
                  group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                  callback = function(event2)
                     vim.lsp.buf.clear_references()
                     vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                  end,
               })
            end

            -- Следующий код создает раскладку клавиш для переключения подсказок
            -- в вашем коде, если используемый вами языковой сервер поддерживает
            --
            -- Это может быть нежелательно, поскольку они заменяют часть вашего кода.
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
               map('<leader>th', function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
               end, '[T]oggle Inlay [H]ints')
            end
         end,
      })
   end
}
