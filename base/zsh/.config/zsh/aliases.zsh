### Alias ---------------------------------------------------------

# Весь список alias, функции, пути одим списком
alias \
	alist="alias | sed 's/=.*//'" \
	fncl="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" \
	paths='echo -e ${PATH//:/\\n}'

# Юзать doas вместо sudo (если присутствует)
if hash doas 2>/dev/null; then
    alias sudo='doas'
else
    # Позволяет юзать sudo [alias]
    alias sudo='sudo '
fi

# echo "\e[35;1mнахожусь в:$terminfo[sgr0]\e[36m" `pwd`$terminfo[sgr0]; exa
# exa - ls замена
if hash exa 2>/dev/null; then
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
# GNU `ls`
	alias \
	 ls='ls --color=auto --group-directories-first' \
	 ll='ls -l' `# +Подробно +листом вниз` \
	 la='ls -a' `# +Показ скрытых` \
	 lla='ls -la' `# +Подробно +Показ скрыюзатьвниз` \
	 lt='tree -aC --dirsfirst --gitignore -I ".git|.gitignore|.DS_Store|node_modules"' \
	 lt1='lt -L 1' \
	 lt2='lt -L 2' \
	 lt3='lt -L 3' \
	 l.='ls -d .*' `# Показать только . (dot)`
fi

# Навигация
# alias \
# 	...='cd ../../' \
# 	....='cd ../../../' \

# Подробности и настройки, которые вам почти всегда понадобятся.
alias \
 v='$EDITOR' \
 pip='pip3' \
 m="ncmpcpp" \
 mvis="ncmpcpp -S visualizer" \
 grep="grep -i --color=auto" `# (i) - Игнор регистра (a-A и т.д)` \
 egrep='egrep -i --color=auto' \
 fgrep='fgrep -i --color=auto' \
 zgrep='zgrep --color=auto' \
 diff="diff -Naur --strip-trailing-cr --color=auto" `# формат diff такой как в git` \
 hexedit="hexedit --color" \
 free='free -h' \
 ip="ip -h -c" `# Читабельно +цвета` \
 mv='mv -iv' `# (i) спрашивать (v) подробно` \
 mkdir='mkdir -pv' `# (-p) создаёт родительский каталог (если указан), (-v) Подробно` \
 ln='ln -iv' `# (i) спрашивать, (v) подробно` \
 cp='cp -aiv' `# (a) сохраняет структуру и атрибуты файла при копировании т.е символьные ссылки (i) спрашивать (v) подробно` \
 rm='rm -Iv' `# (I) - спрашивает один раз перед удеалением более 3 файлов (-v) - подробно` \
 rr='rm -rvI' `# Тоже самое но (r) - рекурсивно` \
 chmod="chmod -v" \
 chown="chown -v" \
 mount='mount -v' \
 umount='umount -v' \
 dmesg='sudo dmesg -e' \ `# (-e) Выводить читабельный формат временной отметки` \
 gdb='gdb --quiet' \
 bc="bc -ql" `# Калькулятор, без приветствия, юзать математическую библиотеку` \
 cal='cal -3m' `# Календарь на 3 месяца` \
 dul="du -h -d 1 | sort -hr" `# Статистика размера всего в текущей папке` \
 dus="du -sh" `# Размер файлов и папок (-s) only total (-h) читабельный формат чисел` \
 df="df -TH" `# Device space usage (-T) Тип фс (-H) читабельно` \
 rsync='rsync -vh --progress' `# Подробно, читабельно и показывает прогресс` \
 scp='scp -v' \
 lsblk-full='lsblk --output NAME,SIZE,FSTYPE,MOUNTPOINTS,MODEL' \
 lsblk-short='lsblk --nodeps --output NAME,MODEL,SIZE' \
 wget='wget -qNc --show-progress --no-check-certificate --hsts-file=~/.cache/wget-hsts' `# (q) - quiet, (N) - включает отметку времени (c) продолжить качать незаконченный файл, только прогресс бар, без проверки сертификата для доступа к скачиванию` \
 ffmpeg="ffmpeg -hide_banner" `# Без баннера об авторских прав` \
 ffprobe="ffprobe -hide_banner" \
 ffplay="ffplay -hide_banner" \
 play-song="mpv --no-video --loop --quiet=no" `# Воспроизвести музыку и зациклить` \
 strace='strace -yy' `# Вывести всю доступную информацию, связанную с файловыми дескрипторами` \
 ip-listen='sudo netstat -tulpn' `# Прослушиваемые ip адреса` \
 inet='ip -c -br a' `# Текущие соединения` \
 audio-source='pactl list short sources' \
 findd="find . -type d -iname" `# Поиск папок (нечувствительный регистр)` \
 findf="find . -type f -iname" `# Поиск файлов (нечувствительный регистр)` \
 sxiv="nsxiv-rifle" \
 lf="lfub" \
 bt='bluetoothctl' \
 xpropC='xprop | grep "WM_CLASS"' \
 sx="startx $XINITRC" \
 iptl='sudo iptables -nvL --line-numbers' \
 nftl='sudo nft list ruleset' \
 nftf='sudo nft flush ruleset' \
 nfts='sudo nft -f /etc/nftables.conf' \
 websiteget="wget --random-wait -r -p -e robots=off -U mozilla" `# Скачать веб страницу` \
 dosbox="dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox.conf" \
 winetricks='winetricks -q' `# Тихая установка` \
 protontricks='protontricks -q' \
 bat="bat --style=numbers" \
 obs-gs="OBS_USE_EGL=1 obs" \
 imgsum="identify -format '%#\n' $1" \
 gdl="gallery-dl -d $HOME/Pictures/gallery-dl/" \
 hdmp="od -Ax -tx1z -v" `# Дамп бинарного файла в формате hexademical` \
 disasm='objdump -d -M att -r -C' `# Отображение дизассемблированных разделов бинарного файла в синтаксисе AT&T`

