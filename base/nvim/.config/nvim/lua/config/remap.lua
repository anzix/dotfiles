-- Пояснение по vim.keymap.set
-- Режимы назначения клавиш:
-- n = normal_mode - typing commands
-- i = insert_mode - typing text
-- v = visual_mode - selecting text
-- s = select_mode - selecting text and replacing it
-- x = visual_block_mode - selecting text in a block
-- t = term_mode - typing ':terminal'
-- c = command_mode - typing ':' or '/'
-- o = operator_mode - typing 'd', 'y', 'c', etc
-- CR - Return (Enter)
-- S - Shift
-- C - Control
-- A - Alt

-- INFO: Если используете плагин noice то лучше использовать `<cmd>...` для
-- безшумного поведения бинда

-- Адаптирует neovim к Русской раскладке
-- stylua: ignore start
local langmap_keys = {
	'ёЁ;`~', '№;#',
	'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP',
	'хХ;[{', 'ъЪ;]}',
	'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]],
	[[эЭ;'\"]],
	'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
}
vim.opt.langmap = table.concat(langmap_keys, ',')
-- stylua: ignore end

vim.keymap.set("n", "<leader>q", "<cmd>q<cr><esc>", { desc = "Close" })
-- vim.keymap.set("n", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set("n", "<leader>.", "<cmd>so %<cr>", { desc = "Source File" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Визуальное перемещение строк h/j/k/l с зажатым Alt
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down", silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up", silent = true })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down", silent = true })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up", silent = true })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down", silent = true })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up", silent = true })

-- Передвижение по длинным строкам (tailwind) как для j/k так и для стрелок
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Комментирование
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Окна (windows) и переключения между ними используя Crtl+hjkl
vim.keymap.set("n", "<leader>sh", "<C-W>s", { desc = "Split Window Below", remap = true }) -- Разделить по горизонтали
vim.keymap.set("n", "<leader>sv", "<C-W>v", { desc = "Split Window Right", remap = true }) -- Разделить по вертикали
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })

-- Resize окон используя <ctrl> + стрелочки
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Буферы и навигация по ним
-- TODO: Первые два не нужны?
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Закрыть буффер (bd!<CR> экстренно закрыть буфер)
vim.keymap.set("n", "<S-q>", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Табы
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- Удобное перемещение началу и окончанию строки
vim.keymap.set("n", "<A-l>", "g_", { desc = "Jump to end of line", silent = true })
vim.keymap.set("n", "<A-h>", "^", { desc = "Jump to beginning of line", silent = true })

-- Лучшая вставка (изменено с Visual на Normal)
vim.keymap.set("n", "p", '"_dP', { desc = "Better pasting", silent = true })

-- Очистить шаблон поиска на ESC
vim.keymap.set({ "i", "n" }, "<Esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- diagnostic, goto только для текущего буфера
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- keywordprg - вызов man страницы на слово под курсором
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- git blame
-- vim.keymap.set("n", "<leader>gb", "<cmd>:Git blame_line<CR>")

vim.keymap.set('n', '<leader>di', '<cmd>lua vim.cmd("DiagnosticsToggleVirtualText")<cr>', { desc = "Toggle in-line diagnostics" })
vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.cmd("DiagnosticsToggle")<cr>', { desc = "Toggle diagnostics" })


-- Из Lazy Vim... в основном.
-- BUG: при переключении относительных чисел, когда числа скрыты.
-- Последующее переключение относительных чисел скрывает числа, а не относительные.
-- Переключение чисел снова возвращает относительные числа и как я это
-- установлю, если не сделаю что-то необычное, так что пока все в порядке
-- vim.keymap.set("n", "<leader>un", function()
--   local notify = require("notify")
--   local nu = { number = true, relativenumber = true }
--   if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
--     nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--     notify("Line numbers off", vim.log.levels.INFO, { title = "Option:" })
--   else
--     vim.opt_local.number = nu.number
--     vim.opt_local.relativenumber = nu.relativenumber
--     notify("Line numbers on", vim.log.levels.INFO, { title = "Option:" })
--   end
-- end, { desc = "Toggle line numbers" })

-- vim.keymap.set("n", "<leader>ur", function()
--   local notify = require("notify")
--   local nu = vim.opt_local.relativenumber:get()
--   if nu then
--     vim.opt_local.relativenumber = false
--     notify("Relative line numbers off", vim.log.levels.INFO, { title = "Option:" })
--   else
--     vim.opt_local.relativenumber = true
--     notify("Relative line numbers on", vim.log.levels.INFO, { title = "Option:" })
--   end
-- end, { desc = "Toggle relative line numbers" })
--
-- vim.keymap.set("n", "<leader>wp", function()
--   local notify = require("notify")
--   local path = vim.api.nvim_buf_get_name(0)
--   notify("Current path: " .. path, vim.log.levels.INFO)
-- end, { desc = "Notify current buffer path" })

-- [Backslash] Переключатель заворачивания строки при достижении конца экрана
vim.keymap.set("n", "<leader>uw", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle Wrapping words", silent = true })

-- highlights under cursor
vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Быстрая замена (substitute) на текущем тексте документа
-- INFO: Если нужно во всем проекте заменить то воспользуйтесь vim.lsp.buf.rename бинда на <leader>rn
vim.keymap.set("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })
-- vim.keymap.set("n", "<leader>sb", ":%s/\\<<C-r><C-w>\\>/")

-- Выкл/вкл проверку орфографии
vim.api.nvim_set_keymap("n", "<leader>sp", ":setlocal spell!<CR>", { desc = "Enable Spell Checking" })

-- Внутри терминала, выйти из insert режима
vim.api.nvim_set_keymap('t', '<A-;>', '<C-\\><C-n>', { desc = "Switch from terminal mode to normal mode" })
