// user-overrides.js: overrides on top of
// https://github.com/HorlogeSkynet/thunderbird-user.js.

// 0102: set START page
user_pref("mailnews.start_page.enabled", false);

// https://github.com/arkenfox/user.js/wiki/3.2-Overrides-%5BCommon%5D#-security
// override recipe: enable Google Safe Browsing binary checks for downloads
// 0403: disable SB checks for downloads (remote)
user_pref("browser.safebrowsing.downloads.remote.enabled", true);

// See the following recipes for temporary changes required for login:
// - https://github.com/HorlogeSkynet/thunderbird-user.js/wiki/3.1-OAuth2-Users
// - https://github.com/HorlogeSkynet/thunderbird-user.js/wiki/3.2-Proton-Mail-Bridge-Users

// Set UI font size to 16.
user_pref("mail.uifontsize", 16);

// Enable smooth scrolling.
user_pref("general.smoothScroll", true);

// Calendar week starts on Monday.
user_pref("calendar.week.start", 1);

// Calendar shows 12h at a time.
user_pref("calendar.view.visiblehours", 12);

// Store emails in `maildir` rather than `mbox` format.
user_pref(
  "mail.serverDefaultStoreContractID",
  "@mozilla.org/msgstore/maildirstore;1",
);
