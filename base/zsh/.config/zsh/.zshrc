# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Отключает комбинацию ctrl+s которая заставляет терминал зависнуть намертво
# Закоментированно из-за p10k output'а "stty: 'стандартный ввод': Неприменимый к данному устройству ioctl
# https://catonmat.net/annoying-keypress-in-linux
# stty stop undef

# Альтернативная команда для тех кто юзает p10k
# (https://github.com/romkatv/powerlevel10k/issues/388)
stty -ixon <$TTY >$TTY

# Добавляет цвета в shell
eval "$(dircolors -b)"

# Вставка текста без подсветки
zle_highlight=('paste:none')

# (Plug) zsh-users/zsh-history-substring-search
autoload -U history-substring-search-up
autoload -U history-substring-search-down
zle -N history-substring-search-up
zle -N history-substring-search-down

# Ctrl+xx открывает текущую линию в $EDITOR, полезно когда пишешь функции или редактируешь множество команд.
autoload -U edit-command-line
zle -N edit-command-line

# Basic auto/tab complete
# Позволяем разворачивать сокращенный ввод, к примеру cd /u/sh в /usr/share
autoload -U compinit colors
zmodload zsh/complist
compinit -d
colors
_comp_options+=(globdots) # Включая скрытые файлы

zstyle ':completion:*' menu select # Позволяет перемещаться с помощью стрелок
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Авто завершение независимо от регистра
# unsetopt CASE_GLOB
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' accept-exact '*(N)'

# Использовать кэширование, чтобы сделать автодополнение для таких команд, как dpkg и apt, пригодным для использования.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}"/zsh/zcompcache
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-dirs-first true

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ssh/scp/rsync
zstyle ':completion:*:(ssh|scp|rsync):*:hosts' ignored-patterns 'localhost*' loopback
zstyle -e ':completion:*:hosts' hosts 'reply=()'


# Цвета при авто дополнении
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# Очень необходимые функции
source "$ZDOTDIR/functions.zsh"

# Normal files to source
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
plug "MichaelAquilina/zsh-auto-notify" # Уведомления shell
plug "hlissner/zsh-autopair" # Полезно для работы с кавычками
plug "romkatv/powerlevel10k" # Prompt
plug "junegunn/fzf" # Fuzzy finder (fzf_install функция находится в functions.zsh)
# plug "Aloxaf/fzf-tab" # Replace zsh's default completion selection menu with fzf!


# (omz_plug) Плагины из репо oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# Находит пакет если команда не найдена
omz_plug "command-not-found" \
	; [[ ! -f /bin/pkgfile ]] \
	&& sudo pacman -S pkgfile --noconfirm \
	&& sudo pkgfile -u \
	&& sudo systemctl enable pkgfile-update.timer
# omz_plug "dirhistory" # Быстрое перемещение по каталогам зажать alt+[стрелки]


source $ZPLUGDIR/zsh-you-should-use/you-should-use.plugin.zsh
source $ZPLUGDIR/zsh-auto-notify/auto-notify.plugin.zsh
source $ZPLUGDIR/powerlevel10k/powerlevel10k.zsh-theme


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.zsh.
[[ ! $ZDOTDIR/p10k.zsh ]] || source $ZDOTDIR/p10k.zsh
[ -f $ZDOTDIR/fzf.zsh ] && source $ZDOTDIR/fzf.zsh
