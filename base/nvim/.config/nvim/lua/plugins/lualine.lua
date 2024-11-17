-- Источник: https://github.com/Tainted-Fool/mydotfiles/blob/main/nvim/.config/nvim/lua/plugins/lualine.lua

return {
   "nvim-lualine/lualine.nvim",          -- Строка состояния
   dependencies = {
      { "nvim-tree/nvim-web-devicons" }, -- Поддержка иконок для lualine
   },
   opts = function()

      -- Show commands you enter
      local commands = {
         function() return require("noice").api.status.command.get() end,
         cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
         color = { fg = "#ff9e64" },
      }

      -- Show registry of marcro recording
      local recording = {
         function() return require("noice").api.status.mode.get() end,
         cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
         color = { fg = "#ff9e64" },
      }

      -- Show DAP status
      local dap = {
         function() return "DAP: " .. require("dap").status() end,
         cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
         color = { fg = "#ff9e64" },
      }

      -- Show hexadecimal value of what is under cursor
      local hex = function()
         return "Hex:0x%B"
      end

      require("lualine").setup({
         options = {
            -- Включает или отключает иконки
            icons_enabled = true,
            component_separators = "|",
            section_separators = "",
         },
         tabline = {
            lualine_a = { "buffers" },
         },
         sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
               "diff",
               "diagnostics",
               dap,
               commands,
               recording,
               "filename",
            },
            lualine_x = {
               "encoding",
               "fileformat",
               hex,
            },
            lualine_y = { "location" },
            lualine_z = { "progress", },
         },
      })
   end,
}
