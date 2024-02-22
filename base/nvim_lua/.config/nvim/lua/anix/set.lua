local opt = vim.opt

opt.nu = true -- Показывает номера строк
opt.relativenumber = true -- Относительные номера строк
opt.tabstop = 3 -- Кол-во пробелов при табе
opt.softtabstop = 3 -- Кол-во пробелов за одну табуляцию
opt.shiftwidth = 3 -- Кол-во пробелов/строк для выравнивания/переносе
-- opt.expandtab = true -- Конвертирует табы в пробелы
opt.smartindent = true -- Вкл. 'умный' отступ для кода

-- Для Lualine статус линии
opt.laststatus = 3 -- Меньше лишнего на экране
opt.showmode = false -- Убирает текст по типу `-- Вставка --`

opt.pumheight = 10 -- Кол-во элементов при cmp
opt.pumblend = 10 -- Прозрачность списка cmp

opt.splitbelow = true -- Принудительный фокус на горизонтальные сплиты
opt.splitright = true -- Принудительный фокус на вертикальные сплиты


opt.wrap = true -- Заворачивать строки при достижении конца экрана

opt.encoding = "utf-8" -- Кодировка по дефолту
opt.ffs = "unix,dos,mac" -- Формат файла, влияющий на окончания строк - будет перебирать в указанном порядке
opt.fileencodings = "utf-8,cp936,cp1251" -- Список кодировок файлов для автоопределения

opt.list = true -- Без этой опции не будет работать listchars
opt.listchars = "tab:→ ,nbsp:•,trail:•,extends:⟩,precedes:⟨" --,eol:↴
-- opt.showbreak = "↪"

opt.clipboard = "unnamedplus" -- Включает буффер обмена

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir" -- Место для сохранения истории undo
opt.undofile = true -- Позволяет юзать undo и redo при закрытии и открытии файла
opt.undolevels = 1000 -- Размер истории для (u)ndo команд (vim default 100)
opt.autoread = true -- Обновить файл, если он был изменен снаружи

opt.hlsearch = true -- Подсвечивает при поиске ввода
opt.incsearch = true -- Перескакивать при первом совпадении
opt.ignorecase = true -- Игнорировать регистр букв
opt.smartcase = true -- Если юзать Заглавные, поиск будет с учётом заглавных

-- Установить стиль курсора (:help 'guicursor')
opt.guicursor = 'n-v-c-sm:block-blinkon300,i-ci-ve:ver25-blinkon300,r-cr-o:hor20'

-- Необходимо для работы nvim-colorizer
opt.termguicolors = true

-- Выделять соответствие [{()}]
opt.showmatch = true

-- Удаляет баннер в проводнике
vim.g.netrw_banner = 0

-- Включить проверку орфографии
-- leader+sp
-- Перемещение по орфографическим ошибкам (назад/вперед)
-- [s | ]s
-- Исправление слово с выбором
-- z=
-- Быстрое исправление
-- [цифра]z=
-- Праавильно
-- Corrrect
-- Добавить слово в исключение
-- zg
-- Обноеление spell файла
-- edit spell.add
-- :mkspell! %
-- https://thoughtbot.com/blog/opt-in-project-specific-vim-spell-checking-and-word-completion
opt.spell = false
opt.spellfile = os.getenv("HOME") .. "/.config/nvim/spell/spell.add"
opt.spelllang = "ru_ru,en_us"
opt.spellsuggest = '20'
opt.complete:append 'kspell'

opt.scrolloff = 99
opt.signcolumn = "yes" -- Всегда показывать столбец для gitsigns, lsp и дебаггера
opt.isfname:append("@-@") -- ??
opt.whichwrap:append("<,>,[,],h,l") -- Перемещать курсор в режиме i/v/r стрелками или h/l в конце или начале строки


opt.updatetime = 100 -- Скорость cmp (4000ms default)

opt.colorcolumn = "80"

-- Цвет пустых пробелов
vim.g.better_whitespace_guicolor = "#3e32a8"

-- Адаптирует neovim к Русской раскладке (будут задержки между переключениями режимов)
-- opt.langmap =
-- 	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
