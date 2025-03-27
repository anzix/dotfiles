// --- HW Accel и включение FFMPEG VA-API
// Отрисовка станет максимальной быстрой
// https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("gfx.webrender.all", true);

// Отключает строку заголовка
user_pref("browser.tabs.inTitlebar", 1);

// Отключает функцию View
user_pref("browser.tabs.firefox-view", false);

// Отключает кнопку  списка вкладок
 // user_pref("browser.tabs.tabmanager.enabled", false);

// Отключает проверку браузера по умолчанию
user_pref("browser.shell.checkDefaultBrowser", false);

// Никаких всплывающих (Popup) окон вообще! (Очень полезно)
user_pref("browser.link.open_newwindow.restriction", 0);

// Включает скролл на среднюю кнопку мыши
user_pref("general.autoScroll", true);

// --- Оптимизация
// Уменьшение потребление памяти
user_pref("dom.ipc.processCount", -1); // -1 is equivalent to 'no limit', change accordingly
user_pref("dom.ipc.processCount.webIsolated", 1); // сколько процессов будет выделено для каждого сайта
user_pref("dom.suspend_inactive.enabled", true); // приостановить неактивные вкладки
// Сокращение операций чтения/записи Firefox
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 1048576);
user_pref("browser.sessionstore.interval", 15000000);

// --- STARTUP / HOME
// Отключает приветствие
user_pref("browser.startup.homepage_override.mstone", "ignore");
// Устанавливает стартовую страницу
// 0=пусто, 1=главная, 2=последняя посещенная страница, 3=возобновить предыдущую сесси ю
user_pref("browser.startup.page", 3);
// Домашняя страница и новые окна
user_pref("browser.startup.homepage", "about:blank");
// Новые вкладки
user_pref("browser.newtabpage.enabled", false);
// Отключает спонсируемый контент в Firefox (Ярлыки)
user_pref("browser.newtabpage.activity-stream.showSponsored", false); // Pocket > Sponsored Stories
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // Sponsored shortcuts
// Очищать топ-сайты по умолчанию
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.topsites.contile.enabled", false);
user_pref("browser.topsites.useRemoteSetting", false);
// Всегда отображать панель закладок
user_pref("browser.toolbars.bookmarks.visibility", "always");
// Открывать N-ое кол-во закладок из папки не закрывая список
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
// Отключает рекомендацию расширений
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// --- Отключает WebRTC
   // user_pref("media.peerconnection.enabled", false);

// --- Privacy & Security & Отключение телеметрии
// Enable Firefox Tracking Protection
user_pref("browser.contentblocking.category", "strict");
// Отключает менеджер логинов и паролей
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
// Отключает панель рекомендаций в about:addon (используется Google Analytics)
user_pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
// Отключает сохранённые подсказки для поля логинов (имя пользователя и т.д)
user_pref("browser.formfill.enable", false);
// Отключает рекомендации в панелях расширений и тем about:addons
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
// Отключает персонализированные рекомендации по расширениям в about:addons и AMO
user_pref("browser.discovery.enabled", false);
// Отключает Сбор и использование данных Firefox
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
// Включает Только-HTTPS режим
user_pref("dom.security.https_only_mode", true);
// Disable Location-Aware Browsing (geolocation)
user_pref("geo.enabled", false);
// Отключание отправки новых данных
user_pref("datareporting.policy.dataSubmissionEnabled", false);
// Отключение Телеметрии
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
// disable Telemetry Coverage
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");
// Отключает отправку дополнительной аналитики на веб-серверы
user_pref("beacon.enabled", false);
// disable PingCentre telemetry (used in several System Add-ons)
user_pref("browser.ping-centre.telemetry", false);
// disable Firefox Home (Activity Stream) telemetry
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
// Отключение отправки о вылетах браузера
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);

// --- Разное
// Не отображать строку меню при нажатии Alt
user_pref("ui.key.menuAccessKeyFocuses", false);
// Отключает Mozilla аккаунт & Sync
user_pref("identity.fxaccounts.enabled", false);
// Отключает Pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories",	false);
// Новые запросы на отправку уведомлений
// 0=Спрашивать, 1=Всегда отправлять, 2=Блокировать
user_pref("permissions.default.desktop-notification", 2);

// Автовоспроизведение видео
// 0=Разрешить всё, 1=Блочить незаглушенные медиа (по умолчанию), 5=Блочить всё
user_pref("media.autoplay.default", 5);
// Если некоторые сайты ДЕЙСТВИТЕЛЬНО нуждаются в автовоспроизведении...
// 0=sticky (default), 1=transient, 2=user
user_pref("media.autoplay.blocking_policy", 2);

// Disable Gnome Shell Integration NPAPI plugin
user_pref("plugin.state.libgnome-shell-browser-plugin", 0);

// Установить URL автоматической настройки прокси
// user_pref("network.proxy.autoconfig_url", "https://antizapret.prostovpn.org/proxy.pac");
// Тип прокси
// 0=Прямое соединение, без прокси, 1=Ручная настрока прокси, 2=PAC (Proxy Auto-Configuration),
// 4=Авто обнаружение настроек прокси, 5=Использовать системные настроки прокси (Default)
// user_pref("network.proxy.type", 2);