# xargs-I="xargs -I {} "

# Package Manager & AUR helper
alias pkeyupd="sudo pacman -Sy archlinux-keyring && sudo pacman -Su" # Использовать в первую очередь если очень долго не обновлялись
alias checkupdates="checkupdates; yay -Qqu"
alias \
 yay="yay -Pw; yay" `# обновление` \
 y="yay -S --needed" `# установка пакета` \
 yn="yay -S --noconfirm --needed" `# установка пакета без подтверждения` \
 yo="yay -S --overwrite='*'" `# установив пакет, перезаписав существующие файлы` \
 yuo="yay -U --overwrite='*'" \
 yg="yay -G" `# Выгрузить PKGBUILD в pwd` \
 ysc="yay -Sc" `# очистка кэша но оставить локально установленные` \
 yscc="yay -Scc" `# очистить весь кэш` \
 yr="yay -R" `# удаление пакет(а,ов)` \
 yrdd="yay -Rdd" `# деинсталляция пакета без удаления зависимостей (!ОПАСНО!)` \
 yrm="yay -Rns" `# удаление пакет(а,ов) с зависимостями` \
 ynskip='yay --noconfirm --mflags "--nocheck --skipchecksums --skippgpcheck"' \
 yngpg='yay --noconfirm --gpgflags "--keyserver keys.gnupg.net"' \
 mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# Показывает опциональные пакеты, полезно юзать для wine
# пример: sudo pacman -S --needed $(popts wine-staging)
popts() { expac -S '%o' $1 | tr ' ' '\n' | sed '/^$/d' }

# Вывести лист всех пакетов из офф репо Arch которые не имеют зависимостей
alias lsnulldeps='expac -S '%n %E%o' | awk '$2==""{print $1}''

# Фиксит ошибку: failed to synchronize all databases (не удалось заблокировать базу данных)
alias punlock='sudo rm /var/lib/pacman/db.lck'

# Экспорт пакетов
alias \
 paclist='pacman -Qqen > ~/dotfiles/pacman-pkglist.txt' \
 aurlist='pacman -Qqem > ~/dotfiles/AUR-pkglist.txt' \
 pkglist='pacman -Qqe > ~/dotfiles/pkglist.txt'


# Flatpak
alias \
 flat="flatpak run" \
 flatlist="flatpak list --columns=application --app > ~/dotfiles/flatpaks.txt"

# gpg encryption
# alias \
#  gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify" `# verify signature for isos` \
#  gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys" `# receive the key of a developer`

# Скопировать открытый и закрытый ключ SSH в буфер обмена
alias \
 pubkey="more ~/.ssh/id_ed25519.pub | xclip -sel c | echo ' => Public key copied to clipboard.'" \
 prikey="more ~/.ssh/id_ed25519 | xclip -sel c | echo ' => Private key copied to clipboard.'"

