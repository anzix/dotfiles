# Some useful options (man zshoptions)
setopt NO_BEEP                 # Не пищать при дополнении или ошибках
setopt AUTO_CD                 # Можно переходить в директории без ввода cd
setopt EXTENDED_GLOB           # Использовать #, ~ и ^ в шаблонах (https://linuxhint.com/bash_globbing_tutorial/)
setopt autoparamslash          # If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space
setopt NO_NOMATCH              # При отсутствии результатов globbing-а, не показывалась ошибка, а введённое выражение использовалось как есть. Пример: echo =foo
setopt interactive_comments    # Разрешает # комментарии в shell, для копирования и вставки
setopt nocheckjobs             # Не предупреждать о запущенных процессах при выходе (exit)
setopt numericglobsort         # Sort filenames numerically when it makes sense
setopt rcexpandparam           # Array expension with parameters
setopt prompt_subst            # Для правильного отображения промта
setopt BRACE_CCL               # Включение поддержки выражений вроде «{1-3}» или «{a-d}» — они будут разворачиваться в «1 2 3» и «a b c d».Пример: echo {1-5}

## History command configuration
setopt APPEND_HISTORY          # Добавляет список историй в файл истории zsh
setopt share_history           # Позволяет делится историей shell между другими терминалами (сессиями)
setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
setopt HIST_REDUCE_BLANKS      # Убирать из истории zsh пустые строки в командах (в начале)
setopt hist_expire_dups_first  # Удалять дублирующиеся строки для уменьшения истории
setopt hist_ignore_dups        # Не допускать смежных повторений в истории
setopt hist_find_no_dups       # Никогда не показывать дубликаты в истории
setopt hist_save_no_dups       # Удалять дубликаты при сохранении истории
