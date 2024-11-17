-- Источники:
-- https://github.com/torresramiro350/nvim_conf/blob/main/lua/plugins/lsp/nvim_dap.lua
-- https://github.com/Tainted-Fool/mydotfiles/blob/main/nvim/.config/nvim/lua/plugins/dap.lua

return {
   "mfussenegger/nvim-dap",
   event = "BufReadPre",
   dependencies = {
      { "theHamsta/nvim-dap-virtual-text",          opts = {} },
      {
         "rcarriga/nvim-dap-ui",
         dependencies = { "nvim-neotest/nvim-nio" },
         init = function()
            -- Переопределение настроек dapui
            -- Меньше лишних статус линих на каждых окнах dapui
            vim.opt.laststatus = 3
         end,
         keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",         mode = { "n", "v" } },
         },
         opts = {},
      },
      { 'williamboman/mason.nvim' },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
   },
   keys = {
      -- Space+dt - Добавить точку на строке (повторно убирает точку)
      -- Space+dc - Запустить или продолжить отладку
      -- Когда появляется действие в среднем нижнем окне nvim при шаге вперёд
      -- нужно переключится на это окно и перейти в режим input
      -- внутри вводим значение и Enter
      { "<leader>d",  "",                                                                                   desc = "+debug",              mode = { "n", "v" } },
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>",                                    desc = "Toggle Breakpoint" },
      { "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Breakpoint Condition" },
      { "<leader>dc", "<cmd>lua require('dap').continue()<cr>",                                             desc = "Continue" },
      { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>",                                            desc = "Terminate" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<cr>",                                            desc = "Step Into" },
      { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>",                                             desc = "Run Last" },
      { "<leader>dO", "<cmd>lua require('dap').step_over()<cr>",                                            desc = "Step Over" },
      { "<leader>do", "<cmd>lua require('dap').step_out()<cr>",                                             desc = "Step Out" },
      { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>",                                          desc = "Toggle REPL" },

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
         args = { "-q", "-i", "dap" },
      }

      dap.adapters.lldb = {
         type = 'executable',
         command = 'lldb-dap',
         name = 'lldb'
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
            runInTerminal = true,
         },

         {
            name = 'lldb: Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
               return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
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
            -- gdb не поддерживает это
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

      -- DAP settings for C++
      dap.configurations.cpp = dap.configurations.c

      -- DAP settings for Rust
      dap.configurations.rust = dap.configurations.cpp

      -- Open dapui when dap in initialized
      dap.listeners.after.event_initialized["dapui_config"] = function()
         dapui.open()
      end
      -- Close dapui when dap is terminated
      dap.listeners.before.event_terminated["dapui_config"] = function()
         dapui.close()
      end
      -- Close dapui when dap is exited
      dap.listeners.before.event_exited["dapui_config"] = function()
         dapui.close()
      end
   end,




}
