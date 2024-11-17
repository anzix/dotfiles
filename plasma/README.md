# Всякие полезности о KDE Plasma

## Открытие настроек фоновых процессов для KDE Plasma 6.1

```sh
kcmshell6 kcm_kded
```

## Операции локальных и сетевых файлов KDE в CLI используя kio (kioclient)

Можно например переместить файл с индикацией KDE, если файл большой

```sh
kioclient move sourefile target
kioclient copy source target
```

Проверьте `kioclient --commands` для получения дополнительных опций.
