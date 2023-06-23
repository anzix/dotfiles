" Автоматически устанавливает менеджера плагинов vimplug если нет
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif


""" Список Vim плагинов -----------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged') | "Plugin manager Vim-Plug

"" Aesthetics
" Тема для vim
" Plug 'dracula/vim' " Тема dracula
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } |  "Color Scheme Nightfly
" Иконки
Plug 'ryanoasis/vim-devicons' | " Иконки Nerd
" Пользовательский интерфейс
Plug 'vim-airline/vim-airline' | " Более современная статус линия
Plug 'vim-airline/vim-airline-themes' | " Темы для airline

" Syntax highlighting
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } | " Показывает hex палитру цветов
Plug 'machakann/vim-highlightedyank' | "Моргает при копировании

"" Функциональность
" Git
Plug 'tpope/vim-fugitive' | "Показывает название ветки git
Plug 'airblade/vim-gitgutter' | "Показывает изменённые строки кода/конфига
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | " Файловый менеджер
Plug 'ntpeters/vim-better-whitespace' | "Показывает пробелы
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' } | "Предпросмотр md через браузер
Plug 'windwp/nvim-autopairs' | "Удобная работа с кавычками
" Code

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' | " fuzzy finder на стероидах

"" Более эффективные (ленивые) плагины
Plug 'mg979/vim-visual-multi' | "Режим visual на стероидах (multi режим)
Plug 'tpope/vim-commentary' | "Быстрое комментирование строк комбинацией клавиш gcc comment line (gcc again to uncomment). Работает и при выделении
Plug 'akinsho/bufferline.nvim' | "Продвинутые табы, теперь появляются всегда
Plug 'skanehira/translate.vim' | " Переводчик
Plug 'tpope/vim-surround' | " Удобная работа с скобками и ковычками
Plug 'rpdelaney/vim-sourcecfg' | " Синтаксис для Valve's Source Engine
call plug#end()

""" Настройки ---------------------------------------------------------

" Основные
set nocompatible | " Включаем несовместимость настроек с Vi
set wrap | " Включение переноса строк
set mouse=a | "Поддержка мыши (режим: все)
syntax enable | " Подсветка синтаксиса
set showmatch | " Показывать первую скобку после ввода второй
set number | " Показывать нумерацию строк
set relativenumber | " Показывает относительные номера строк
set autoindent | " Авто отступ для кода
set smartindent | " Вкл 'умную' отступ для кода


" Внешний вид
set laststatus=2 | " Статус линия airline
set noshowmode | " Не показывать стандартную статус линию
set termguicolors | " Юзать правильные цвета
colorscheme tokyonight-moon | " Тема neovim



set title | " Будет показывать заголовок редактируемого файла
"set cursorline | " Подсвечивает курсор по горизонтально -
"set cursorcolumn | " Подсвечивает курсор по вертикали |

set belloff=all | " Полное отключение звука ошибок
"set noerrorbells
"set novisualbell | " Появляется звук когда делаю что-то не то


" Кодировка
set encoding=utf-8 | " Кодировка по дефолту
set termencoding=utf-8 | " Кодировка по дефолту
set fileformat=unix | " Формат файла по дефолту
set ffs=unix,dos,mac | " Формат файла, влияющий на окончания строк - будет перебирать в указанном порядке
set fileencodings=utf-8,cp936,cp1251 | " Список кодировок файлов для автоопределения

" Tabs
set tabstop=4 | " 4 пробела на tab
set shiftwidth=4 | " Размер сдвига при нажатии на клавиши < и >
set softtabstop=4 | " Количество пробелов, которыми символ табуляции отображается при добавлении
" set expandtab | " В реж. insert заменяет символ табуляции на соответствующее количество пробелов

" Поиск
set hlsearch | " Подсвечивает при поиске ввода
set incsearch | " Перескакивать в поиске при первом совпадении
set ignorecase | " Игнорировать регистр букв при поиске /
set smartcase | " Если юзать Заглавные, поиск будет с учётом заглавных


