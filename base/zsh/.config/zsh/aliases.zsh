# Весь список alias, функции, пути одим списком
alias \
 alist="alias | sed 's/=.*//'" \
 fncla="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" \
 fncl='declare -f $(grep -oP "^[a-zA-Z0-9_]+(?=\\s*\\(\\))" $ZDOTDIR/functions.zsh) | grep "^[a-z].* ()" | sed "s/{$//"' \
 paths='echo -e ${PATH//:/\\n}'

# Юзать doas вместо sudo (если присутствует)
if hash doas 2>/dev/null; then
 alias sudo='doas'
else
 # Позволяет юзать sudo [alias]
 # TODO: Добавить аргумент -E
 alias sudo='sudo '
fi

# Использовать замену ls - eza, если доступно
if hash exa 2>/dev/null; then
 # FIXME: при использовании `ls *.jpg | xargs ..` не будет работать по причине включенных иконок
 alias \
  ls='exa -b --color=always --icons --group-directories-first' `# (-b) Понятные размеры файлов +Цвета +Иконки, Сгруппировано` \
  ll='ls -l' `# +Подробно +листом вниз` \
  la='ls -a' `# +Показ скрытых` \
  lla='ls -la' `# +Подробно +Показ скрытых +листом вниз` \
  lt="exa -aT --color=always --icons --group-directories-first -h --git-ignore --ignore-glob '.git|.gitignore|.DS_Store|node_modules'" `# Дерево (-h) Добавляет строку заголовка в каждый столбец` \
  lt1="lt -L 1" \
  lt2="lt -L 2" \
  lt3="lt -L 3" \
  l.='exa -d .* --group-directories-first' `# Показать только . (dot)`
else
 # GNU `ls` с `tree`
 alias \
  ls='ls --color=auto --group-directories-first' \
  ll='ls -l' `# +Подробно +листом вниз` \
  la='ls -a' `# +Показ скрытых` \
  lla='ls -la' `# +Подробно +Показ скрытых +листом вниз` \
  lt='tree -aC --dirsfirst --gitignore -I ".git|.gitignore|.DS_Store|node_modules"' \
  lt1='lt -L 1' \
  lt2='lt -L 2' \
  lt3='lt -L 3' \
  l.='ls -d .*' `# Показать только . (dot)`
fi

# Навигация
# alias \
#  ...='cd ../../' \
#  ....='cd ../../../' \

# Расширенные стандартные команды
alias \
 grep="grep -i --color=auto" `# (i) - Игнор регистра (a-A и т.д)` \
 egrep='egrep -i --color=auto' \
 fgrep='fgrep -i --color=auto' \
 zgrep='zgrep --color=auto' \
 diff="diff --color=auto" \
 hexedit="hexedit --color" \
 free='free -h' \
 ip="ip -h -c" `# Читабельно +цвета` \
 mv='mv -iv' `# (i) спрашивать (v) подробно` \
 mkdir='mkdir -pv' `# (-p) создаёт родительский каталог (если указан), (-v) Подробно` \
 ln='ln -iv' `# (i) спрашивать, (v) подробно` \
 cp='cp -aiv' `# (a) сохраняет структуру и атрибуты файла при копировании т.е символьные ссылки (i) спрашивать (v) подробно` \
 rm='rm -Iv' `# (I) - спрашивает один раз перед удеалением более 3 файлов (-v) - подробно` \
 rr='rm -rvI' `# Тоже самое но (r) - рекурсивно, только для каталогов` \
 chmod="chmod -v" \
 chown="chown -v" \
 chgrp="chgrp -v" \
 mount='mount -v' \
 umount='umount -v' \
 dmesg='sudo dmesg -e' `# (-e) Выводить читабельный формат временной отметки` \
 gdb='gdb --quiet' \
 bc="bc -ql" `# Калькулятор, без приветствия, юзать математическую библиотеку` \
 cal='cal -3m' `# Календарь на 3 месяца` \
 df="df -TH" `# Device space usage (-T) Тип фс (-H) читабельно` \
 rsync='rsync -vh --progress' `# Подробно, читабельно и показывает прогресс` \
 scp='scp -v' \
 wget='wget -qNc --show-progress --no-check-certificate --hsts-file=~/.cache/wget-hsts' `# (q) - quiet, (N) - включает отметку времени (c) продолжить качать незаконченный файл, только прогресс бар, без проверки сертификата для доступа к скачиванию` \
 ffmpeg="ffmpeg -hide_banner" `# Без баннера об авторских прав` \
 ffprobe="ffprobe -hide_banner" \
 ffplay="ffplay -hide_banner" \
 strace='strace -yy' `# Вывести всю доступную информацию, связанную с файловыми дескрипторами` \
 dosbox="dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox.conf" \
 winetricks='winetricks -q' `# Тихая установка` \
 fdupes='fdupes -rd' \
 journalctl='journalctl --no-hostname -e'