# System administration
alias \
 syslog='sudo dmesg --level=err,warn' `# Ошибки и предупреждения ядра` \
 raminfo="sudo dmidecode --type 17" \
 xlog='grep "(EE)\|(WW)\|error\|failed" ~/.local/share/xorg/Xorg.0.log' `# Для startx` \
 xlogdm='grep "(EE)\|(WW)\|error\|failed" /var/log/Xorg.0.log' `# Для DM` \
 paclog='bat /var/log/pacman.log' \
 hw="hwinfo --short" \
 specs='inxi -Fxxxrz' \
 microcode_vuln='grep . /sys/devices/system/cpu/vulnerabilities/*' `# Проверка уязвимостей микрокода` \
 dispinfo='xrandr --prop' `# Full display info` \
 soundinfo='cat /proc/asound/card*/codec* | head -n 9' \
 aoutput='cat /proc/asound/card1/pcm0p/sub0/hw_params' `# Audio Outout info` \
 userlist="cut -d: -f1 /etc/passwd"
# systemd-analyze plot > 1.svg

# systemd
alias \
 sysfail='sudo systemctl --all --failed' \
 jlog='journalctl -p 3 -xb' `# Только текущие сообщения об ошибках` \
 jlogfull='journalctl -b0 -p4' `# Все текущие предупреждения и ошибки` \
 fstrimcheck='journalctl -u fstrim' \
 syslist="systemctl list-unit-files" `# --state=enabled` \
 sysuserlist="systemctl --user list-unit-files"

# btrfs / snapper
alias \
 btrfsfs="sudo btrfs filesystem df /" \
 btrfsls="sudo btrfs su li / -t" \
 snapls="sudo snapper list" \
 snapcr="sudo snapper -c root create"

# Чистка и обслуживание
alias \
 rm-ds-store="find . -name '*.DS_Store' -type f -ls -delete" `# Recursively delete .DS_Store files` \
 pycdel='find . -name \*.pyc -type f -ls -delete' \
 cleanup='sudo paccache -rvk 1 && yay -Qqdt | yay -Rns - && yay -Scc --noconfirm' `# Удаляет пакеты сироты вместе с зависимостями` \
 mirror="sudo reflector --verbose -c ru,by -p https,http -l 12 --sort rate --save /etc/pacman.d/mirrorlist" `# обновление зеркал reflector`

# CPU & GPU & Swap/Zram stats
alias \
 cpufrq="watch -n 1 grep \'cpu MHz\' /proc/cpuinfo" \
 watchgpu='sudo watch -n 1 cat /sys/kernel/debug/dri/0/amdgpu_pm_info' \
 watchzram='watch -n 0.5 zramctl'
# temp-watch='watch -n 2 sensors' # `Замеры CPU+GPU` \
# alias watchgpu='watch --color gpustat --color' # https://github.com/wookayin/gpustat

# Генерирует коричневый шум, улучшающий концентрацию(?) с помощью sox
# from interesting hn thread https://news.ycombinator.com/item?id=5872414
alias \
 brownnoise='play --show-progress -c 2 --null synth brownnoise reverb bass 6 treble -3 echos 0.8 0.9 1000 0.3 1800 0.25' \
 warpcore='play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25 fade h 1 864000 1' \
 warpcore2='play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20' \
 podracer='play -c2 -n synth whitenoise tremolo 8 70 flanger band -n 100 80 band -n 850 100 gain +20'

# Просмотр HTTP-трафика
alias sniff="sudo ngrep -d 'enp6s0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i enp6s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# http://www.catonmat.net/blog/another-ten-one-liners-from-commandlinefu-explained
lsmount() { (echo "DEVICE: PATH: TYPE: FLAGS:" && mount | awk '$2=$4="";1') | column -t; }

# (Не проверял)
# Укоротить крупный *.exe файл
# Полезно при проверке на вирус
alias cutexe="sed '$ s/\x30*$//' $1"

# Убивает сессию X11 (использовать с root привилегиями)
alias killsession="pkill -u $(whoami)"

# Python - смена версий (для сборки)
# Проверить версию: python -V
# yay -S python2 или python2-bin
alias \
 py2="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python2 $HOME/.local/bin/python && sudo ln -s /usr/bin/python2-config $HOME/.local/bin/python-config" \
 py3="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python $HOME/.local/bin/python && sudo ln -s /usr/bin/python-config $HOME/.local/bin/python-config"

# Конвертирование документов
alias \
 2pdf="libreoffice --headless --convert-to pdf" \
 2csv='libreoffice --headless --convert-to csv'

# Конвертирование котировок
alias \
 win2utf="iconv -cf CP1251 -t UTF-8" \
 koi2utf="iconv -cf KOI8-R -t UTF-8"

