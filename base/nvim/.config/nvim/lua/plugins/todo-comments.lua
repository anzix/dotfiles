--  Ключевые слова по умолчанию:
--    - FIX FIXME BUG FIXIT ISSUE
--    - TODO
--    - HACK
--    - WARN WARNING XXX
--    - PERF OPTIM PERFORMANCE OPTIMIZE
--    - NOTE INFO
--    - TEST TESTING PASSED FAILED

-- NOTE:  :TodoTelescope         Search all TODO in cwd.
-- NOTE:  :TodoTelescope cwd=..  Search all TODO in ../.
-- NOTE:  :TodoQuickFix          All TODO in a quickfix.

return {
   "folke/todo-comments.nvim",
   -- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events#4495
   dependencies = { "nvim-lua/plenary.nvim" },
   event = "VimEnter", -- Плагин срабатывает, как только вы начинаете редактировать файл
   opts = { signs = false },
   keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
   },
   config = function(_, opts)
      require("todo-comments").setup(opts)

      -- Выделять дополнительно для типов файлов .md, .txt, .rst, .adoc (asciidoc),
      local configure_for_filetype = function(ev)
         local config = require("todo-comments.config")
         local is_doc = vim.tbl_contains({ "markdown", "text", "rst" }, vim.bo.filetype)
         config.options.highlight.comments_only = not is_doc
      end
      vim.api.nvim_create_autocmd("BufEnter", {
         desc = "Enable todo-comments for text documents",
         group = vim.api.nvim_create_augroup("user.todo.text", { clear = true }),
         callback = configure_for_filetype,
      })
      configure_for_filetype()
   end,
}
