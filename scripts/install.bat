@echo off
:: ============================================================
::  NetBlocker — התקנה ראשונה
::  הפעל כמנהל (לחץ ימני → הפעל כמנהל)
:: ============================================================
chcp 65001 >nul

echo.
echo  ██████████████████████████████████████
echo   NetBlocker - התקנה
echo  ██████████████████████████████████████
echo.

:: בדיקת אדמין
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo שגיאה: יש להריץ כמנהל!
    echo לחץ ימני על הקובץ ובחר "הפעל כמנהל"
    pause & exit /b 1
)

:: יצירת תיקיית התקנה
if not exist "C:\NetBlocker" mkdir "C:\NetBlocker"
echo [✓] תיקייה נוצרה

:: העתקת קבצים
copy /Y "%~dp0setup.hta"       "C:\NetBlocker\setup.hta"       >nul
copy /Y "%~dp0dashboard.hta"   "C:\NetBlocker\dashboard.hta"   >nul
copy /Y "%~dp0blocker.ps1"     "C:\NetBlocker\blocker.ps1"     >nul
copy /Y "%~dp0startup.ps1"     "C:\NetBlocker\startup.ps1"     >nul
copy /Y "%~dp0uninstall.ps1"   "C:\NetBlocker\uninstall.ps1"   >nul
echo [✓] קבצים הועתקו

:: רישום Task Scheduler
schtasks /delete /tn "NetBlocker" /f >nul 2>&1
schtasks /create /tn "NetBlocker" /tr "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\NetBlocker\startup.ps1" /sc onlogon /rl highest /f >nul
echo [✓] סטארטאפ אוטומטי נרשם

echo.
echo [✓] הכנות הושלמו - פותח חלון הגדרה...
echo.

:: פתיחת חלון ההתקנה
start "" "C:\NetBlocker\setup.hta"
