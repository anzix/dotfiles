return {
   "folke/trouble.nvim",                   -- Лучший список диагностики и разное
   dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Зависимость для Trouble (TodoTelescope)
      { "nvim-tree/nvim-web-devicons" },   -- Иконки для Trouble
      { "folke/todo-comments.nvim" },      -- Помечает TODO, PREF, NOTE, FIX, FIXME, WARN и т.д
   },
   cmd = { "TroubleToggle", "Trouble" },
   keys = {
      { "<leader>tt", "<cmd>TodoTrouble focus=true filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                    desc = "Todo/Fix/Fixme (Telescope)" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",       desc = "Diagnostics on current buffer main window (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle focus=true<cr>",                    desc = "Diagnostics on all oppened buffers windows (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",         desc = "LSP Definitions / references / ... (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle focus=true<cr>",                        desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle focus=true<cr>",                         desc = "Quickfix List (Trouble)" },
      {
         "[q",
         function()
            if require("trouble").is_open() then
               require("trouble").prev({ skip_groups = true, jump = true })
            else
               local ok, err = pcall(vim.cmd.cprev)
               if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
               end
            end
         end,
         desc = "Previous Trouble/Quickfix Item",
      },
      {
         "]q",
         function()
            if require("trouble").is_open() then
               require("trouble").next({ skip_groups = true, jump = true })
            else
               local ok, err = pcall(vim.cmd.cnext)
               if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
               end
            end
         end,
         desc = "Next Trouble/Quickfix Item",
      },
   },
   config = function()
      require("trouble").setup({
         use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      })

      -- Прозрачность панельки Trouble
      vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
   end
}