# bat="bat --style=numbers"

# Сокращённые команды
alias \
 v='$EDITOR' \
 pip='pip3' \
 m="ncmpcpp" \
 mvis="ncmpcpp -S visualizer" \
 bt='bluetoothctl' \
 findd="find . -type d -iname" `# Поиск папок (нечувствительный регистр)` \
 findf="find . -type f -iname" `# Поиск файлов (нечувствительный регистр)` \
 iptl='sudo iptables -nvL --line-numbers' \
 nftl='sudo nft list ruleset' \
 nftf='sudo nft flush ruleset' \
 nfts='sudo nft -f /etc/nftables.conf' \
 btrfsfs="sudo btrfs filesystem df /" \
 btrfsls="sudo btrfs su li / -t" \
 snaprls="sudo snapper -c root list" \
 snaphls="sudo snapper -c home list" \
 snapcr="sudo snapper -c root create" \
 snapch="sudo snapper -c home create" \
 gdl="gallery-dl -d $HOME/Pictures/gallery-dl/" \
 gog="lgogdownloader" \
 gogl="lgogdownloader --list" \
 xargs-I="xargs -I {} " \
 apache_bench="ab -n 100" `# Apache HTTP server benchmarking tool` \
 wev='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'''


# Специфичные дополнения стандартных команд
alias \
 cpv="rsync -pogh -e /dev/null -P --" `# cp с прогрессом` \
 dul="du -h -d 1 | sort -hr" `# Статистика размера всего в текущей папке` \
 dus="du -sh" `# Размер файлов и папок (-s) only total (-h) читабельный формат чисел` \
 inet='ip -c -br a' `# Текущие соединения` \
 palss='pactl list short sources' \
 lsblkf='lsblk --output NAME,SIZE,FSTYPE,MOUNTPOINTS,MODEL' \
 lsblks='lsblk --nodeps --output NAME,MODEL,SIZE' \
 imgsum="identify -format '%#\n' $1" \
 lsport='sudo ss -tulpn' `# Открытые порты` \
 lssockets'ss -lx' `# Список сокетов` \
 lsip='lsof -P -i -n' `# Тоже прослушивание портов, вроде` \
 diffgit="diff -Naur --strip-trailing-cr" `# Формат diff такой как в git` \
 killsession="pkill -u $(whoami)" `# Убивает сессию X11 (использовать с root привилегиями)` \
 steam-minimal="steam -no-browser +open steam://open/minigameslist &" `# Только окно библиотеки игр` \
 hdmp="od -Ax -tx1z -v" `# Дамп бинарного файла в формате hexademical` \
 disasm='objdump -d -M att -r -C' `# Отображение дизассемблированных разделов бинарного файла в синтаксисе AT&T` \
 utc='env TZ=UTC date' `# UTC время` \
 p="pushd" +="pushd ." -="popd" d="dirs -l -v" `# Сокращения для работы с активными каталогами`

# Разное
alias \
 sxiv="nsxiv-rifle" \
 lf="lfub"

# CLI мусорка gio
alias \
 trash="gio trash" `# отправить в мусорку` \
 trashempty="gio trash --empty" `# очистить мусорку` \
 trashlist="gio trash --list | column -t -s $'\t' | sort" `# список мусорки` \
 trashrestore="gio trash --list | column -t -s $'\t' | fzf -i -e -m -d / --with-nth 4.. --bind 'home:first,end:last,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all' --prompt='gio trash restore file(s): ' | cut -d ' ' -f1 | while read -r line ; do gio trash --restore "$line" ; done"

