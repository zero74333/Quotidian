# Quotidian (v2.1)

Simplified living and wellness tracker for Android. Offline, everything stays on the phone in SQLite.
The home screen is an icon grid. Each section opens as its own screen of pages.

## What changed in 2.1

Theme
- Palette taken from the Quotidian logo: navy ink `#2A4C6F`, calm sage and a soft coral for gentle notices.
- Light and dark themes, both built around the navy. Section colours are retuned to sit with it.
- Soft outlined cards, rounded buttons and chips, a branded header and splash.
- Launcher icon generated from the logo (`assets/icon.png`, `assets/icon_fg.png`).
- The logo mark is recoloured by the theme (`assets/logo_mark.png`), so it works in dark mode too.

Stability
- Saves run one at a time, in order, and retry automatically if a write fails.
- The app never switches day while a save is pending or failed, and never saves over a day it could not read.
- Damaged rows are kept as raw text instead of crashing the app.
- Database opens once; startup shows a retry screen instead of a blank screen if it fails.
- The PIN lock now covers every open page, not only the home screen.
- Large phone text sizes no longer overflow the tiles.
- Rows you add but never fill in are removed when you leave the page.
- Dialog and date-picker crashes fixed (controllers, out-of-range dates).
- Restore no longer re-locks the app, and "Restore" asks before replacing data.
- Backup reminder on the dashboard after two weeks, plus Settings > Check my data and Copy error log.

## Project layout

```
.github/workflows/build-apk.yml
assets/                    logo mark, full logo, launcher icons (replace your old icon.png)
pubspec.yaml
lib/
  main.dart                boot, error handling, lock overlay
  theme.dart               brand colours, light/dark themes, section colours
  app_state.dart           settings, master data, the open day, autosave
  database.dart            SQLite (days, master, settings)
  diagnostics.dart         in-memory error log
  auto.dart                calculated fields, streaks, advisories
  metrics.dart             numbers used by Insights
  export_service.dart      Markdown, CSV, JSON backup and restore
  schema/                  the v4 structure as data (edit here to add fields)
  screens/
  widgets/
```
# Quotidian (v2.1)

**Quotidian is a simplified living and wellness tracker for Android**, built completely around an offline-first philosophy where everything stays securely on your phone in an SQLite database. The home screen features an elegant icon grid, with each health and wellness section opening into its own dedicated screen of custom pages.

---

## 🔮 The Vibe Coding Origin Story

This project is a milestone for me: **it was completely built using Vibe Coding**. 

Instead of traditional line-by-line manual programming, this app was brought to life by setting the right intentions, prompts, and architectural vibes, allowing AI to generate the core implementation. It stands as a proof of concept for what a basic, fully functional vibe-coded mobile application can look like. 

### Made by Zeeshan
This is the **first proper repository I have ever made**. A massive amount of heart, experimentation, and layout design went into making sure the application flows smoothly, securely handles user data, and looks beautiful. 

🌟 **If you are reading this, you can thank me or show your support by leaving a Star on this repository!** Being my first true project release, every single star means the world to me.

---

## 🚀 What's New in v2.1

### 🎨 Refined Theme & UI
* **Custom Palette:** Extracted directly from the brand identity, utilizing a striking navy ink (`#2A4C6F`), calm sage, and a soft coral accent for notifications.
* **Dual Theme Support:** Fully optimized light and dark modes built cohesively around the navy ink profile.
* **Modern Design Language:** Features soft outlined cards, rounded interactive buttons/chips, a branded header, and a custom splash screen.
* **Dynamic Assets:** Seamlessly handles launcher icon packaging (`assets/icon.png`) and automatically shifts logo mark colors to preserve dark mode readability.

### 🛡️ Core Stability & Safety
* **Robust Synchronization:** Saves execute sequentially in a single-file line, automatically retrying if a write operation drops.
* **Anti-Corruption Logic:** The app completely blocks day-switching while a save is pending or failed. It will never overwrite data it cannot initially read.
* **Graceful Degradation:** Damaged database rows are safely isolated and presented as raw text instead of throwing fatal app crashes.
* **Boot Management:** The SQLite database opens precisely once upon boot. If a failure occurs, the app serves an interactive retry screen instead of freezing on a blank layout.
* **Total Privacy:** The secure PIN lock mechanism extends globally to overlay every single active sub-page rather than just hiding the home tile array.
* **Layout Safeguards:** Fixed layout constraints prevent high system font sizes from breaking UI tiles, and incomplete rows are automatically auto-purged on exit.

---

## 📦 Project Architecture



