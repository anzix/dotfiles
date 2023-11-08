# Vi Mode
# Вход в normal mode - esc
# (i) или (a) обратно в insert mode
# (v) - visual mode
bindkey -v

# Нет задержки перехода в vi mode
export KEYTIMEOUT=1

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Менять форму курсора для разных режимах vi.
# Пояснение
# '\e[0 q' -> Мерцающий ▇ Block.
# '\e[1 q' -> Мерцающий ▇ Block (default).
# '\e[2 q' -> Не мерцающий ▇ Block.
# '\e[3 q' -> Мерцающая _ Underline.
# '\e[4 q' -> Не мерцающая _ Underline.
# '\e[5 q' -> Мерцающий | Beam (xterm).
# '\e[6 q' -> Не мерцающий | Beam (xterm).
function zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;      # ▇ Block
    viins|main) echo -ne '\e[5 q';; # | Beam
  esac
}

zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}

zle -N zle-line-init

echo -ne '\e[5 q' # Юзать форму курсора Beam при старте терминала.
preexec() { echo -ne '\e[5 q' ;} # Юзать форму курсора Beam для каждого нового prompt'а.