# Tmux мультиплексор
alias \
 ta='tmux attach' `# Подключится на текущую сессию` \
 tls='tmux ls' `# Список сессий мультиплексора` \
 tat='tmux attach -t' `# Подключится к определённой сессии, tab для подсказки` \
 tns='tmux new-session -s' `# Создать новую сессию с вашим именем`

# Pacman & AUR помощник

# Использовать в первую очередь если очень долго не обновлялись
# Исправляет неверные или поврежденные пакеы (РGР-подпись)
alias pkeyupd="sudo pacman -Sy archlinux-keyring && sudo pacman -Su"

alias \
 checkupdates="checkupdates; yay -Qua" \
 yayrebuildtree="checkrebuild | cut -f2 | xargs -r yay -S --noconfirm --rebuildtree"

alias \
 y="yay -S --needed" `# установка пакета` \
 yn="yay -S --noconfirm --needed" `# установка пакета без подтверждения` \
 yo="yay -S --overwrite='*'" `# установив пакет, перезаписав существующие файлы (работает и в pacman)` \
 yuo="yay -U --overwrite='*'" \
 yg="yay -G" `# Выгрузить PKGBUILD в текущий каталог` \
 ysc="yay -Sc" `# очистка кэша но оставить локально установленные` \
 yscc="yay -Scc" `# очистить весь кэш` \
 yr="yay -R" `# удаление пакет(а,ов)` \
 yrdd="yay -Rdd" `# деинсталляция пакета без удаления зависимостей (!ОПАСНО!)` \
 yrm="yay -Rns" `# удаление пакет(а,ов) с зависимостями` \
 ynskip='yay --noconfirm --mflags "--nocheck --skipchecksums --skippgpcheck"' \
 yngpg='yay --noconfirm --gpgflags "--keyserver keys.gnupg.net"' \
 mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# Вывести лист всех пакетов из офф репо Arch которые не имеют зависимостей
alias lsnulldeps='expac -S '%n %E%o' | awk '$2==""{print $1}''

# Фиксит ошибку: failed to synchronize all databases (не удалось заблокировать базу данных)
alias punlock='sudo rm /var/lib/pacman/db.lck'

# Показать пакеты у которых отличаются разрешения
alias pacdiffer='grep -A1 "differ" /var/log/pacman.log'

# Список установленных пакетов
# Можно использовать как экспорт
# пример: paclist > список.txt
alias \
 paclist='pacman -Qqen' \
 aurlist='pacman -Qqem' \
 pkglist='pacman -Qqe'


# APT/APTITUDE & DPKG
# -s (simulate) симулировать
# --reinstall переустановить

alias \
 ai="sudo apt install" \
 ain="sudo apt install -y" `# Установить пакет без подтверждения` \
 arm="sudo apt remove" `# Удаление пакетов` \
 armp="sudo apt remove --purge && sudo apt autoremove --purge" `# Удаляет пакет и ненужные зависимости вместе с их конфигурациями` \
 aap="sudo apt autopurge" `# Удалить ненужные пакеты` \
 ac='sudo apt clean && sudo apt autoclean' `# Очищает кэш` \
 au="sudo apt -U upgrade" `# Обновление текущего релиза` \
 adu="sudo apt -U dist-upgrade" `# Upgrade устаревших пакетов` \
 afup="sudo apt upgrade && sudo apt full-upgrade && sudo apt autoremove" `# Обновление до следующего релиза (если доступно), с удалением неиспользуемых пакетов`
#reconfigure="sudo dpkg-reconfigure" \

alias \
 apttw="aptitude why" `# Причины о необходимости этого пакета` \
 apttwn="aptitude why-not" `# Причины почему этот пакет не может быть установлен` \
 aptts='aptitude -F "* %p -> %d (%v/%V)" --no-gui --disable-columns search' `# Лучший поиск пакетов` \
 apttlspkgs="aptitude search '~i!~M'" `# Показать ручные пакеты с подробностями, не для экспорта` \

