return {
   "hedyhli/markdown-toc.nvim",
   ft = "markdown",
   main = "mtoc",
   cmd = "Mtoc",
   keys = {
      { "<leader>ct", "<cmd>Mtoc<CR>", desc = "Insert TOC (mtoc)" },
   },
   opts = {
      headings = {
         -- Does not include headings before the ToC
         before_toc = false,
      },

      fences = {
         enabled = true,
         start_text = "toc-start",
         end_text = "toc-end",
      },

      toc_list = {
         markers = "-",
         -- Ensure in TOC, title are in Title Case
         item_formatter = function(item, fmtstr)
            local default_formatter = require('mtoc.config').defaults.toc_list.item_formatter
            -- NOTE: Consider using `vim.fn.tolower/toupper` to support letters other than ASCII.
            item.name = item.name:gsub("(%a)([%w_']*)", function(a, b) return vim.fn.toupper(a) .. vim.fn.tolower(b) end)
            return default_formatter(item, fmtstr)
         end,
      },
   },
}