# Не проверено
# Команда запись на диск (болванку)
alias cdwrite='xorrecord -v speed=16 dev=/dev/sr0 -eject blank=as_needed'
# Тоже самое?
alias cdrecord="/usr/bin/cdrecord -v speed=8 dev=/dev/dvd ${1}"

# Просмотр CSV данных через CLI
alias viewcsv="cat $1 | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S"

# Docker (не юзаю)
# alias dke='docker exec -it'
# alias dkr='docker run -d -P --name'

# Run Docker GUI application in container.
# Specify the Docker container name on command line.
# Ensure that 'xhost' has been run prior to enable permissions to X11 display.
alias d-run="docker run --rm -it --net=host --cpuset-cpus 0 --memory 512mb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY "

# ncdu - анализатор диска
alias \
 hdu="ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules" `# Статистика свободного места ~` \
 rdu='sudo ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules /' `# Статистика свободного места корня`


# lgogdownloader - GOG обвёртка
# Псевдонимы для более удобного синтаксиса argv загрузчика GOG
# Source: https://github.com/ssokolow/profile/blob/master/home/.common_sh_init/aliases
alias \
 gog="lgogdownloader" \
 gogl="lgogdownloader --list"

# Win установщик с бонусами
gogd() { local IFS=| lgogdownloader --retries=7 --download --game "^($*)\$";}
# Win установщик без бонусов
gogu() { local IFS=| lgogdownloader --retries=7 --download --exclude=extras --game "^($*)\$";}
# Linux установщик с бонусами
lgogd() { local IFS=| lgogdownloader --retries=7 --download --platform=linux --game "^($*)\$";}
# Linux установщик без бонусов
lgogu() { local IFS=| lgogdownloader --retries=7 --download --exclude=extras --platform=linux --game "^($*)\$";}


# Перейти в директорию после создания
mkcd () { mkdir -pv $1; cd $1 ;}

# Создаёт .bak (backup) в том же каталоге
backup () { cp "$1"{,.bak};}

# Терминальные советы и рекомендации
# usage: cheat btrfs
cheat () { curl cheat.sh/$1 | less ;}

# Установить ssh-соединение + записать лог-файл
logssh() { ssh $1 | tee sshlog ;}

# Сгенерировать пароль
# usage: genpass <число_символов>
genpass() { head -c 32 < /dev/urandom | base64 | tr -dc '[:alnum:]' | head -c ${1:-20} ; echo }

# Проверка правописания aspell
# Для Русского языка может проверять файлы только с UTF8 кодировкой
check-word() { echo "$1" | aspell -a ;}
check-list() { cat "$1" | aspell list ;}
check-file() { aspell check "$1" ;}

# Проверка правописания hunspell
check-word-en () { echo "$1" | hunspell -d en_US ;}
check-word-ru () { echo "$1" | hunspell -d ru_RU ;}
check-list () { hunspell -d en_US,ru_RU -l "$1" }
check-file () { hunspell -d en_US,ru_RU "$1" ;}

# Конвертирование
# usage: hex2text "68656c6c6f"
hex2text () { printf "$@" | xxd -p -r; echo ;}
hex2text-utf8 () { printf "$@" | xxd -p -r | iconv -f iso-8859-1 -t UTF-8; echo ;}
text2hex () { printf "$@" | xxd -p ;}
# Эти странно работают
hex2bin () {
  hex=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  echo "ibase=16; obase=2; $hex" | bc | awk '{printf "%08s\n", $0}'
}
bin2hex () { echo "ibase=2; obase=16; $1" | bc ;}
ascii2bin () {
  while read hex; do
    echo "ibase=16; obase=2; $hex" | bc | awk '{printf "%08s\n", $0}'
  done < <(printf "$@" | xxd -p -c1 -u)
}

# Конвертирование образов
# Использование: convert2chd [файл]
convert2chd(){ chdman createcd -i "$1" -o "${1%.*}.chd" ;}
chd2cue(){ chdman extractcd -i "$1" -o "${1%.*}.cue" ;}
iso2cso(){ ciso 9 "$1" "${1%.*}.cso" ;} # PSP: yay -S ciso/PS2: yay -S maxcso-git
iso2rvz(){ dolphin-tool convert --input "$1" --output "${1%.iso}.rvz" --format=rvz --block_size="131072" --compression=zstd --compression_level=5 ;} # GameCube: yay -S dolphin-emu
# 3DS: yay -S makerom-git
# Xbox/Xbox360: yay -S extract-xiso-git

