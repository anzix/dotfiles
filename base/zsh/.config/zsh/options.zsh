# Some useful options (man zshoptions)
setopt AUTO_CD                 # Переход в директорию без ввода cd
setopt EXTENDED_GLOB           # Использовать #, ~ и ^ в шаблонах. Не забудьте поставить '^', '~' и '#' в кавычки!
setopt autoparamslash          # При автодополнении содержащий каталог в конце добавляется /.
setopt NO_NOMATCH              # При отсутствии результатов globbing-а, не показывалась ошибка, а введённое выражение использовалось как есть. Пример: echo =foo
setopt interactive_comments    # Разрешает # комментарии в shell, для копирования и вставки
setopt nocheckjobs             # Не предупреждать о запущенных процессах при выходе используя команду exit
setopt numericglobsort         # Сортировать имена файлов по номерам для ls
setopt rcexpandparam           # Раскрывает параметры при чтении команд из zshrc
setopt prompt_subst            # Для правильного отображения промта
setopt BRACE_CCL               # Включение поддержки выражений вроде «{1-3}» или «{a-d}» — они будут разворачиваться в «1 2 3» и «a b c d». Пример: echo {1-5}
setopt longlistjobs            # Отображать PID о приостановке процесса (Ctrl+Z)

## History command configuration
setopt APPEND_HISTORY          # Добавляет список историй в файл истории zsh
setopt extended_history        # Сохраняет временную метку начала и продолжительность каждой команды в файл истории.
setopt share_history           # Позволяет делится историей shell между другими терминалами (сессиями)
setopt INC_APPEND_HISTORY      # Сохранять команды в истории немедленно, а не при выходе из оболочки
setopt HIST_REDUCE_BLANKS      # Убирать из истории zsh пустые строки в командах (в начале)
setopt hist_expire_dups_first  # Удалять дублирующиеся строки для уменьшения истории
setopt hist_ignore_dups        # Не допускать смежных повторений в истории
setopt hist_find_no_dups       # Никогда не показывать дубликаты в истории
setopt hist_save_no_dups       # Удалять дубликаты при сохранении истории
