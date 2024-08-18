-- Проверка орфографии для git commits
vim.cmd([[autocmd FileType gitcommit setlocal spell]])

-- Проверка орфографии для Markdown файлов
vim.cmd([[autocmd FileType markdown setlocal spell]])

-- Сохранять позицию курсора
function Set_cursor_position()
   local line = vim.fn.line
   local last_pos = line("'\"")
   local total_lines = line("$")
   if last_pos > 1 and last_pos <= total_lines then
      vim.api.nvim_command('normal! g`"')
   end
end

vim.api.nvim_command('autocmd BufReadPost * lua Set_cursor_position()')

-- При входе в режим вставки отключить подсветку поиска
vim.cmd [[
  augroup diablehlsearchoninsert
    autocmd!
    autocmd! InsertEnter * call feedkeys("\<Cmd>noh\<cr>" , 'n')
  augroup END
]]

-- Моргает при копировании (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank({
         higroup = 'IncSearch',
         timeout = 300
      })
   end,
})

--- Удалять все пустые пробелы при сохранении
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
   command = [[:%s/\s\+$//e]],
   group = TrimWhiteSpaceGrp,
})
