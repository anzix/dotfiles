# Всякие полезности о KDE Plasma

## Скрытые функции

1. Открытие настроек фоновых процессов для KDE Plasma 6.1

   ```sh
   kcmshell6 kcm_kded
   ```

2. Операции локальных и сетевых файлов KDE в CLI используя kio (kioclient)

   Можно например переместить файл с индикацией KDE, если файл большой

   ```sh
   kioclient move sourefile target
   kioclient copy source target
   ```

   Проверьте `kioclient --commands` для получения дополнительных опций.

3. Показать процессы xwayland

   ```sh
   qdbus org.kde.KWin /KWin org.kde.KWin.showDebugConsole
   ```

4. Отключение менеджера буфера обмена klipper (TODO: Не проверено)

   ```sh
   sed -i 's/"EnabledByDefault": true/"EnabledByDefault": false,/g' /usr/share/plasma/plasmoids/org.kde.plasma.clipboard/metadata.json
   ```

5. Заставьте VRR работать в играх с курсором (TODO: не проверено)

   - [Источник](https://www.reddit.com/r/linux_gaming/comments/1axeib6/make_vrr_work_in_games_with_a_cursor_plasma_6/)

   > Только для Plasma 6 Wayland

   В играх с курсором имеется ввиду такие как Dota 2 и другие

   VRR очень важен для плавного игрового процесса и низкой задержки. Я думаю, многие\
   знают, что он перестает работать в играх с курсором (таких как Dota 2 и многие\
   другие). К счастью, это можно исправить в Plasma 6, нам просто нужно использовать\
   программный курсор

   Добавьте эту строку в `/etc/environment`

   ```sh
   KWIN_FORCE_SW_CURSOR=1
   ```

   Перезагрузитесь, и теперь VRR работает, даже если мы перемещаем курсор

   В настройках плазмы VRR следует установить на Автоматический режим

## Список плазмоидов для KDE (Plasma 6)

- [archupdate](https://github.com/bouteillerAlan/archupdate)
- [arch-update-checker](https://github.com/dhruv8sh/arch-update-checker)
- [Thermal Monitor](https://store.kde.org/p/2100418)

Только Plasma 5

- [Event Calendar](https://store.kde.org/p/998901/)

## Проблемы

1. При установке Plasma 6 был подтянут пакет vlc из-за `phonon-qt6-vlc` потому-что\
   нету пакета `phonon-qt6-gstreamer` в репозитории, причина такова что backend\
   gstreamer не мейнтейниться

2. В konsole, Меню - Вид - активирую галочку 'Монитор завершения работы\
   процесса' после закрыв konsole галочка пропадает. Как сделать так чтобы\
   эта опция была постоянной?

