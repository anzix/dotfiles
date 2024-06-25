local carbon_status, carbon_lua = pcall(require, "carbon")
if not carbon_status then
	return
end

carbon_lua.setup({
	auto_open = false, -- Не открывать carbon при простом открытии nvim
	sync_pwd = true, -- Запоминать раскрытые рабочие каталоги
	sidebar_width = 40, -- Ширина бокового бара (default 30)
	indicators = { collapse = "▾", expand = "▸" },
	actions = { toggle_recursive = "<s-cr>" },
	file_icons = true,
	highlights = {
		-- Прозрачное плавующее окно буффера carbon
		CarbonFloat = { bg = "none" },
	},

})

-- Руководство по биндам
-- `[` и `]` вверх и вниз на 1 уровень корневого каталога
-- `t` - широкий обзор
-- `ctrl+v` или `ctrl+s` Редактировать файл с вертикальным или горизонтально
-- `c` или `%` Создание файлов и каталогов (в конце пути прописать /) (Подтвердить Enter, отменить Esc)
-- `m` Перемещение файлов и каталогов (при промпте указываете назначение)
-- `d` Удаление файлов и каталогов (с подтверждением)

-- Ctrl+d: Бинд на открытие дерево каталогов, закрыть буфер carbon на `q`
vim.keymap.set("n", "<C-d>", ":Lc<CR>", { silent = true })
