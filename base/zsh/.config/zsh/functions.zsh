# Функция чтобы выполнять содержимое файла
# в текущей оболочке, если они существуют
function file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Функция для выполнения sparse clone вытягивания плагинов oh-my-zsh
# https://stackoverflow.com/a/13738951
function git_omz_plugins() (
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
function omz_plug() {
    PLUGIN_NAME=$(echo $1 )
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else

        if read -q "choice?Установить плагин $PLUGIN_NAME ?: "; then
            echo
            echo "Добавляю плагин $PLUGIN_NAME"
            git_omz_plugins "http://github.com/ohmyzsh/ohmyzsh/" "plugins/$PLUGIN_NAME"
        else
            echo
            echo "Пропускаю..."
        fi
    fi
}

# Вытягивает плагин из репо unixorn
# https://github.com/unixorn/awesome-zsh-plugins#plugins
function plug() {
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
function zsh_add_completion() {
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

killp() {
  local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')
  if [[ "$pid" != "" ]]; then
    echo $pid | xargs sudo kill -${1:-9}
    killp
  fi
}


if [[ -S "/run/user/${UID}/ssh-agent" ]]; then
  export SSH_AUTH_SOCK="/run/user/${UID}/ssh-agent"
fi

open() {
  if [[ -n "${commands[xdg-open]}" ]]; then
    xdg-open "$@"
  elif [[ -n "${commands[kde-open5]}" ]]; then
    kde-open5 "$@"
  elif [[ -n "${commands[gnome-open]}" ]]; then
    gnome-open "$@"
  else
    echo "не найдена подходящая команда" >&2
    return 1
  fi
}

# Просмотр .crt файл сертификата
# usage: viewcert file.crt
viewcert() {
    local cert=$1

    if [[ -z $1 ]]; then
        echo "No cert file given"
        return
    fi

    openssl x509 -in "$cert" -noout -text
}

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
# Usage: urlencode "Hello, World."
# urldecode Hello%2C%20World.
urlencode() { python3 -c "import sys, urllib.parse as parse; print(parse.quote(sys.argv[1]))" $1; }
urldecode() { python3 -c "import sys, urllib.parse as parse; print(parse.unquote(sys.argv[1]))" $1; }

### IMAGE COMPRESSION
# usage: imageoptim <file> <options>
imageoptim ()
{
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

# Конвертирование изображений HEIC на jpg
# Использовать находясь внутри папки
heic-to-jpg() {
	for f in *.HEIC; do heif-convert -q 100 $f $f.jpg; done
}

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

### Power Mode Options
# usage: powermode <options/which/powersave/performance>
powermode ()
{
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

# Генерация паролей
genpasswd () {
    local l=$1
        [ "$l" == "" ] && l=20
        tr -dc A-Za-z0-9_- < /dev/urandom | head -c ${l} | xargs
}

# Сравнение HEX бинарников
# - RED $1
# + GREEN $2
function bindiff {
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
function android_screen_record() {
    local filename="$(mktemp -u -p "./").mp4"

    echo "Press CTRL+C to stop recording."
    adb shell screenrecord "/sdcard/$filename"
    adb pull "/sdcard/$filename"

    echo "Recording saved as $filename"
}

# Скриншот экрана смартфона
# сохраняет во внутреннюю память
function android_screen_capture() {
    local filename="$(mktemp -u -p './').png"

    adb shell screencap -p "/sdcard/$filename"
    adb pull "/sdcard/$filename"

    echo "Capture saved as $filename"
}

# Convert a Chrome cookie to Netscape text format
# Полезно для: $ wget --load-cookies=cookies.txt ...
# usage: chromecookies > cookies.txt
function chromecookies() {
  CHROME="${HOME}/.config/chromium/Default/"
  #echo $CHROME
  COOKIES="$CHROME/Cookies"
  #echo ${COOKIES:-Cookies}

  QUERY="select host_key, 'TRUE', path, 'FALSE', expires_utc, name, value from cookies"

  if [[ $# == 1 ]]; then
      domain=$1
      QUERY="$QUERY where host_key like '$domain'"
  fi

  #echo $QUERY

  # This is to make the exported cookies.txt recognizable by some libraries.
  # e.g. http.cookiejar.MozillaCookieJar will deny it without this string... -_-//.
  # The library does not trust the programmer but searches for this magic string..
  echo "# Netscape HTTP Cookie File"
  sqlite3 -separator '	' "${COOKIES:-Cookies}" "$QUERY"
}

# git.io больше не принимает короткие ссылки
# Создаёт короткий URL-адрес git.io
function gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`";
    return 1;
  fi;
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# Конвертирует видео фрагмент в гифку
vid2gif() {
    if test $# -lt 4; then
        echo "Usage: $0 input.(mp4|avi|webm|flv|...) output.gif horizontal_resolution fps"
        return 0
    fi

    palette="$(mktemp /tmp/ffmpeg2gifXXXXXX.png)"

    filters="fps=$4,scale=$3:-1:flags=lanczos"

    ffmpeg -v warning -i "$1" -vf "$filters,palettegen" -y "$palette"
    ffmpeg -v warning -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$2"

    rm -f "$palette"
}

# share vbox В локальной машине mkdir vboxshare
# в виртуалке uid={имя пользователя} git={группа}
vboxshare () {
  [[ ! -d ~/vboxshare ]] && mkdir -p ~/vboxshare
  sudo mount -t vboxsf -o rw,uid=1000,gid=984 vboxshare vboxshare
}
# share qemu
vmshare () {
  [[ ! -d ~/vmshare ]] && mkdir -p ~/vmshare
  sudo mount -t 9p -o trans=virtio,version=9p2000.L host0 vmshare
}

# http://brettterpstra.com/2013/03/14/more-command-line-handiness/
# ls archives (inspired by `extract`)
lsz() {
	if [ $# -ne 1 ]
	then
		echo "lsz filename.[tar,tgz,gz,zip,etc]"
		return 1
	fi
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2|*.tar.gz|*.tar|*.tbz2|*.tgz) tar tvf $1;;
			*.zip)  unzip -l $1;;
			*)      echo "'$1' unrecognized." ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


# Распаковка
ex () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Использование: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ] ; then
      NAME=${1%.*}
      mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ../$1    ;;
        *.tar.gz)    tar xvzf ../$1    ;;
        *.tar.xz)    tar xvJf ../$1    ;;
        *.lzma)      unlzma ../$1      ;;
        *.bz2)       bunzip2 ../$1     ;;
        *.rar)       unrar x -ad ../$1 ;;
        *.gz)        gunzip ../$1      ;;
        *.tar)       tar xvf ../$1     ;;
        *.tbz2)      tar xvjf ../$1    ;;
        *.tgz)       tar xvzf ../$1    ;;
        *.zip)       unzip ../$1       ;;
        *.Z)         uncompress ../$1  ;;
        *.7z)        7z x ../$1        ;;
        *.xz)        unxz ../$1        ;;
        *.exe)       cabextract ../$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
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

# Install packages using yay
function yin () {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}' | xargs -ro yay -S
}

# Remove installed packages
function yre () {
    # yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns # Удалить с зависимостями
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rn
}