" Разное полезное

set viminfo+=n~/.cache/nvim/viminfo
set backupdir=~/.cache/nvim/backup | "Директория для сохранения backup'ов файлов
set directory=~/.cache/nvim/swap | "Директория для сохранения swap файлов
set undofile | " Позволяет юзать undo и redo при закрытии и открытии файла
set undolevels=1000 | " Размер истории для (u)ndo команд (vim default 100)
set history=1000 | " Размер истории для : команд (vim default 50)
set scrolloff=99 | " Чтобы курсор находился по середине
set noswapfile | " Отключает swap (раздражает)
set ruler | "Показывать строку с позицией курсора

filetype plugin indent on | " Определение отступа по типу файла
filetype plugin on | "Load file type plugins + indentation

set t_Co=256 | "Поддержка 256 цветов
set clipboard^=unnamed,unnamedplus | "Добавляет поддержку clipboard в vim на всей системе
set showcmd | "Показывает частичные команды в последней строке экрана
" set cmdheight=2 | " Дать больше информации cmd
set timeoutlen=5000 ttimeoutlen=0 | " Минимальная задержка с insert mode в normal mode
set autoread | "Авто-перезагрузка файла в VIM, как только он меняется на диске из другого редактора
" set showbreak=↪\ | "Показывает символ ↪ на строку которая была перенесена
set list listchars=tab:→\ ,nbsp:•,trail:•,extends:⟩,precedes:⟨ | "Доп символы для удобство чтения и оформления кода
",eol:↲

" Убирает верхний баннер из vim file browser
let g:netrw_banner = 0


""" vimwiki -----------

""" markdown-preview.nvim
" Автозапуск предпросмотра когда открыт буфер nvim
let g:mkdp_auto_start = 0


""" Nerd Tree config ---------------------------------------------------------

" Автоматически обновлять буфер после переименования файла
let NERDTreeAutoDeleteBuffer = 1
" Показать скрытые файлы
let NERDTreeShowHidden = 1
" Нумерация строк
let NERDTreeShowLineNumbers = 1
" Открывать с left/right стороны
let g:NERDTreeWinPos = "left"

""" Оформление

" let g:airline_powerline_fonts = 1
" let g:airline_theme='minimalist'
" let g:airline_theme='deus'
" let g:airline_theme='transparent'
let g:airline_theme='hybrid'
" set background=dark | "Использовать цвета для темного background'a
highlight normal guibg=NONE | " Делает vim/neovim прозрачным
highlight SignColumn guibg=NONE | " vim-gittutter прозрачная линия
highlight NormalNC guibg=NONE | " прозрачное окно буффера

" Мерцание линейного курсора в insert mode и мерцающий кирпичный курсор в normal mode (необходимо поддержка опций на стороне терминала)
" Пояснение
" \e[0 q -> Мерцающий ▇ Block.
" \e[1 q -> Мерцающий ▇ Block (default).
" \e[2 q -> Не мерцающий ▇ Block.
" \e[3 q -> Мерцающая _ Underline.
" \e[4 q -> Не мерцающая _ Underline.
" \e[5 q -> Мерцающий | Beam (xterm).
" \e[6 q -> Не мерцающий | Beam (xterm).
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

""" Git Gutter -----------------------------------------------------
"" https://github.com/airblade/vim-gitgutter

nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 1 "" 0 - выкл бинды gitgutter, 1 - вкл.
let g:gitgutter_highlight_liners = 1


" Включить проверку орфографии
" Space+sp
" Исправить слово, выбераете (ниже пример) и жмёте
" z=
" Перед нами вылезет окно с предложениями по исправлению
" Выбираете по цифре или просто кликнув на подходящее слово
" Чтобы быстро исправить вариантом выберите слово и жмёте
" [число]z=
" Праавильно
" Corrrect
" Добавить слово в исключение
" zg
set spell spelllang=en_us,ru
set spellfile=~/.config/nvim/spell/my-dictionary.utf-8.add | " Мой файл со словарём
setlocal spell! | " Отключает spell check при запуске файла (Включение Space+sp)


""" Other Stuff -----------------------------------------------------------------

