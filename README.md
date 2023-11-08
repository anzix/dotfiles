# dotfiles

Репо будет дополнятся дополнительными файлами конфигов.

Установка через GNU Stow

> GNU Stow - это менеджер symlink’ов, с ним можно легко протащить конфиг файлы на основную систему

```sh
sudo pacman -S stow
```

```sh
cd ~
git clone --recurse-submodules https://gitlab.com/anzix/dotfiles && cd dotfiles/base
```

Опции:

- (n) - действия будут эмитироваться
- (v) - действия будут подробными
- (D) - удаляет симлинк
- (t) - целевая директория, на примере указано ~ т.е домашняя директория
- (/) - файлы по типу README.md будут игнорироваться
- (\*) - stow будет вытягивать всё из папки dotfiles в целевую директорию
- Доп. опция (--adopt) - перемещает существующие файлы в папку -d "destination", без этого будут созданы только ссылки

```sh
# Вытащить всё из base
stow -vt ~ */
```

```sh
# Вытянуть отдельный конфиг
stow -vt ~ alacritty
```

```sh
# Удалить симлинк с директории
# Ошибки "BUG in find_stowed_path?"
# просто игнорируйте
stow -Dvt ~ alacritty
```

Если вытягиваете zsh рекомендуется дополнительно сделать символьную ссылку, чтобы Display Manager'ы после логина подтягивали переменные от данного файла

```sh
ln -svi /home/$USER/dotfiles/base/zsh/.config/zsh/profile.zsh ~/.profile
```

Установка пакетов из моих 3-х экспортируемых .txt файла

```sh
# Пакеты pacman
sudo pacman -S --needed - < pacman-pkglist.txt

# Пакеты AUR используя yay
yay -S --needed - < AUR-pkglist.txt

# Всё сразу
yay -S --needed - < pkglist.txt
```

## Настройка оформления GTK к root окружению

```sh
# GTK 2.0
sudo rm -r /usr/share/gtk-2.0/gtkrc
sudo ln -sv ~/.config/gtk-2.0/gtkrc-2.0 /usr/share/gtk-2.0/gtkrc
# GTK 3.0
sudo rm -r /usr/share/gtk-3.0/settings.ini
sudo ln -sv ~/.config/gtk-3.0/settings.ini /usr/share/gtk-3.0/settings.ini
```
