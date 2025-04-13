// user-overrides.js: overrides on top of https://github.com/arkenfox/user.js.

// https://github.com/arkenfox/user.js/issues/1080
// override recipe: enable session restore
user_pref("browser.startup.page", 3); // 0102
// user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
// user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128-135
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // 2812 FF136+

// optional to match when you use settings>Cookies and Site Data>Clear Data
// user_pref("privacy.clearSiteData.historyFormDataAndDownloads", false); // 2820 FF128-135
// user_pref("privacy.clearSiteData.browsingHistoryAndDownloads", false); // 2821 FF136+

// optional to match when you use Ctrl-Shift-Del (settings>History>Custom Settings>Clear History)
// user_pref("privacy.clearHistory.historyFormDataAndDownloads", false); // 2830 FF128-135
// user_pref("privacy.clearHistory.browsingHistoryAndDownloads", false); // 2831 FF136+

// https://github.com/arkenfox/user.js/wiki/3.2-Overrides-%5BCommon%5D#-security
// override recipe: enable Google Safe Browsing binary checks for downloads
// 0403: disable SB checks for downloads (remote)
user_pref("browser.safebrowsing.downloads.remote.enabled", true);

// 5003: disable saving passwords
user_pref("signon.rememberSignons", false);

// 7021: enable GPC (Global Privacy Control) in non-PB windows
user_pref("privacy.globalprivacycontrol.enabled", true);
