# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Вставка текста без подсветки
zle_highlight=('paste:none')

# (Plug) zsh-users/zsh-history-substring-search
autoload -U history-substring-search-up; zle -N history-substring-search-up
autoload -U history-substring-search-down; zle -N history-substring-search-down

# Ctrl+xx открывает текущую линию в $EDITOR, полезно когда пишешь функции или редактируешь множество команд.
autoload -U edit-command-line; zle -N edit-command-line

# Позволяем разворачивать сокращенный ввод, к примеру cd /u/sh в /usr/share
autoload -U compinit # Авто завершение
zmodload -i zsh/complist # Авто завершение меню

# Инициализировать завершение
# (-u): заставить все найденные файлы использоваться без запроса
compinit -u -d -C "$ZSH_COMPDUMP"
_comp_options+=(globdots) # Авто завершать со скрытыми файлами

# Настройка завершений
# Шаблон завершений
# :completion:<function>:<completer>:<command>:<argument>:<tag>
zstyle ':completion:*' use-cache on # Использовать кэширование, для улучшения завершений dpkg и apt
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}"/zsh/zcompcache
zstyle ':completion:*' rehash true # Автоматически находить новые исполняемые файлы по пути
zstyle ':completion:*' verbose true # Выводить более подробную информацию о процессе при дополнении
zstyle ':completion:*' accept-exact '*(N)' # Дополнить если имеется точное совпадение из предложенных вариантов
zstyle ':completion:*:*:*:*:*' menu select # Тип автозавершения - меню, для перемещения - стрелки
zstyle ':completion:*:match:*' original only # Показывать только исходный порядок слов, а не все возможные варианты.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Дополнение независимо от регистра
zstyle ':completion:*' list-dirs-first true # Показывать сначало каталоги при дополнении, нужен group-name ''
zstyle ':completion::complete:*' gain-privileges 1 # Автодополнения в привилегированных окружениях (sudo)
zstyle ':completion:*' completer _complete _match _approximate _ignored # Использовать функции завершающих completer для автодополнения
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories # Устанавливает порядок (тэг) автодополнений cd

# Ярлыки и категории
zstyle ':completion:*' group-name '' # Группировать различные категории завершений
zstyle ':completion:*:matches' group 'yes' # Групировать совпадающие в меню автодополнения (напр: ls -{tab})

# Автоисправление опечатков в завершениях.
zstyle ':completion:*:correct:*' original true # Отображать оригинальную команду при автоисправлении.
zstyle ':completion:*:correct:*' insert-unambiguous true # При наличии неоднозначного ввода вставлять максимально длинную неоднозначную строку.
zstyle ':completion:*:approximate:*' max-errors 1 numeric # Кол-во допустимых ошибок при автодополнения

# Добавляет цвета при авто дополнении
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Очень необходимые функции
source "$ZDOTDIR/functions.zsh"

# Загрузка пользовательских zsh файлов
file "profile.zsh"
file "options.zsh"
file "aliases.zsh"
file "bindkey.zsh"
file "vim-mode.zsh"

# Плагины (Автозагрузка, если отсутствуют)
# (plug) Для большего выбора плагинов: https://github.com/unixorn/awesome-zsh-plugins#plugins
plug "zsh-users/zsh-autosuggestions" # Автозаполнение
plug "zsh-users/zsh-syntax-highlighting" # Подсветка синтаксиса
plug "zsh-users/zsh-history-substring-search" # История zsh стрелками вверх вниз
plug "MichaelAquilina/zsh-you-should-use" # Напоминалка о использовании aliases
plug "kutsan/zsh-system-clipboard" `# Для поддержки буфера обмена в vi режиме` \
	; export ZSH_SYSTEM_CLIPBOARD_METHOD=xsc # Использовать xsel (Xorg X11)
plug "MichaelAquilina/zsh-auto-notify"
plug "hlissner/zsh-autopair" # Полезно для работы с кавычками
plug "romkatv/powerlevel10k" # Prompt
plug "junegunn/fzf" # Fuzzy finder (fzf_install функция находится в functions.zsh)
plug "zsh-users/zsh-completions"
# plug "desyncr/auto-ls" # Автоматически выполняет ls -a при cd

# (omz_plug) Плагины из репо oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
omz_plug "command-not-found" # Находит пакет если команда не найдена
# omz_plug "dirhistory" # Быстрое перемещение по каталогам зажать alt+[стрелки]

# Загрузка, должно быть последним
source $ZPLUGDIR/zsh-you-should-use/you-should-use.plugin.zsh
source $ZPLUGDIR/powerlevel10k/powerlevel10k.zsh-theme
[[ -z "${XDG_SESSION_DESKTOP}" ]] && source $ZPLUGDIR/zsh-auto-notify/auto-notify.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.zsh.
[[ ! $ZDOTDIR/p10k.zsh ]] || source $ZDOTDIR/p10k.zsh
[ -f $ZDOTDIR/fzf.zsh ] && source $ZDOTDIR/fzf.zsh
