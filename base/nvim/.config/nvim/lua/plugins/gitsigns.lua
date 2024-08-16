return {
   "lewis6991/gitsigns.nvim", -- Показывает изменённые строки кода/конфига
   event = 'VeryLazy',        -- Плагин будет загружаться позже, так как не важен для начального запуска UI.
   -- opts = {},
   config = function()
      require("gitsigns").setup({
         signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "≃" },
            untracked = { text = "┆" },
         },
         preview_config = { border = "double" },
         watch_gitdir = { interval = 1000 },

         on_attach = function(bufnr)
            local gitsigns = require('gitsigns')
            local function map(mode, l, r, opts)
               opts = opts or {}
               opts.buffer = bufnr
               vim.keymap.set(mode, l, r, opts)
            end
            -- Навигация
            map('n', ']h', function()
               if vim.wo.diff then
                  vim.cmd.normal({ ']c', bang = true })
               else
                  gitsigns.nav_hunk('next')
               end
            end, { desc = 'Next Hunk' })

            map('n', '[h', function()
               if vim.wo.diff then
                  vim.cmd.normal({ '[c', bang = true })
               else
                  gitsigns.nav_hunk('prev')
               end
            end, { desc = 'Prev Hunk' })
         end
      })
   end
}
