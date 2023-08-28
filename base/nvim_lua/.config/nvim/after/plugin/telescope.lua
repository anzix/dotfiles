local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>f', builtin.find_files, {}) -- Поиск файлов
vim.keymap.set('n', '<leader>g', builtin.live_grep, {}) -- Grep
vim.keymap.set('n', '<leader>h', builtin.help_tags, {}) -- Помощь по тегам

telescope.setup({
    defaults = {
		file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.jpg", "%.png" },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next, -- Ctrl+j вверх по списку
                ["<C-k>"] = actions.move_selection_previous, -- Ctrl+k ввниз по списку
            },
        },
    },
})
