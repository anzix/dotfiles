return {
   "ruifm/gitlinker.nvim", -- Делиться сгенерированными git permalinks (с диапазонами)
   opts = {
      keys = {
         "<leader>gy",
         '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      },
   },
   config = true, -- Если выставлены opts параметры, то автоматически запускает `require(MAIN).setup(opts)`
}
