local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- opt.expandtab = true

opt.smartindent = true -- Вкл 'умный' отступ для кода

-- Для Lualine статус линии
opt.laststatus = 2
opt.showmode = false

opt.wrap = true

opt.encoding = "utf-8" -- Кодировка по дефолту
opt.ffs = "unix,dos,mac" -- Формат файла, влияющий на окончания строк - будет перебирать в указанном порядке
opt.fileencodings = "utf-8,cp936,cp1251" -- Список кодировок файлов для автоопределения

opt.list = true -- Без этой опции не будет работать listchars
opt.listchars = "tab:→ ,nbsp:•,trail:•,extends:⟩,precedes:⟨" --,eol:↴
-- opt.showbreak = "↪"

opt.clipboard = "unnamed,unnamedplus" -- Включает буффер обмена

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
opt.undofile = true -- Позволяет юзать undo и redo при закрытии и открытии файла
opt.undolevels = 1000 -- Размер истории для (u)ndo команд (vim default 100)
opt.autoread = true -- Обновить файл, если он был изменен снаружи

opt.hlsearch = true -- Подсвечивает при поиске ввода
opt.incsearch = true -- Перескакивать при первом совпадении
opt.ignorecase = true -- Игнорировать регистр букв
opt.smartcase = true -- Если юзать Заглавные, поиск будет с учётом заглавных

-- Установить стиль курсора (:help 'guicursor')
opt.guicursor = 'n-v-c-sm:block-blinkon300,i-ci-ve:ver25,r-cr-o:hor20'

-- Необходимо для работы nvim-colorizer
opt.termguicolors = true

-- Выделять соответствие [{()}]
opt.showmatch = true

-- remove banner in file explorer
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
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

-- Цвет пустых пробелов
vim.g.better_whitespace_guicolor = "#3e32a8"

-- Адаптирует neovim к Русской раскладке (будут задержки между переключениями режимов)
-- opt.langmap =
-- 	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
