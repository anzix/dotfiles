return {
   "folke/todo-comments.nvim", -- Помечает TODO, PREF, NOTE, FIX, WARN и т.д
   -- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events#4495
   dependencies = { "nvim-lua/plenary.nvim" },
   event = "VimEnter",         -- Плагин срабатывает, как только вы начинаете редактировать файл
   opts = { signs = false },
   config = true, -- Если выставлены opts параметры, то автоматически запускает `require(MAIN).setup(opts)`
   keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
   }
}
