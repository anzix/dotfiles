# Если нет исполняемого файла fzf тогда начнётся его установка
[[ ! -f $ZPLUGDIR/fzf/bin/fzf ]] && $ZPLUGDIR/fzf/install --bin --no-bash --no-fish --no-update-rc

# ---------
if [[ ! "$PATH" == *$HOME/.config/zsh/plugins/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/zsh/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/zsh/plugins/fzf/shell/key-bindings.zsh"
