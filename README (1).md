# NetBlocker

מערכת חסימת אתרים מרחוק — ניהול פרופילים דרך GitHub Pages.

## מבנה הריפו

```
/
├── profiles/
│   ├── example.json     ← פרופיל לדוגמה
│   └── moshe.json       ← הוסף פרופיל לכל משתמש
├── scripts/
│   ├── blocker.ps1          ← סקריפט חסימה ראשי
│   ├── startup_updater.ps1  ← רץ בסטארטאפ
│   └── install.bat          ← התקנה חד-פעמית
└── index.html           ← אתר ניהול (GitHub Pages)
```

## הגדרה ראשונית

1. **GitHub Pages** — הפעל ב-Settings → Pages → Branch: main
2. ב-`scripts/blocker.ps1` שנה `YOUR-USERNAME` ו-`YOUR-REPO` לשלך
3. ב-`scripts/install.bat` שנה `PROFILE_NAME` לשם ברירת המחדל

## יצירת פרופיל חדש

1. פתח `index.html` (GitHub Pages URL)
2. מלא שם פרופיל + דומיינים
3. העתק JSON → שמור ב-`profiles/שם.json`

## התקנה אצל המשתמש

הורד את תיקיית `scripts/` ← לחץ ימני על `install.bat` ← הפעל כמנהל

## מה נחסם

- **Hosts File** — כל הדפדפנים ואפליקציות
- **Windows Firewall** — IP ranges של טלגרם וכו'
- **DNS Cache Flush** — ניקוי cache
- **הגנת Hosts** — המשתמש לא יכול לשנות