alias \
 apt-installed="apt list --installed" \
 dpkg-installed="dpkg --get-selections | grep -v deinstall" \
 dpkg-kernels_installed="dpkg --list | grep linux-image"

# Показывает список установленные вручную пакеты
# INFO: Можно использовать как экспорт
alias lpkgs="apt-mark showmanual"

# Отображает файлы пакета
alias afs="apt-file search --regexp"

# Показывает отличающиеся конфиг. файлы от дефолтов
# FIXME: Возникает "zsh: event not found: ~"
alias apt-cfgs='dpkg-query -W -f="\${Conffiles}\n" "*" | awk "OFS=\" \"{print \$2,\$1}" | LANG=C md5sum -c 2> /dev/null | awk -F": " "\$2 !~ /OK\$/{print \$1}" | sort | less'

# Flatpak
alias \
 flatrun="flatpak run" \
 flatlist="flatpak list --columns=application --app" \
 flatpak-remove-unused="flatpak remove --unused"

# ОПАСНО! Удалить все программы установленные из Flatpak со всеми данными
alias flatpak-remove-all="flatpak remove --all --delete-data"

# TODO: Проверить
# gpg encryption
# alias \
#  gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify" `# verify signature for isos` \
#  gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys" `# receive the key of a developer`

# Системное администрирование
alias \
 xlog='grep "(EE)\|(WW)\|error\|failed" ~/.local/share/xorg/Xorg.0.log' `# Для запуска из под tty используя startx` \
 xlogdm='grep "(EE)\|(WW)\|error\|failed" /var/log/Xorg.0.log' `# Для DM` \
 paclog='bat /var/log/pacman.log' `# Лог транзакций pacman` \
 hwis="hwinfo --short" `# Информация о оборудовании` \
 specs='inxi -Fxxxrzc' `# Системная информация` \
 raminfo="sudo dmidecode --type 17" `# Информация о планках памяти` \
 microcode_vuln='grep . /sys/devices/system/cpu/vulnerabilities/*' `# Проверка уязвимостей микрокода` \
 soundinfo='cat /proc/asound/card*/codec* | head -n 9' `# Информация о звуковой карте` \
 soundcardall='cat /proc/asound/cards' `# Все звуковые карты` \
 userlist="cut -d: -f1 /etc/passwd"

# SSH
# Show failed login attempts on Debian
alias sshfailedlogins='grep sshd.\*Failed /var/log/auth.log | less'
# Show failed connect attempts on Debian (like a port scanner, for instance)
alias sshfailedconnects='grep sshd.\*Did /var/log/auth.log | less'

# Xorg
alias \
  xpropC='xprop | grep "WM_CLASS"' \
  startx="startx $XINITRC"

#alias \
#   piper-pt="sed -i 's/en_US-ryan-medium.onnx/pt_BR-faber-medium.onnx/g' ~/.config/speech-dispatcher/modules/piper.conf" \
#   piper-en="sed -i 's/pt_BR-faber-medium.onnx/en_US-ryan-medium.onnx/g' ~/.config/speech-dispatcher/modules/piper.conf"

# Чистка и обслуживание
alias \
 rm-ds-store="find . -name '*.DS_Store' -type f -ls -delete" `# Рекурсивно удалить файлы .DS_Store` \
 pycdel='find . -name \*.pyc -type f -ls -delete' \
 cleanup='sudo paccache -rvk 1 && pacman -Qqdt | sudo pacman -Rns - && yay -Scc --noconfirm' `# Удаляет пакеты сироты вместе с зависимостями` \
 mirror="sudo reflector --verbose -c ru,by -p https,http -l 12 --sort rate --save /etc/pacman.d/mirrorlist" `# Обновление зеркал`