" Enable hotkeys for Russian layout
" https://github.com/vim/vim/blob/master/runtime/doc/russian.text
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

"" Прокрутка по длинным строкам
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Cохранение позиции курсора
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

""" Vim-hexokinase -----------------------------------------------------

let g:Hexokinase_refreshEvents = ['InsertLeave']

let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]

let g:Hexokinase_highlighters = ['backgroundfull'] " Можно поставить ['virtual'] чтобы было как в VSCode

" Reenable hexokinase on enter
autocmd VimEnter * HexokinaseTurnOn


""" vim-better-whitespace -----------------------------------------------------
let g:better_whitespace_guicolor='#3e32a8' | "Цвет пробела (для плагина ntpeters/vim-better-whitespace)

""" Переводчик
" Перевод с англ на рус
let g:translate_source = "en"
let g:translate_target = "ru"
let g:translate_popup_window = 0 | " никаких перекрывающих окон

""" Key mapping -----------------------------------------------------------------

"Пояснение
" nnoremap – назначает клавиши в normal mode.
" inoremap – назначает клавиши в insert mode.
" vnoremap – назначает клавиши в visual mode.


" Переводчик
vmap t <Plug>(VTranslate)

" Copy selected text to system clipboard
vnoremap <C-c> "+y | " Crtl+c - копировать

" Nerd Tree Toggle
nnoremap <C-d> :NERDTreeToggle<CR> | " Ctrl+d - открывает файловый менеджер NerdTree внутри vim/nvim)

""" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr> | " Обычный fuzzy finder для файлов
nnoremap <leader>fg <cmd>Telescope live_grep<cr> | " Юзабилити +100
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



" Визуальное перемещение строк вниз (J) и вверх (K) с зажатым shift (Работает
" и с выделением)
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Предотвращает перемещение курсора на один символ назад при Esc из режима insert в Vim/Nvim
" https://stackoverflow.com/questions/2295410/how-to-prevent-the-cursor-from-moving-back-one-character-on-leaving-insert-mode
" inoremap <silent> <Esc> <Esc>`^

" Сохранить файл с sudo привелегиями
" nnoremap <Leader>W :w !sudo tee % > /dev/null
" cmap w!! w !sudo tee > /dev/null %
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

let mapleader = "\<Space>" | "Клавиша Space для работы нижних команд
nnoremap <Leader>w :w<CR> | "Space+w - Сохранить файл
nnoremap <Leader>q :q<CR> | "Space+q - Выйти из vim'а
nnoremap <Leader>x :x<CR> | "Space+x - Выйти из vim'а
nnoremap <leader>s :StripWhitespace<CR> | "Space+s - Убирает пробелы везде

nnoremap <leader>/ :noh<CR> | "Space+/ - Убирает подсветку при поиске
nnoremap <leader>sp :setlocal spell!<CR> | "Space+sp - выкл вкл spell checking


" Tabs & Navigation
map <leader>nt :tabnew<cr>      " Space+t - Открывает вкладку (Следующая вкладка: gt, Предыдущая вкладка: gT)
map <leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tc :tabclose<cr>    " To close the current tab.

" Перемещение курсором по vim клавишам клавы
map <C-k> <C-w><Up>     | "k - вверх
map <C-j> <C-w><Down>   | "j - вниз
map <C-l> <C-w><Right>  | "l - вправо
map <C-h> <C-w><Left>   | "h - влево

lua << EOF
require("bufferline").setup{}
require("nvim-autopairs").setup {}
EOF
