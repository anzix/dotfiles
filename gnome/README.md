# Всякие полезности о GNOME

## HIDPI для xwayland на GNOME

Это должно исправить размытость приложений x11 при использовании gnome.

```sh
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'xwayland-native-scaling']"
```

Затем откройте «Настройки» > «Дисплеи», чтобы установить масштаб.