# VFIO (Для 2 GPU со встройкой Intel с дискреткой Nvidia)
# Отсюда: https://youtu.be/6SoteC1FM14?si=y0LRVbftXPGOwkmK&t=1145
alias hows-my-gpu='echo "NVIDIA Dedicated Graphics" | grep "NVIDIA" && lspci -nnk | grep "NVIDIA Corporation GA107M" -A 2 | grep "Kernel driver in use" && echo "Intel Integrated Graphics" | grep "Intel" && lspci -nnk | grep "Intel.*Integrated Graphics Controller" -A 3 | grep "Kernel driver in use" && echo "Enable and disable the dedicated NVIDIA GPU with nvidia-enable and nvidia-disable"'
alias looking-glass='looking-glass-client -m 97'
alias nvidia-enable='sudo virsh nodedev-reattach pci_0000_01_00_0 && echo "GPU переподключён (теперь Host Ready" && sudo rmmod vfio_pci vfio_pci_core vfio_iommu_type1 && echo "VFIO драйвера удалены" && sudo modprobe -i nvidia_modeset nvidia_uvm nvidia && echo "Nvidia драйвера добавлены" && echo "Завершено!"'
alias nvidia-disable='sudo rmmod nvidia_modeset nvidia_uvm nvidia && echo "Nvidia драйвера удалены" && sudo modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1 && echo "VFIO драйвера добавлены" && sudo virsh nodedev-detach pci_0000_01_00_0 && echo "GPU отсоединён (теперь VFIO Ready)" && echo "Завершено!"'

# CPU & GPU & Swap/Zram статистики
alias \
 wcpufrq="watch -n 1 grep \'cpu MHz\' /proc/cpuinfo" \
 wgpu='sudo watch -n 1 cat /sys/kernel/debug/dri/0/amdgpu_pm_info' \
 wzram='watch -n 0.5 zramctl' \
 wdiskw='watch -n1 grep -e Dirty: -e Writeback: /proc/meminfo' \
 wnvsmi='watch -n1 nvidia-smi'
# temp-watch='watch -n 2 sensors' # `Замеры CPU+GPU` \
# alias watchgpu='watch --color gpustat --color' # https://github.com/wookayin/gpustat

# Генерирует коричневый шум, улучшающий концентрацию(?) с помощью sox
# from interesting hn thread https://news.ycombinator.com/item?id=5872414
alias \
 brownnoise='play --show-progress -c 2 --null synth brownnoise reverb bass 6 treble -3 echos 0.8 0.9 1000 0.3 1800 0.25' \
 warpcore='play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25 fade h 1 864000 1' \
 warpcore2='play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20' \
 podracer='play -c2 -n synth whitenoise tremolo 8 70 flanger band -n 100 80 band -n 850 100 gain +20'

# Скачивание сайта
alias \
 webdl_recursive="wget --random-wait -r -p -e robots=off -U mozilla" `# Скачать веб страницу со всеми ассетами, рекурсивно` \
 webdl="wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories" `# Скачать текущую веб страницу со всеми ассетами` \
 websdlwarc="wget --mirror --no-parent --convert-links --warc-file=warc" `# Скачать веб страницу в формате Web ARChive`

# Просмотр HTTP-трафика
alias \
 sniff="sudo ngrep -d 'enp6s0' -t '^(GET|POST) ' 'tcp and port 80'" \
 httpdump="sudo tcpdump -i enp6s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# (Не проверял)
# Укоротить крупный *.exe файл
# Полезно при проверке на вирус
alias cutexe="sed '$ s/\x30*$//' $1"

# Радомный MAC адрес
# Может быть полезным для wifi адаптера (иногда сервер DHCP перестает любить
# вас по странной причине, и это помогает).
# Это можно использовать как free wifi hack (халявный wifi хак)
# Использование: export RANDMAC=$(randmac); echo $RANDMAC && sudo ifconfig en0 ether "{RANDMAC}"
alias randmac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"

# Python
# Памятка: Если системная версия python обновилась на новую мажорную версию
# то вот как обновить venv: Удаляем папку `.venv` и заново выполняем команду venv
alias venv=". ./.venv/bin/activate || python3 -m venv .venv --prompt $(basename $PWD) && . ./.venv/bin/activate"

