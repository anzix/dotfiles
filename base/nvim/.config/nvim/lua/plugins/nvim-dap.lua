-- Источник: https://github.com/torresramiro350/nvim_conf/blob/main/lua/plugins/lsp/nvim_dap.lua
return {
   "mfussenegger/nvim-dap",
   event = "BufReadPre",
   dependencies = {
      {
         "rcarriga/nvim-dap-ui",
         opts = {},
         init = function()
            -- Переопределение настроек dapui
            -- Меньше лишних статус линих на каждых окнах dapui
            vim.opt.laststatus = 3
         end,
      },
      { "nvim-neotest/nvim-nio" },
      { "theHamsta/nvim-dap-virtual-text" },
      { 'williamboman/mason.nvim' },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
   },
   keys = {
      -- Space+dt - Добавить точку на строке (повторно убирает точку)
      -- Space+dc - Запустить или продолжить отладку
      -- Когда появляется действие в среднем нижнем окне nvim при шаге вперёд
      -- нужно переключится на это окно и перейти в режим input
      -- внутри вводим значение и Enter
      { "<leader>dt", ":DapToggleBreakpoint<CR>", mode = "n", desc = "Toggle break point" },
      { "<leader>dc", ":DapContinue<CR>",         mode = "n", desc = "Continue debugging" },
      { "<Leader>dx", ":DapTerminate<CR>",        mode = "n", desc = "Terminate debugging" },
      { "<Leader>do", ":DapStepOver<CR>",         mode = "n", desc = "Open DapUI" },
      {
         "<space>?",
         function()
            require("dapui").eval(nil, { enter = true })
         end,
         mode = "n",
         desc = "Eval var under cursor"
      },
      { "<Leader>dut", ":DapUIToggle<CR>", mode = "n", desc = "Step over" }
   },
   config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- Установка отладчика из Meson
      require("mason-tool-installer").setup({
         ensure_installed = {
            "codelldb",
         }
      })

      require('nvim-dap-virtual-text').setup({})

      dapui.setup()

      dap.adapters.gdb = {
         type = "executable",
         command = "gdb",
         args = { "-i", "dap" },
      }

      dap.adapters.codelldb = {
         type = "server",
         port = "${port}",
         executable = {
            command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
            args = { "--port", "${port}" },
         },
      }

      -- C
      dap.configurations.c = {
         -- На выбор codelldb/gdb
         {
            name = "Codelldb: Launch",
            type = "codelldb",
            request = "launch",
            program = function()
               return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            -- FIXME: почему-то иногда первым идёт ввод аргументов а потом исполняемый
            args = function()
               local args_str = vim.fn.input({
                  prompt = 'Arguments (leave empty for no arguments): ',
               })
               return vim.split(args_str, ' +')
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            runInTerminal = false,
         },
         {
            name = "GDB: Launch",
            type = "gdb",
            request = "launch",
            program = function()
               return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            args = function()
               local args_str = vim.fn.input({
                  prompt = 'Arguments (leave empty for no arguments): ',
               })
               return vim.split(args_str, ' +')
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            runInTerminal = false,
         },
         {
            name = "Attach to process (GDB)",
            type = 'gdb',
            request = 'attach',
            pid = function()
               local input_pid = vim.fn.input('Enter process ID: ')
               if input_pid ~= '' then
                  return tonumber(input_pid)
               end
               return nil
            end,
         },
      }

      vim.api.nvim_create_user_command("DapUIToggle", function()
         require("dapui").toggle()
      end, { desc = "Open DapUI" })

      -- If you want to use this for Rust and C, add something like this:
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.cpp

      dap.listeners.before.attach.dapui_config = function()
         dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
         dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
         dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
         dapui.close()
      end
   end,
}
