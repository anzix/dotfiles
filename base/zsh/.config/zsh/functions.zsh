# Не вводи здесь наименование функции с тем же именем что и существующая
# команда системы (напр. journalctl), выведется ошибка при выполнении
# journalctl: maximum nested function level reached; increase FUNCNEST?

# Функция чтобы выполнять содержимое файла
# в текущей оболочке, если они существуют
file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Функция для выполнения sparse clone вытягивания плагинов oh-my-zsh
# https://stackoverflow.com/a/13738951
git_omz_plugins() (
  rurl="$1" tmpdir="$ZDOTDIR/tmp" && shift "$4" # Для предотвращения "shift:1: shift count must be <= $#"

  mkdir -p "$tmpdir"
  cd "$tmpdir"

  git init > /dev/null 2>&1
  git remote add -f origin "$rurl" > /dev/null 2>&1
  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done
  git pull origin master > /dev/null 2>&1

  echo "Удаляю .git"
  rm -rf .git/
  echo "Перемещаю плагин в $ZDOTDIR/plugins/"
  mv plugins/* $ZDOTDIR/plugins/
  echo "Удаляю $tmpdir"
  rm -rf $tmpdir
  echo "Функция git_omz_plugins завершена"
)

# Вытягивает плагин из репо omz
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
omz_plug() {
    PLUGIN_NAME=$(echo $1 )
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        echo "Добавляю плагин $PLUGIN_NAME"
        git_omz_plugins "http://github.com/ohmyzsh/ohmyzsh/" "plugins/$PLUGIN_NAME"
    fi
}

# Вытягивает плагин из репо unixorn
# https://github.com/unixorn/awesome-zsh-plugins#plugins
plug() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# Zsh завершение
# https://github.com/zsh-users/zsh-completions/tree/master/src
zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
		file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}

# Обновление файла zcompdump
zshcompupd() {
 autoload -U zrecompile
 rm -rf "$ZSH_COMPDUMP"* # FIXME: не безопасно использовать rm -rf
 compinit -u -d "$ZSH_COMPDUMP"
 zrecompile -p "$ZSH_COMPDUMP"
 exec zsh
}

# TUI пакетный менеджер [pacman+AUR] (Нужен: fzf)
aurstore() { yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}' | xargs -ro yay -S ;}
pacstore() { pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S ;}
deinst() { yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rn ;}
ppkginfo() { pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)' ;}

# lgogdownloader - GOG обвёртка
# Функции для более удобного синтаксиса argv загрузчика GOG
# Источник: https://github.com/ssokolow/profile/blob/master/home/.common_sh_init/aliases
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

# Короткие консольные заметки
# пример: cheat btrfs
cheat () { curl cheat.sh/$1 | less ;}

# Показывает опциональные пакеты, полезно юзать для wine
# пример: sudo pacman -S --needed $(popts wine-staging)
popts() { expac -S '%o' $1 | tr ' ' '\n' | sed '/^$/d' }

# Установить ssh-соединение + записать лог-файл
logssh() { ssh $1 | tee sshlog ;}

# Сгенерировать пароль
# usage: genpass <число_символов>
genpass() { head -c 32 < /dev/urandom | base64 | tr -dc '[:alnum:]' | head -c ${1:-20} ; echo }

# Подробная информация о смонтированных устройствах
lsmount() { (echo "DEVICE: PATH: TYPE: FLAGS:" && mount | awk '$2=$4="";1') | column -t; }

# Перечисляет все зависимости двоичного файла от ldd -v
# Источник: https://github.com/paulera/files/blob/master/bin/lddlist
lddlist() { ldd -v $1 | grep "=> /" | sed 's/.*=> //g' | sort | uniq | sed 's/ ([0-9a-z]\+)$//g' }

# Systemd
jr() { journalctl -k -e -b "${1:-0}" } # Вся информация
jrwe() { journalctl -p 2..4 -e -b "${1:-0}" } # Все важные логи
fstrimcheck() { journalctl -u fstrim } # Проверка трима для SSD
errors() { journalctl -p 3 -xb -e -b "${1:-0}" }
sysls() { systemctl --all --failed }
sysulist() { systemctl list-unit-files } # --state=enabled
sysuulist() { systemctl --user list-unit-files } # --state=enabled
sysap() { systemd-analyze plot > startup.svg }

# Проверка правописания hunspell
check-word-en () { echo "$1" | hunspell -d en_US ;}
check-word-ru () { echo "$1" | hunspell -d ru_RU ;}
check-list () { hunspell -d en_US,ru_RU -l "$1" ;}
check-file () { hunspell -d en_US,ru_RU "$1" ;}


# Decode/Encode Base64 | Расшифровка/Шифровка строки
# Использование: e64 "строка", d64 "0YHRgtGA0L7QutCwCg=="
e64() { [[ $# == 1 ]] && base64 -w0 <<<"$1" || base64 -w0; echo }
d64() { [[ $# == 1 ]] && base64 --decode <<<"$1" || base64 --decode; echo }

# Конвертирование
# пример: hex2text "68656c6c6f"
hex2text () { printf "$@" | xxd -p -r; echo ;}
hex2text-utf8 () { printf "$@" | xxd -p -r | iconv -f iso-8859-1 -t UTF-8; echo ;}
text2hex () { printf "$@" | xxd -p ;}
hex2bin () {
  hex=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  echo "ibase=16; obase=2; $hex" | bc | awk '{printf "%08s\n", $0}'
}
bin2hex () { printf "%x\n" "$((2#$1))" }
ascii2bin () {
  while read hex; do
    echo "ibase=16; obase=2; $hex" | bc | awk '{printf "%08s", $0}'
  done < <(printf "$@" | xxd -p -c1 -u); echo
}
unidecode () { printf '%b\n' "$@" ;} # Узнать символ по UTF-8, напр \uf115. Можно использовать также `echo '\uf115'`
uniencode () { printf '%x\n' "'$@" ;} # Узнать UTF-8 id символа, напр 

# Конвертирование образов
# Использование: convert2chd [файл]
convert2chd(){ chdman createcd -i "$1" -o "${1%.*}.chd" ;}
chd2cue(){ chdman extractcd -i "$1" -o "${1%.*}.cue" ;}
iso2cso_ciso(){ ciso 9 "$1" "${1%.*}.cso" ;} # PSP: yay -S ciso
iso2cso_maxcso(){ maxcso "$1" "${1%.*}.cso" ;} # PSP/PS2: sudo pacman -S maxcso
iso2rvz(){ dolphin-tool convert --input "$1" --output "${1%.iso}.rvz" --format=rvz --block_size="131072" --compression=zstd --compression_level=5 ;} # GameCube: yay -S dolphin-emu-tool
# [TODO] 3DS Decrypt | cia2cxi (расширение .ncch необходимо переименовать в .3ds):
# 1. Метод: используя команду `wineconsole` и в термнале использовать `decrypt.exe "имя_образа.cia"`
# 2. Метод: используя python скрипт:
# Последнаяя версия базы данных seeddb.bin https://github.com/ihaveamac/3DS-rom-tools/raw/master/seeddb/seeddb.bin
# Скрипт https://github.com/shijimasoft/cia-unix/blob/experimental/decrypt.py
# Команда для дешифровки `python decrypt.py *.cia`
# Проблемы: Нету иконки и обнаружения региона
# [TODO] 3DS Convert | cia2cci (ncsd): yay -S makerom-git
# [TODO] Xbox/Xbox360: yay -S extract-xiso-git
nsz2nsp() { nsz -D "$1" "${1%.*}.nsz" ;} # Switch: sudo pacman -S nsz && необходим prod.keys в ~/.switch


# Конвертирование торрентов
# пример: torrent2magnet {файл} / magnet2torrent {magnet_url}
torrent2magnet() { transmission-show -m "$1" ;}
magnet2torrent() { aria2c -q --bt-metadata-only --bt-save-metadata "$1" ;} # На выходе файла в имени присваивается инфо-хеш V1

# Сжатие PDF файла, необходим пакет ghostscript
pdfcompr() { gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${1}-compressed.pdf ${1}.pdf ;}


# btfs
# пример: mpvbtfs [torrent_file/magnet]
mpvbtfs() {
 # Генерация случайной строки и создание директории
 randstr=$(tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 10)
 dirname="/tmp/btfs/${randstr}"
 mkdir -p "$dirname"
 btfs "$@" "$dirname"
 sleep 5
 # Открытие mpv
 mpv "$dirname"

 # Очистка после закрытия mpv
 [ -d "$dirname" ] && { mountpoint "$dirname" && fusermount -uz "$dirname"; rm -rfv "$dirname"; }
}

# Топ команд
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

# get top process eating memory/cpu
# пример: ram/cpu {кол-во столбцов}
ram () { ps axch -o cmd:15,%mem --sort=-%mem | head -"$1" }
cpu () { ps axch -o cmd:15,%mem --sort=-%mem | head -"$1" }

# Погода cli
# пример: wts {Город}
wts () { curl "wttr.in/$1?M&lang=ru" }
wtss () { curl "wttr.in/$1?format=3" } # Коротко

# Clang
# Генерация моего типа форматирования
gen-clang-format() {
   clang-format \
      --style="{
         BasedOnStyle: Google, \
         IndentWidth: 4, \
         TabWidth: 4, \
         AccessModifierOffset: 0, \
         IndentAccessModifiers: true, \
         PackConstructorInitializers: Never
      }" \
      --dump-config > .clang-format
;}

# Git
# Клонирование
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

# Добавление всех файлов + коммит
gacm () {
  git add --all
  git commit -am "$1"
}

# Создание PNG картинки из визуализированных данных графика (файла .dot)
# Нужен пакет graphviz
dot2png() { dot -Tpng "$1" -O ;}

# Библиотека man'уалов используя fzf
manlist() {
    man $(man -k . | fzf --prompt='Man> ' --preview="man \$(echo {} | awk '{print \$1}')" | awk '{print $1}')
}

# mangrep - поиск в man странице
# пример: mang <manpage> <word>
mangrep() { man $1 | grep --color=auto $2 -C 5 }

# Fuzzy search music library
fmp() {
	local FORMAT="[%file%]"
	mpc listall -f "$FORMAT" | fzf --multi --preview 'mediainfo /media/Media/music/{}' | mpc add
}


# XDG открыть файл под все окружения
open() {
  if [[ -n "${commands[xdg-open]}" ]]; then
    xdg-open "$@"
  elif [[ -n "${commands[kde-open5]}" ]]; then
    kde-open5 "$@"
  elif [[ -n "${commands[gnome-open]}" ]]; then
    # Не работает
    gnome-open "$@"
  else
    echo "не найдена подходящая команда" >&2
    return 1
  fi
}

# Просмотр .crt файл сертификата
# пример: viewcert file.crt
viewcert() {
    local cert=$1

    if [[ -z $1 ]]; then
        echo "No cert file given"
        return
    fi

    openssl x509 -in "$cert" -noout -text
}

# Сгенерировать ssl сертификат
gencert() {
    local server="$1"

    if [[ -z $1 ]]; then
        read -ep "Server name: " server
    fi

    openssl req -nodes -newkey rsa:2048 -sha256 -keyout ${server}-private.key -out ${server}.csr
}

# Конвертировать изображение в иконку favicon для браузера
favicon() {
    convert "$1"  -background white \
            \( -clone 0 -resize 16x16 -extent 16x16 \) \
            \( -clone 0 -resize 32x32 -extent 32x32 \) \
            \( -clone 0 -resize 48x48 -extent 48x48 \) \
            \( -clone 0 -resize 64x64 -extent 64x64 \) \
            -delete 0 -alpha off -colors 256 favicon.ico
}

# Кодировка/декодировка url адресса
# пример: urlencode "Hello, World."
# urldecode Hello%2C%20World.
urlencode() { python3 -c "import sys, urllib.parse as parse; print(parse.quote(sys.argv[1]))" $1; }
urldecode() { python3 -c "import sys, urllib.parse as parse; print(parse.unquote(sys.argv[1]))" $1; }

# Массово удалить все метаданные всех изображениях С перезаписью оригинала и БЕЗ
bulk_jpgclearexif() { for i in *.jpg; do echo "Processing $i"; exiftool -all= "$i"; done ;}
bulk_jpgclearexif_oo() { for i in *.jpg; do echo "Processing $i"; exiftool -overwrite_original -all= "$i"; done ;}

# Массово переименовывает ПРОПИСНЫЕ в строчные (и наоборот) названия всех файлов и каталогов
# Использовать внутри каталога
bulk_uppercase2lowercase() { for f in * ; do mv -v -- "$f" "$(tr [:upper:] [:lower:] <<< "$f")" ; done ;}
bulk_lowercase2uppercase() { for f in * ; do mv -v -- "$f" "$(tr [:lower:] [:upper:] <<< "$f")" ; done ;}

# Сжатие изображения
# пример: imageoptim <file> <options>
imageoptim () {
  if [ -f $1 ] ; then
    case $1 in
      *.jpg)   jpegoptim $1 "${@:2}";;
      *.jpeg)  jpegoptim $1 "${@:2}";;
      *.png)   optipng $1 "${@:2}";;
      *)       echo "'$1' cannot be optimised via imageoptim()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Конвертирование изображений и gif
# Использовать находясь внутри каталога
# TODO: Нужен bulk_heic2jpg но только с использованием пакета heif-enc
bulk_jpg2heif() { for i in *.jpg; do heif-enc -q 100 "$i" -o "${i%.*}.heic"; done ;}
bulk_heic2jpg() { for i in *.HEIC; do heif-convert -q 100 "$i" "${i%.*}.jpg"; done ;} # Нужен AUR пакет python-heif-convert
bulk_all2jxl() { for i in *.png *.jpg *.ppm; do cjxl -e 8 -d 0 "$i" "${i%.*}.jxl"; done ;}
bulk_all2avif() { for i in *.png *.jpg; do avifenc "$i" "${i%.*}.avif"; done ;}
bulk_png2webp() { for i in *.png; do cwebp -q 75 "$i" -o "${i%.*}.webp"; done ;}
bulk_webp2png() { for i in *.webp; do dwebp -quiet "$i" -o "${i%.*}.png"; done ;}
bulk_gif1avif() { for i in *.gif; do ffmpeg -i "$i" -pix_fmt yuv420p -f yuv4mpegpipe - | avifenc --stdin --fps 15 "${i%.*}.avif"; done ;} # Убрать 15 fps если нужна оригинальная скорость

# Конверация видео форматов (полезно для Davinci Resolve)
# [TODO] добавить GNU parallel для более быстрой конвертации
bulk_mkv2mov() { for i in *.mkv; do ffmpeg -i "$i" -c:v copy -c:a pcm_s16le -f mov "${i%.*}.mov"; done ;}
bulk_mp42mov() {
 # использовать MKV как мост
 for i in *.mp4; do ffmpeg -i "$i" -c copy "${i%.*}.mkv"; done
 ; for i in *.mkv; do ffmpeg -i "$i" -c:v copy -c:a pcm_s16le -f mov "${i%.*}.mov"; done; rm *.mkv ;}
bulk_webm2mp4() { for i in *.webm; do ffmpeg -fflags +genpts -i "$i" -r 24 "${i%.*}.mp4"; done ;}

# Извлечение аудио дорожки из видео
# для добавление в Davinci Resolve (из-за недоступности AAC в Linux)
bulk_mp42flac() { for i in *.mp4; do ffmpeg -i "$i" -map 0:a -y "${i%.*}.flac"; done ;}
bulk_mkv2flac() { for i in *.mkv; do ffmpeg -i "$i" -vn -y "${i%.*}.flac"; done ;}

# Массовое конвертирование flac/m4a в mp3
# parallel - можно уменьшить время конвертации в 2 раза
# bulk_flac2mp3 () { find . -name "*.flac" -print0 | parallel -0 ffmpeg -i {} -acodec libmp3lame -ab 320k -map_metadata 0 -id3v2_version 3 "{.}.mp3" }
bulk_flac2mp3() { for i in *.flac; do ffmpeg -i "$i" -acodec libmp3lame -ab 320k "${i%.*}.mp3"; done ;}
bulk_m4a2mp3() { for i in *.m4a; do ffmpeg -i "$i" -codec:v copy -codec:a libmp3lame -q:a 2 "${i%.*}.mp3"; done ;}


# Извлечение кадров из видео
vid2frames() { mkdir "$(pwd)/FrameDir"; ffmpeg -i "$1" "$(pwd)/FrameDir/frame-%03d.jpg" ;}

# Извлечение обложки из аудио
extcover() { ffmpeg -i "$1" -an -vcodec copy cover.jpg ;}

# Download soundcloud music and add metadata.
# If lossless, convert to flac immediately.
# Usage: scdl [links]
scdl() {
    local image file

    for i; do
        case $i in *soundcloud.com/*) ;; *) continue ;; esac
        file=$(\yt-dlp --get-filename "$i") || continue

        [ "${file##*.}" = wav ] && {
            file=${file%.wav}.flac

            \yt-dlp "$i" -o - |
                ffmpeg -loglevel error \
            -i pipe:0 -c:a flac -compression_level 12 "$file"
        }

        \yt-dlp --add-metadata --embed-thumbnail "$i" -o "$file"

        [ -f "$file.jpg" ] && image=$file.jpg
        [ -f "$file.png" ] && image=$file.png
        [ "$image" ] && [ "${file##*.}" = flac ] &&
            metaflac --import-picture-from="$image" "$file" &&
            rm -- "$image"
        :
    done
}

# Обновление уникального hosts файла StevenBlack с обработкой
# 1. Убираю строки localhost (уже есть)
# 2. Убираю все комментарии
# 3. Добавляю отступ следующей строки в начале
uphosts () {
 wget -q --show-progress -t 2 -O- https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
  | grep '^0\.0\.0\.0' \
  | grep -v '^0\.0\.0\.0 [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$' \
  | sed '1s/^/\n/' > /tmp/adlist-all

 # Сравниваем содержимое файлов /etc/hosts и /tmp/adlist-all, игнорируя первые три строки
 diff <(tail -n +4 /etc/hosts) /tmp/adlist-all > diff.txt

 # Заменяем содержимое файла /etc/hosts на объединение изменений из diff.txt
 sudo patch /etc/hosts < diff.txt

 # Корректировка правил универсального hosts файла
 sudo sed -i '/^0.0.0.0 clck.ru\|^0.0.0.0 track.adtraction.com/s/^/#/g' /etc/hosts # Реф ссылки pepper.ru
 sudo sed -i '/^0.0.0.0 js.gleam.io\|^0.0.0.0 js.gleam.io/s/^/#/g' /etc/hosts # Gleam раздачи
 sudo sed -i '/^0.0.0.0 wl.spotify.com\|^0.0.0.0 wl.spotify.com/s/^/#/g' /etc/hosts # Spotify
 sudo sed -i '/^0.0.0.0 www.ojrq.net\|^0.0.0.0 www.ojrq.net/s/^/#/g' /etc/hosts # PCGamingWiki Microsoft game page referal
 sudo sed -i '/^0.0.0.0 track.adtraction.com\|^0.0.0.0 track.adtraction.com/s/^/#/g' /etc/hosts # PCGamingWiki GOG game page referal

 # Удаляем временный файл diff.txt
 rm diff.txt
}

# Power Mode Options
# usage: powermode <options/which/powersave/performance>
powermode () {
  case $1 in
    which)        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor                          ;;
    options)      cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors               ;;
    performance)  echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor  ;;
    powersave)    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor    ;;
    schedutil)    echo schedutil | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor    ;;
    conservative) echo conservative | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ;;
    *)            echo " Invalid Argument: Choose from - which, options, performance, powersave, schedutil "   ;;
  esac
}

# Узнать MIME тип файла
# пример: read_mime {файл}
read_mime() {
  local file="$1"
  xdg-mime query filetype "$file" 2>/dev/null | cut -d ';' -f 1
}


# Ищет текст во всех файлах в текущей папке.
function ftext() {
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    grep -iIHrn --color=always "$1" . | less -r
}

# HEX сравнение 2-х бинарников
# - RED $1
# + GREEN $2
bindiff() {
  test -n "$1" || {
    echo "No input files" >&2
    return 1
  }
  test -n "$2" || {
    echo "No second input file" >&2
    return 1
  }
  diff -u --color=always <(xxd "$1") <(xxd "$2")
}

# Запись экрана смартфона используя adb
# сохраняет во внутреннюю память
android_screen_record() {
    local filename="$(mktemp -u -p "./").mp4"

    echo "Press CTRL+C to stop recording."
    adb shell screenrecord "/sdcard/$filename"
    adb pull "/sdcard/$filename"

    echo "Recording saved as $filename"
}

# Скриншот экрана смартфона
# сохраняет во внутреннюю память
android_screen_capture() {
    local filename="$(mktemp -u -p './').png"

    adb shell screencap -p "/sdcard/$filename"
    adb pull "/sdcard/$filename"

    echo "Capture saved as $filename"
}


# Конвертирует видео фрагмент в гифку
vid2gif() {
    if test $# -lt 4; then
		echo "Usage: $0 input.(mp4|avi|webm|flv|...) output.gif hor_res(1080|720|...) fps_number"
        return 0
    fi

    palette="$(mktemp /tmp/ffmpeg2gifXXXXXX.png)"

    filters="fps=$4,scale=$3:-1:flags=lanczos"

    ffmpeg -v warning -i "$1" -vf "$filters,palettegen" -y "$palette"
    ffmpeg -v warning -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$2"

    rm -f "$palette"
}

# Vbox
# В локальной машине mkdir vboxshare
# в виртуалке uid={имя пользователя} git={группа}
vboxshare () {
  [[ ! -d ~/vboxshare ]] && mkdir -p ~/vboxshare
  sudo mount -t vboxsf -o rw,uid=1000,gid=984 vboxshare vboxshare
}
# Qemu virtio-9p/virtiofs
# virtiofs не требует никаких разрешений в VM
# HOST_PATH (куда ложить файлы): /home/username_host/Public
# GUEST_PATH (mount_tag): host0
# https://www.baeldung.com/linux/qemu-from-terminal#6-sharing-a-directory-between-host-and-guest
virtio-9p_share () {
  [[ ! -d ~/vmshare ]] && mkdir -p ~/vmshare
  sudo mount -v -t 9p -o trans=virtio,version=9p2000.L host0 ~/vmshare
}
virtiofs_share () {
	[[ ! -d ~/vmshare ]] && mkdir -p ~/vmshare
	sudo mount -v -t virtiofs host0 ~/vmshare
}

# http://brettterpstra.com/2013/03/14/more-command-line-handiness/
# https://github.com/rightthumb/rightthumb-widgets-v0/blob/main/widgets/bash/micro_zip_list.sh#L17-L55
# ls archives (inspired by `extract`)
lsa() {
	if [ $# -ne 1 ]
	then
		echo "lsz filename.[tar,tgz,gz,zip,etc]"
		return 1
	fi
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2|*.tar.gz|*.tar|*.tbz2|*.tgz|*tar.zst) tar tvf $1;;
			*.zip|*.rar)  unzip -l $1;;
			*.gz)   echo "Gzip does not support listing contents without extracting.";;
			*.bz2)  echo "Bzip2 does not support listing contents without extracting.";;
			*)      echo "'$1' unrecognized." ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


# Распаковка нескольких архивов с вложенными папками
ex () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Использование: ex <path/file_name1>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz> [<path/file_name2> ...]"
  else
    for file in "$@"; do
      if [ -f "$file" ] ; then
        NAME=${file%.*}
        mkdir "$NAME" && cd "$NAME"
        case "$file" in
          *.tar.bz2)   tar xvjf "../$file"    ;;
          *.tar.gz)    tar xvzf "../$file"    ;;
          *.tar.xz)    tar xvJf "../$file"    ;;
          *.lzma)      unlzma "../$file"      ;;
          *.bz2)       bunzip2 "../$file"     ;;
          *.rar)       unrar x -ad "../$file" ;;
          *.gz)        gunzip "../$file"      ;;
          *.tar)       tar xvf "../$file"     ;;
          *.tbz2)      tar xvjf "../$file"    ;;
          *.tgz)       tar xvzf "../$file"    ;;
          *.zip)       unzip "../$file"       ;;
          *.Z)         uncompress "../$file"  ;;
          *.7z)        7z x "../$file"        ;;
          *.xz)        unxz "../$file"        ;;
          *.exe)       cabextract "../$file"  ;; # Если это sfx архив тогда unrar x sfx.exe
          *)           echo "extract: '$file' - unknown archive method" ;;
        esac
        cd ..
      else
        echo "$file - file does not exist"
      fi
    done
  fi
}


# Упаковка
# Пример: pack [тип архивации] [файл] [файл]
pk () {
    echo "Archiving $1 ..."
    if [ $1 ] ; then
        case $1 in
            tbz)       tar cjvf $2.tar.bz2 $2   ;;
            tgz)       tar czvf $2.tar.gz  $2   ;;
            tar)       tar cpvf $2.tar  $2      ;;
            bz2)       bzip2 $2                 ;;
            gz)        gzip -c -9 -nv $2 > $2.gz;;
            zip)       zip -r $2.zip $2         ;;
            7z)        7z a $2.7z $2            ;;
            *)         echo "'$1' не может быть упакован с помощью pk()" ;;
        esac
    else
        echo "'$1' не является допустимым файлом"
    fi
}