# Смена версий Python (для сборки) - не нужно
# Проверить версию: python -V
# yay -S python2 или python2-bin
# alias \
#  py2="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python2 $HOME/.local/bin/python && sudo ln -s /usr/bin/python2-config $HOME/.local/bin/python-config" \
#  py3="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python $HOME/.local/bin/python && sudo ln -s /usr/bin/python-config $HOME/.local/bin/python-config"

# Конвертирование документов
# Необходимо указать входной файл
# Usage: 2pdf <doc_file>
alias \
 2pdf="libreoffice --headless --convert-to pdf" \
 2csv='libreoffice --headless --convert-to csv' \
 rtf2text='soffice --headless --convert-to txt:Text' \
 pdf2doc='soffice --infilter="writer_pdf_import" --convert-to doc' \
 pdf2odt='soffice --infilter="writer_pdf_import" --convert-to odt'

# Конвертирование котировок
alias \
 win2utf="iconv -cf CP1251 -t UTF-8" \
 koi2utf="iconv -cf KOI8-R -t UTF-8"

# TODO: Не проверено
# Команда запись на диск (болванку)
alias \
 cdwrite='xorrecord -v speed=16 dev=/dev/sr0 -eject blank=as_needed' \
 cdrecord="/usr/bin/cdrecord -v speed=8 dev=/dev/dvd ${1}" `# Тоже самое?`

# Просмотр CSV данных через CLI
alias viewcsv="cat $1 | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S"

# Docker
# docker-compose build `# (конфликт псевдонима) Пересобирает Docker/Podman образ`
# alias \
#  dcu="docker-compose up -d" `# Запустить как демон` \
#  dcd="docker-compose down" `# Остановить и удалить контейнер` \
#  dcs="docker-compose stop" `# Остановить контейнер` \
#  ds="docker stop $(docker ps -a -q)" `# Останаливает всё` \
#  dcl="docker-compose logs" `# Логи выхлопа контейнера` \
#  dim="docker images" `# Список образов в локальном хранилище` \
#  dps="docker ps" `# Информация о контейнерах` \
#  dpsa="docker ps -a" `# Вся информация о контейнерах` \
#  de='docker exec -it' `# Выполнение команд внутри уже запущенного контейнера` \
#  dr='docker run -d -P --name' `# Создание и запуск нового контейнера как демон` \
#  dsp="docker system prune --all" `# Рекурсивно удалить из окружения Docker все неиспользуемые контейнеры, образы, тома и сети`

# TODO: Проверить
# Run Docker GUI application in container.
# Specify the Docker container name on command line.
# Ensure that 'xhost' has been run prior to enable permissions to X11 display.
# alias d-run="docker run --rm -it --net=host --cpuset-cpus 0 --memory 512mb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY "

# Podman
alias \
 pcu='podman-compose up -d' `# Запустить как демон` \
 pcd='podman-compose down' `# Остановить и удалить контейнер` \
 pcs='podman-compose stop "$(podman ps -q)"' `# Остановить контейнер` \
 pcl='podman-compose logs' `# Логи выхлопа контейнера` \
 pim='podman images' `# Список образов в локальном хранилище` \
 pps='podman ps' `# Информация о контейнерах` \
 ppsa='podman ps -a' `# Вся информация о контейнерах` \
 pe='podman exec -it' `# Выполнение команд внутри уже запущенного контейнера` \
 dr='podman run -d -P --name' `# Создание и запуск нового контейнера как демон` \
 psp='podman system prune --all' `# Рекурсивно удалить из окружения Podman все неиспользуемые контейнеры, образы, тома и сети`

# TODO: Проверить
# Run Podman GUI application in container.
# Specify the Podman container name on command line.
# Ensure that 'xhost' has been run prior to enable permissions to X11 display.
# alias p-run=podman run --rm --it --net=host --security-opt=label=type:container_runtime_t -v /tmp/.X11-unix:/tmp/.X11-unix <имя_образа> <команда_запуска>

# ncdu - анализатор диска
alias \
 hdu="ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules" `# Статистика свободного места ~` \
 rdu='sudo ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules /' `# Статистика свободного места корня`