# Топ комманд
tophist() {
  cat ${HISTFILE:-$HOME/.zsh_history} \
    | cut -d ';' -f 2- 2>/dev/null \
    | awk '{a[$1]++ } END{for(i in a){print a[i] " " i}}' \
    | sort -rn \
    | head
}


# Генерировать случайную музыку из /dev/urandom
randmusic-minor () {
 cat /dev/urandom \
 | hexdump -v -e '/1 "%u\n"' \
 | awk '{ split("0,2,3,5,7,8,10,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' \
 | xxd -r -p \
 | aplay -c 2 -f S32_LE -r 16000
}

ram () {
 # get top process eating memory
 # usage: ram {кол-во столбцов}
 ps axch -o cmd:15,%mem --sort=-%mem | head -"$1"
}

cpu () {
 # get top process eating cpu
 # usage: cpu {кол-во столбцов}
 ps axch -o cmd:15,%mem --sort=-%mem | head -"$1"
}

### curl приколы

# Погода cli
# usage: wts {Город}
wts () { curl "wttr.in/$1?M&lang=ru" }

# Коротко
wtss () { curl "wttr.in/$1?format=3" }

alias \
 wtsh="curl -Ss wttr.in/:help?lang=ru" \
 moon="curl -Ss 'wttr.in/Moon?M&lang=ru'" \
 btc="curl -Ss rate.sx" \
 ipv4="curl -Ss -4 ifconfig.co" \
 ipv6="curl -Ss -6 ifconfig.co" \
 myip="curl -Ssw '\n' ipinfo.io/ip" \
 speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# Pastebins
# Использование:
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


gc () { git clone "$1" ${2} ;}

# Прыгнуть в каталог после клонирования
gcj () {
  if [[ -n "$2" ]]; then
    git clone "$1" "$2"
    cd "$2"
  else
    git clone "$1"
    local to=$(echo ${1##*/}|sed 's/\..*//')
    cd $to
    # $EDITOR .
  fi
}

gacm () {
  git add --all
  git commit -am "$1"
}

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
 gl='git log --stat --oneline --graph --decorate=short' \
 git-undo="git reset --soft HEAD^" `# Undo last commit but dont throw away your changes`

# Обновить все репозитории в текущем каталоге
alias git-pull-all="exa -d */.git | sed 's/\/.git//'| xargs -P10 -I{} git -C {} pull"

# Shell switch bash and zsh
alias \
 tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'" \
 tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

# yt-dlp
# --trim-filenames 225: Fix for "name too long" failure
alias \
 yt="yt-dlp -i --embed-metadata --embed-thumbnail --embed-subs --write-sub --sub-lang='(en|ru|ja)' --no-check-certificate --trim-filenames 225 -o '%(title)s.%(ext)s'" \
 yt480="yt -f 'bestvideo[height<=480][fps<=30]+bestaudio/best'" \
 yt720="yt -f 'bestvideo[height<=720][fps<=30]+bestaudio/best'" \
 yt1080="yt -f 'bestvideo[height<=1080][fps<=60]+bestaudio/best'" \
 ytmp4="yt -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'" \
 ytmp3="yt-dlp --embed-thumbnail --embed-metadata -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'" \
 ytmp3pl="yt-dlp --embed-thumbnail --embed-metadata -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(playlist_index)02d - %(title)s.%(ext)s'"

# fzf
alias fzf="fzf --cycle --info=hidden --preview='bat --color=always --style=numbers {}'"

# Библиотека man'уалов используя fzf
manlist() {
    man $(man -k . | fzf --prompt='Man> ' --preview="man \$(echo {} | awk '{print \$1}')" | awk '{print $1}')
}

# mang - поиск в man странице
# usage: mang <manpage> <word>
mangrep() { man $1 | grep --color=auto $2 -C 5 }

# Открывает случайную man страницу — отличный способ изучать новые команды.
alias randman="apropos . | shuf -n 1 | awk '{ print \$1}' | xargs man"

# TUI пакетный менеджер [pacman+AUR] (Нужен: fzf)
alias \
 pacstore="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S" \
 aurstore="sudo pacman -F | yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro yay -S"

# zpu="cd '$ZDOTDIR/plugins' && exa -d */.git | sed 's/\/.git//'| xargs -P10 -I{} git -C {} pull"
alias \
 upfc="sudo fc-cache -vf" `# Обновление шрифтов` \
 nvpu="nvim +'PackerUpadate' +qa" `# neovim packer update` \
 zpu="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -P10 -I {} -0 git -C {} pull" `# zsh plugin update` \
 upgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg" `# Grub update config`
