# README.md для feh

## Ставит рандомную обоину

```sh
feh --bg-scale $(shuf -n 1 -e ~/.wallpaper/landscape/*)

# Для двух мониторов нужно второй раз выполнять --bg-scale и shuf
feh --bg-scale $(shuf -n 1 -e ~/.wallpaper/landscape/*) --bg-scale $(shuf -n 1 -e ~/.wallpaper/landscape/*)
```