# Удаляет html теги, очищая раздутую web страницу
# Использование: curl <url> | htmltagremove
alias htmltagremove="sed -e 's/<[^>]*>//g'"

# Pastebins
# Примеры:
# cat log.txt | <np/ix/clb/sprunge/catbox>
# systemctl status [service] | <np/ix/clb/sprunge/catbox>
# journalctl -k -b | <np/ix/clb/sprunge/catbox>
# journalctl -b -u [service] | <np/ix/clb/sprunge/catbox>
# dmesg | <np/ix/clb/sprunge/catbox>
alias \
 np="curl -F 'file=@-' https://0x0.st" \
 ix="curl -F 'f:1=<-' http://ix.io" \
 clb="curl -F 'clbin=<-' https://clbin.com" \
 sprunge="curl -F 'sprunge=<-' http://sprunge.us" \
 catbox="curl -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php"

# Переключатель оболочки bash и zsh
alias \
 tobash="sudo chsh $USER -s /bin/bash && echo 'Теперь перезайдите в сессию'" \
 tozsh="sudo chsh $USER -s /bin/zsh && echo 'Теперь перезайдите в сессию.'"

# curl приколы
alias \
 wtsh="curl -Ss wttr.in/:help?lang=ru" \
 moon="curl -Ss 'wttr.in/Moon?M&lang=ru'" \
 btc="curl -Ss rate.sx" \
 ipv4="curl -Ss -4 ifconfig.co" \
 ipv6="curl -Ss -6 ifconfig.co" \
 speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
# myip="curl -Ssw '\n' ipinfo.io/ip"

# Git
alias \
 gr='git remove' \
 gf='git fetch' \
 gs='git status --short --untracked-files' \
 gd='git diff' \
 gpl='git pull' \
 gp='git push' \
 gls='git ls' \
 gb='git branch' \
 gml='git submodule' \
 gcm='git commit -m' \
 gco='git checkout' \
 gl="git log --graph --date=relative --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset'" \
 git-undo="git reset --soft HEAD^" `# Undo last commit but dont throw away your changes`

# Обновить все репозитории в текущем каталоге
alias bulk_git_pull="exa -d */.git | sed 's/\/.git//'| xargs -P$(nproc) -I{} git -C {} pull"

# Обновления
# zpu="cd '$ZDOTDIR/plugins' && exa -d */.git | sed 's/\/.git//'| xargs -P$(nproc) -I{} git -C {} pull"
alias \
 upfc="sudo fc-cache -vf" `# Обновление шрифтов` \
 zpu="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -P$(nproc) -I {} -0 git -C {} pull" `# Обновление плагинов zsh, иногда необходимо удалить fzf бинарник в папке plugins` \
 upgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg" `# Обновление конфига Grub` \
 updeskdb="update-desktop-database ~/.local/share/applications" `# Обновление пользовательских ярлыков`

# Открывает случайную man страницу — отличный способ изучать новые команды.
alias randman="apropos . | shuf -n 1 | awk '{ print \$1}' | xargs man"

# yt-dlp
# --cookies-from-browser firefox # Если качаешь NSFW контент, или если видео за авторизацией
# --proxy socks5://127.0.0.1:12334/
# --trim-filenames 225: Fix for "name too long" failure
alias \
 yt="yt-dlp -i --embed-metadata --embed-thumbnail --embed-subs --write-sub --sub-lang='(en|ru|ja)' --no-check-certificate --trim-filenames 225 -o '%(title)s.%(ext)s'" \
 yt480="yt -f 'bestvideo[height<=480][fps<=30]+bestaudio/best'" \
 yt720="yt -f 'bestvideo[height<=720][fps<=30]+bestaudio/best'" \
 yt1080="yt -f 'bestvideo[height<=1080][fps<=60]+bestaudio/best'" \
 ytmp4="yt -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'" \
 ytmp3="yt-dlp --embed-thumbnail --embed-metadata -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'" \
 ytmp3pl="yt-dlp --embed-thumbnail --embed-metadata -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(playlist_index)02d - %(title)s.%(ext)s'" \
 ytt="yt --skip-download --write-thumbnail"
