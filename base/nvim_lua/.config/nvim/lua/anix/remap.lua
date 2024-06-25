-- Пояснение по vim.keymap.set
-- Назначение клавиш
-- (n)noremap – Normal Mode.
-- (i)noremap – Insert Mode.
-- (v)noremap – Visual Mode.
-- (x)noremap - Visual Block Mode.
-- (t) - term_mode
-- (c) - command_mode
-- CR - Return (Enter)
-- S - Shift
-- C - Control
-- A - Alt

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

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true }) -- выйти
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true }) -- сохранить
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- сделать исполняемым файл
vim.keymap.set("n", "<leader>r", ":so %<CR>", { noremap = true }) -- применить (source) файл

-- Визуальное перемещение строк H/J/K/L с зажатым shift
-- Visual Mode
vim.keymap.set("v", "S-h", "<gv")
vim.keymap.set("v", "S-l", ">gv")
vim.keymap.set("v", "S-j", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "S-k", ":m '<-2<CR>gv=gv")
-- Visual Block
vim.keymap.set("x", "<S-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<S-k>", ":m '<-2<CR>gv=gv")

-- Передвижение по длинным строкам (tailwind)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [Backslash] Переключатель заворачивания строки при достижении конца экрана
vim.keymap.set("n", "\\", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", { silent = true })

-- Сплиты
-- Переключатся между сплитами
-- Crtl+hjkl
vim.keymap.set("n", "sh", ":split<CR>")
vim.keymap.set("n", "sv", ":vertical split<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h" )
vim.keymap.set("n", "<C-l>", "<C-w>l" )
vim.keymap.set("n", "<C-j>", "<C-w>j" )
vim.keymap.set("n", "<C-k>", "<C-w>k" )

-- Навигация буферов
vim.keymap.set("n", "<A-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- Удобное перемещение началу и окончанию строки
vim.keymap.set("n", "<S-l>", "g_", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "^", { noremap = true, silent = true })

-- Лучшая вставка (изменено с Visual на Normal)
vim.keymap.set("n", "p", '"_dP', { silent = true })

-- Очистить шаблон поиска на ESC
vim.keymap.set("n", "<Esc>", ":noh<CR><CR>")

-- Закрыть буффер (bd!<CR> экстренно закрыть буфер)
vim.keymap.set("n", "<S-q>", ":bd<CR>", { noremap = true, silent = true })

-- Не использовать Shift при вызове режима COMMAND (ломаются некоторые бинды)
-- vim.api.nvim_set_keymap('', ';', ':', {noremap = true})
-- vim.api.nvim_set_keymap('', ':', ';', {noremap = true})

-- Быстрое форматирование строк
vim.keymap.set("n", "TT", function()
	vim.lsp.buf.format({ timeout_ms = 5000 }) -- Чтобы форматировал длинные файлы
end)

-- git blame
-- vim.keymap.set("n", "<leader>gb", "<cmd>:Git blame_line<CR>")

-- Быстрая замена (substitute)
vim.keymap.set("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>sb", ":%s/\\<<C-r><C-w>\\>/")

-- Переводчик
-- Параметры для опции -output=
-- split - раздельное окно
-- floating - плавающее окно (не показывается если юзать на vim.lsp.buf.hover)
-- replace - заменять ориг. текст (не работает на vim.lsp.buf.hover)
vim.keymap.set("v", "ts", ":Translate RU -source=EN -output=split<CR>", { silent = true })
vim.keymap.set("x", "ts", ":Translate RU -source=EN -output=split<CR>", { silent = true })
vim.keymap.set("v", "tr", ":Translate RU -source=EN -output=replace<CR>", { silent = true })
vim.keymap.set("x", "tr", ":Translate RU -source=EN -output=replace<CR>", { silent = true })

-- Выкл/вкл проверку орфографии
vim.api.nvim_set_keymap("n", "<leader>sp", ":setlocal spell!<CR>", {})

-- Внутри терминала, выйти из insert режима
vim.api.nvim_set_keymap('t', '<A-;>', '<C-\\><C-n>', {})

-- MarkdownPreview
vim.keymap.set("n", "<leader>pv", function()
	vim.cmd("MarkdownPreviewToggle")
end, { desc = "MD: [P]re[v]iew Markdown" })
