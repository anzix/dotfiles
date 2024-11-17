return {
   "ruifm/gitlinker.nvim", -- Делиться сгенерированными git permalinks (с диапазонами)
   keys = {
      {
         "<leader>gy",
         "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>",
         desc = "Copy Git Link"
      },
      {
         "<leader>gY",
         "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
         desc = "Open Git Link",
      },
   },
   config = true, -- Если выставлены opts параметры, то автоматически запускает `require(MAIN).setup(opts)`
}
