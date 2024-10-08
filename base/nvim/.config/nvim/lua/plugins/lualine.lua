return {
   "nvim-lualine/lualine.nvim", -- Строка состояния
   dependencies = {
      { "nvim-tree/nvim-web-devicons" }, -- Поддержка иконок для lualine
   },
   opts = {
      options = {
         component_separators = "|",
         section_separators = "",
      },
      tabline = {
         lualine_a = { "buffers" },
      },
      sections = {
         lualine_a = { "mode" },
         lualine_b = { "branch", "diff", "diagnostics" },
         lualine_c = { "filename" },
         lualine_x = { "encoding", "fileformat", "filetype" },
         lualine_y = { "progress" },
         lualine_z = { "location" },
      },
      inactive_sections = {
         lualine_a = {},
         lualine_b = {},
         lualine_c = { "filename" },
         lualine_x = { "location" },
         lualine_y = {},
         lualine_z = {},
      },
      extensions = { "fugitive", "quickfix" },
   },
}
