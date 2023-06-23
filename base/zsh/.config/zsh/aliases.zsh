### Alias ---------------------------------------------------------

# Весь список alias, функции, пути одим списком
alias \
	alis="alias | sed 's/=.*//'" \
	fnc="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" \
	paths='echo -e ${PATH//:/\\n}'


if hash doas 2>/dev/null; then
    # Юзать doas вместо sudo
    alias sudo='doas'
else
    # Позволяет юзать sudo [alias]
    alias sudo='sudo '
fi

# echo "\e[35;1mнахожусь в:$terminfo[sgr0]\e[36m" `pwd`$terminfo[sgr0]; exa
# exa
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
	 lla='ls -la' `# +Подробно +Показ скрытых +листом вниз` \
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
 diff="diff -Naur --strip-trailing-cr --color=auto" `# формат diff, такой как в git` \
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
 xM='xrdb -merge ~/.config/X11/Xresources' `# Мгновенное применение файла .Xresources` \
 xL='xrdb -load ~/.config/X11/Xresources' \
 xpropC='xprop | grep "WM_CLASS"' \
 sx="startx $XINITRC" \
 sz="source $ZDOTDIR/.zshrc" \
 iptl='sudo iptables -nvL --line-numbers' \
 nftl='sudo nft list ruleset' \
 nftf='sudo nft flush ruleset' \
 nfts='sudo nft -f /etc/nftables.conf' \
 websiteget="wget --random-wait -r -p -e robots=off -U mozilla" `# Скачать веб страницу` \
 dosbox="dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox.conf" \
 winetricks='winetricks -q' `# Тихая установка` \
 bat="bat --style=numbers" \
 obs-gs="OBS_USE_EGL=1 obs"

# xargs-I="xargs -I {} "
# sudo="sudo -v ; sudo "
# obs-amf="VK_ICD_FILENAMES=/opt/amdgpu-pro/etc/vulkan/icd.d/amd_icd64.json:/opt/amdgpu-pro/etc/vulkan/icd.d/amd_icd32.json OBS_USE_EGL=1 obs"

# http://www.catonmat.net/blog/another-ten-one-liners-from-commandlinefu-explained
lsmount() { (echo "DEVICE: PATH: TYPE: FLAGS:" && mount | awk '$2=$4="";1') | column -t; }

# (Не проверял)
# Укоротить крупный *.exe файл
# Полезно при проверке на вирус
alias cutexe="sed '$ s/\x30*$//' $1"

# Python - смена версий (для сборки)
# Проверить версию: python -V
# yay -S python2 или python2-bin
alias \
 py2="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python2 $HOME/.local/bin/python && sudo ln -s /usr/bin/python2-config $HOME/.local/bin/python-config" \
 py3="rm $HOME/.local/bin/python*; sudo ln -s /usr/bin/python $HOME/.local/bin/python && sudo ln -s /usr/bin/python-config $HOME/.local/bin/python-config"

# Конвертирование документов
alias \
 doc2pdf="libreoffice --headless --convert-to pdf *.doc" `# convert all Word doc files to pdf` \
 docx2pdf="libreoffice --headless --convert-to pdf *.docx" `# convert all Word docs to pdf` \
 odt2pdf="libreoffice --headless --convert-to pdf *.odt" `# convert all .odt docs to pdf` \
 ppt2pdf="libreoffice --headless --convert-to pdf *.pptx" `# convert all .odt docs to pdf`

# Docker (не юзаю)
# alias dke='docker exec -it'
# alias dkr='docker run -d -P --name'

# Генерировать случайную музыку из /dev/urandom
randmusic-minor () {
 cat /dev/urandom \
 | hexdump -v -e '/1 "%u\n"' \
 | awk '{ split("0,2,3,5,7,8,10,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' \
 | xxd -r -p \
 | aplay -c 2 -f S32_LE -r 16000
}

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


# Быстрый шорткат для открытия файлового менеджера в текущем каталоге,
# не загромождая терминал сообщениями из него.
alias here="pcmanfm . &>/dev/null &"

# ncdu - анализатор диска
alias \
 hdu="ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules" `# Статистика свободного места ~` \
 root-du='sudo ncdu --color dark --show-percent --hide-graph -rr -x --exclude .git --exclude node_modules /' `# Статистика свободного места корня`


# Топ комманд
tophist() {
  cat ~/.cache/.zsh_history \
    | cut -d ';' -f 2- 2>/dev/null \
    | awk '{a[$1]++ } END{for(i in a){print a[i] " " i}}' \
    | sort -rn \
    | head
}

# Перейти в директорию после создания
mkcd() { mkdir -pv $1; cd $1 ;}

# Создаёт .bak (backup) в том же каталоге
backup() { cp "$1"{,.bak};}

# Терминальные советы и рекомендации
# usage: cheat btrfs
cheat() { curl cheat.sh/$1 | less; }

# Конвертирование образов
# Использование: convert2chd [файл]
convert2chd(){ chdman createcd -i "$1" -o "${1%.*}.chd" ;}
chd2cue(){ chdman extractcd -i "$1" -o "${1%.*}.cue" ;}
iso2cso(){ ciso 9 "$1" "${1%.*}.cso" ;} # PSP: yay -S ciso
# 3DS: yay -S makerom-git
# Xbox/Xbox360: yay -S extract-xiso-git

