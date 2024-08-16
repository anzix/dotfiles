return {
   "nvim-telescope/telescope.nvim",
   branch = '0.1.x', -- fuzzy finder на стероидах
   dependencies = {
      -- Для украшение границ плавающего окна
      { "nvim-lua/plenary.nvim" },
      -- Красивы иконки, но требуются патченные шрифты Nerd
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
   },
   -- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events#4495
   event = "VimEnter", -- VimEnter срабатывает, как только вы начинаете редактировать файл
   config = function()
      local actions = require('telescope.actions')

      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
         -- defaults = {
         --    -- You can put your default mappings / updates / etc. in here
         --    --  All the info you're looking for is in `:help telescope.setup()`
         --    mappings = {
         --       i = {
         --          ["<C-j>"] = actions.move_selection_next,     -- Ctrl+j вверх по списку
         --          ["<C-k>"] = actions.move_selection_previous, -- Ctrl+k ввниз по списку
         --       },
         --    },
         -- },
         pickers = {
            find_files = {
               -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
               find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
         },
      })
      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
   end
}
