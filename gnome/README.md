# Всякие полезности о GNOME

## Полезное

1. HIDPI для xwayland на GNOME

   Это должно исправить размытость приложений x11 при использовании gnome.

   ```sh
   gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'xwayland-native-scaling']"
   ```

Затем откройте «Настройки» > «Дисплеи», чтобы установить масштаб.

2. Лупа (Magnify) в Gnome

   Чтобы включить лупу (magnifier):

   - `Alt + Super + 8` для включения режима лупы
   - `Alt + Super + Равно/Минус` для увеличения/уменьшения

   Чтобы настроить лупу (magnifier) в GNOME:

   Открываем "Настройки" - "Специальные возможности" - кликаем на "Масштабирование"

## Проблемы и способы их решения

1. Исправление отсутствующего курсор в сессии Wayland при Selfhosted хост\
   клиенте Sunshine & Moonlight удалённой машине

   Вводим переменную на хосте (где запускаете sunshine) в `/etc/environment`

   ```sh
   MUTTER_DEBUG_DISABLE_HW_CURSORS=1
   ```

   > Кстати данная настройка может ещё дать работу VRR для мыши что даст низкую\
   > задержку в играх по типу Dota 2

   - [Источник](https://www.reddit.com/r/linux_gaming/comments/1axeib6/make_vrr_work_in_games_with_a_cursor_plasma_6/)
