return {
   "jiaoshijie/undotree", -- Показывает дерево истории undo и redo
   dependencies = "nvim-lua/plenary.nvim",
   opts = {
      position = "right",
      window = {
         winblend = 30,
      },
   },
   config = true, -- Если выставлены opts параметры, то автоматически запускает `require(MAIN).setup(opts)`
   keys = { -- Загружает плагин только при использовании его сочетания клавиш:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
   },
}
