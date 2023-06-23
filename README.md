# dotfiles

Репо будет дополнятся дополнительными файлами конфигов.

Установка через GNU Stow
>GNU Stow - это менеджер symlink’ов, с ним можно легко протащить конфиг файлы на основную систему
```
sudo pacman -S stow
```
```
cd ~
git clone --recurse-submodules https://gitlab.com/anzix/dotfiles && cd dotfiles/base
```
* (n) - действия будут эмитироваться
* (v) - действия будут подробными
* (t) - целевая директория
* (/) - файлы по типу README.md будут игнорироваться
* (*) - stow будет вытягивать всё из папки dotfiles в целевую директорию
* (~) - HOME директория

```bash
# Вытащить всё
stow -vt ~ */
```
```bash
# Вытянуть отдельный конфиг
stow -vt ~ alacritty
```
Если вытягиваете zsh рекомендуется дополнительно сделать символьную ссылку, чтобы Display Manager'ы после логина подтягивали переменные от данного файла
```bash
ln -svi /home/$USER/dotfiles/base/zsh/.config/zsh/profile.zsh ~/.profile
```

Установка пакетов из моих 3-х экспортируемых .txt файла
```bash
# Пакеты pacman
sudo pacman -S --needed - < pacman-pkglist.txt

# Пакеты AUR используя yay
yay -S --needed - < AUR-pkglist.txt

# Всё сразу
yay -S --needed - < pkglist.txt
```