# Генерирует коричневый шум, улучшающий концентрацию(?) с помощью sox
# from interesting hn thread https://news.ycombinator.com/item?id=5872414
alias \
  brownnoise='play --show-progress -c 2 --null synth brownnoise reverb bass 6 treble -3 echos 0.8 0.9 1000 0.3 1800 0.25' \
  warpcore='play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25 fade h 1 864000 1' \
  warpcore2='play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20' \
  podracer='play -c2 -n synth whitenoise tremolo 8 70 flanger band -n 100 80 band -n 850 100 gain +20'

# Package Manager & AUR helper
# yay - для обновления
alias pkeyupd="sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu" # Использовать в первую очередь если очень долго не обновлялись
alias \
 y="yay -S --needed" `# установка пакета` \
 yn="yay -S --noconfirm --needed" `# установка пакета без подтверждения` \
 yo="yay -S --overwrite='*'" `# установив пакет, перезаписав существующие файлы` \
 yuo="yay -U --overwrite='*'" \
 ysc="yay -Sc" `# очистка кэша но оставить локально установленные` \
 yscc="yay -Scc" `# очистить весь кэш` \
 yr="yay -R" `# удаление пакет(а,ов)` \
 yrm="yay -Rns" `# удаление пакет(а,ов) с зависимостями` \
 ynskip='yay --noconfirm --mflags "--nocheck --skipchecksums --skippgpcheck"' \
 yngpg='yay --noconfirm --gpgflags "--keyserver keys.gnupg.net"' \
 mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# Чистка и обслуживание
alias \
 rm-ds-store="find . -name '*.DS_Store' -type f -ls -delete" `# Recursively delete .DS_Store files` \
 pycdel='find . -name \*.pyc -type f -ls -delete' \
 cleanup='sudo paccache -rvk 1 && yay -Qqdt | yay -Rns - && yay -Scc --noconfirm' `# Удаляет пакеты сироты вместе с зависимостями` \
 mirror="sudo reflector --verbose -c ru,by -p https,http -l 12 --sort rate --save /etc/pacman.d/mirrorlist" `# обновление зеркал reflector`


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

# gpg encryption (не юзаю)
# alias \
#  gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify" `# verify signature for isos` \
#  gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys" `# receive the key of a developer`

# Проверка правописания aspell
# Туториал видео: http://www.youtube.com/watch?v=UEwz5eeaZzc
# Для Русского языка может проверять файлы только с UTF8 кодировкой
check-word() { echo "$1" | aspell -a ;}
check-list() { cat "$1" | aspell list ;}
check-file() { aspell check "$1" ;}

# System administration
alias \
 syslog='sudo dmesg --level=err,warn' `# Ошибки и предупреждения` \
 sysfail='sudo systemctl --all --failed' \
 jlog='journalctl -p 3 -xb' `# Только текущие сообщения об ошибках` \
 jlogfull='journalctl -b0 -p4' `# Все текущие предупреждения и ошибки` \
 fstrimcheck='journalctl -u fstrim' \
 syslist="systemctl list-unit-files" `# --state=enabled` \
 sysuserlist="systemctl --user list-unit-files" \
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

# CPU & GPU & Swap/Zram stats
alias \
 cpufrq="watch -n 1 grep \'cpu MHz\' /proc/cpuinfo" \
 watchgpu='sudo watch -n 1 cat /sys/kernel/debug/dri/0/amdgpu_pm_info' \
 watchzram='watch -n 0.5 zramctl'
# temp-watch='watch -n 2 sensors' # `Замеры CPU+GPU` \
# alias watchgpu='watch --color gpustat --color' # https://github.com/wookayin/gpustat

### curl приколы

# Погода cli
# usage: wts {Город}
wts () {
  curl "wttr.in/$1?M&lang=ru"
}

# Коротко
wtss () {
  curl "wttr.in/$1?format=3"
}

alias \
 wtsh="curl -Ss wttr.in/:help?lang=ru" \
 moon="curl -Ss 'wttr.in/Moon?M&lang=ru'" \
 btc="curl -Ss rate.sx" \
 ipv4="curl -Ss -4 ifconfig.co" \
 ipv6="curl -Ss -6 ifconfig.co" \
 myip="curl -Ssw '\n' ipinfo.io/ip" \
 speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# Pastebins
# Использование: cat log.txt | np
alias \
 np="curl -F 'file=@-' https://0x0.st" \
 ix="curl -F 'f:1=<-' http://ix.io" \
 sprunge="curl -F 'sprunge=<-' http://sprunge.us"

# git
gc () {
  git clone "$1" ${2}
}

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

gac () {
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
 gl='git log --stat --oneline --graph --decorate=short'


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

# Библиотека man'уалов в fzf
fman() {
    man $(man -k . | fzf --prompt='Man> ' --preview="man \$(echo {} | awk '{print \$1}')" | awk '{print $1}')
}

# TUI пакетный менеджер [pacman+AUR] (Нужен: fzf)
alias \
 pacstore="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S" \
 aurstore="sudo pacman -F | yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro yay -S"

# Обновить все репозитории в текущем каталоге
# alias git-pull-all="exa -d */.git | sed 's/\/.git//'| xargs -P10 -I{} git -C {} pull"
alias \
 upfc="sudo fc-cache -vf" `# Обновление шрифтов` \
 nvpu="nvim +'PlugInstall --sync' +qa" `# vim-plug update` \
 zpu="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull" `# zsh plugin update` \
 # zpu="cd '$ZDOTDIR/plugins' && exa -d */.git | sed 's/\/.git//'| xargs -P10 -I{} git -C {} pull" `# Работает быстрее` \
 upgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg" `# Grub update config`

# Checking dunst
alias dun='killall dunst &&
notify-send "cool" "yeah it is working"'
