### Бинды

# Отключает комбинацию ctrl+s которая заставляет терминал зависнуть намертво
# Закоментированно из-за p10k output'а "stty: 'стандартный ввод': Неприменимый к данному устройству ioctl
# https://catonmat.net/annoying-keypress-in-linux
# stty stop undef

# Альтернативная команда для тех кто юзает p10k
# (https://github.com/romkatv/powerlevel10k/issues/388)
stty -ixon <$TTY >$TTY

# Plug 'zsh-users/zsh-history-substring-search'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Доп. функционал печатания
bindkey '^[[2~' overwrite-mode # Insert key
bindkey '^[[1;5C' forward-word # ctrl + right
bindkey '^[[1;5D' backward-word # ctrl + left
bindkey '^[[3~' delete-char # Клавиша Del
# bindkey '^H' backward-kill-word # ctrl + backspace НЕ работает
bindkey '^[[3;5~' kill-word # ctrl + del

# Ctrl+xx открывает редактирование в $EDITOR
bindkey '^x^x' edit-command-line

# Vim фунционал
bindkey '^[u' undo # Alt+u
bindkey '^[r' redo # Alt+r

# dirhistory plugin
# Alt+Left   # cd into the previous directory
# Alt+Right  # cd into the next directory
# Alt+Up     # cd into the parent directory
# Alt+Down   # cd into a child directory


