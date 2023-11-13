# Никто, кроме пользователя wheel и root, не может читать/записывать новые файлы
# umask 077

# История shell
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# PATH
export PATH=$HOME/.local/bin:$PATH:$HOME/.local/bin/scripts

# Программы по умолчанию
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERM='xterm-256color'
export TERMINAL="alacritty"
export BROWSER="chromium"
export READER="zathura"
export LESS='-R' # Цвета через less
export MANPAGER='nvim +Man!' # Запускает man'уал через редактор nvim, очень удобно
export DIFFPROG="nvim -d" # Для использования neovim в pacdiff
# export MANPAGER="less -R --use-color -Dd+g -Du+b -Ds+r -DS+r -DP+r -DE+r"

# Игнор команд из истории
# Игнорируемые команды остаются только в текущей сессии, открыв новую они пропадают
export HISTORY_IGNORE="(ls|cd|cd ..|cd -|pwd|zsh|exit|reboot|sudo reboot|poweroff|clear|history)"

# Пользовательские директории
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# ~/ Clean-up
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh" # Папка zsh
export ZPLUGDIR="$ZDOTDIR/plugins" # Папка zsh плагинов
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
export LESSHISTFILE="-" # Перестаёт создавать в $HOME файл .lesshst
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CONFIG_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_STATE_HOME/history"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PYTHONDONTWRITEBYTECODE=1 # Предотвращает создание папок __pycache__ и pycache
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export DOTNET_CLI_TELEMETRY_OPTOUT=1 # Отключает телеметрию .NET
export GOTELEMETRY=off # Отключает телеметрию GO
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.

# Отключает winemenubuilder, который загрязняет меню приложений
export WINEDLLOVERRIDES="winemenubuilder.exe="

# Предотващяет wine установку Mono/Gecko
# export WINEDLLOVERRIDES="mscoree,mshtml="

# Только ошибки и предупреждения wine
# export WINEDEBUG=-all,+err,+warn

# (X11) Mozilla smooth scrolling/touchpads.
export MOZ_USE_XINPUT2="1"

# Ширина man'уала. 80 default, 999 максимум (ломает некоторые мануалы)
export MANWIDTH=80

# Подавляет предупреждения о accessibility bus в GTK
export NO_AT_BRIDGE=1

# GPG
# if [[ -S "/run/user/${UID}/ssh-agent" ]]; then
#   export SSH_AUTH_SOCK="/run/user/${UID}/ssh-agent"
# fi
#export GPG_TTY=$(tty)

# https://github.com/mverna27/dotfiles/blob/base/.zshrc
# Или использовать systemd сервис
# systemctl --user enable ssh-agent.service
# automatically start ssh-agent and make sure that only one ssh-agent process runs at a time
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
# Необходимо как и для systemd сервиса так и без
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


# LF иконки (требуется шрифты семейства Nerd)
export LF_ICONS="di=:fi=:ln=:or=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.PNG=:*.svg=:*.svgz=:*.mov=:*.mpeg=:*.mkv=:*.m4v=:*.webm=:*.mp4=:*.wmv=:*.avi=:*.flv=:*.flac=:*.mp3=:.m4a=:*.wav=:*.pdf=:*.iso=:*.img=:*.gitignore=:*.vimrc=:*.viminfo=:*.nix=:ex="

# Запуск i3 на tty1 после входа в систему, если он еще не запущен
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && startx $XINITRC

# sway
# [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && exec sway # --verbose >> ~/.cache/sway.log # /var/log/sway.log
