# Полезные опций (man zshoptions)
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
setopt longlistjobs            # Отображать PID о приостановке процесса используя Ctrl+z

## Конфигурация истории shell
setopt APPEND_HISTORY            # Добавляет список историй в файл истории zsh
setopt INC_APPEND_HISTORY        # Сохранять команды в истории немедленно, а не при выходе из оболочки
setopt EXTENDED_HISTORY          # Сохраняет временную метку начала и продолжительность каждой команды в файл истории
setopt SHARE_HISTORY             # Позволяет делится историей shell между другими терминалами (сессиями)
setopt HIST_EXPIRE_DUPS_FIRST    # Удалять ранние дублирующиеся строки для уменьшения истории
setopt HIST_IGNORE_DUPS          # Не показывает повторённые команды в истории
setopt HIST_IGNORE_ALL_DUPS      # Игнорить все повторения команд в shell'е при использовании стрелочек
setopt HIST_REDUCE_BLANKS        # Удаляет лишние пробелы из каждой командной строки добавляемой в истории
setopt HIST_FIND_NO_DUPS         # Не показывать дубликаты команд в истории при поиске
setopt HIST_SAVE_NO_DUPS         # Удалять дубликаты при сохранении истории
