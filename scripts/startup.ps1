# ============================================================
#  NetBlocker Startup — רץ בכל הפעלת מחשב
#  מעדכן רשימה + מפעיל חסימות
# ============================================================

$INSTALL_DIR  = "C:\NetBlocker"
$GITHUB_BASE  = "https://meny0583285502.github.io/LAVAN"
$LOG_FILE     = "$INSTALL_DIR\netblocker.log"

function Log($msg) {
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$ts | $msg" | Add-Content $LOG_FILE
}

Log "=== NetBlocker Startup ==="

# קריאת פרטי משתמש
$userJson = "$INSTALL_DIR\user.json"
$profile  = "default"
if(Test-Path $userJson) {
    try {
        $u = Get-Content $userJson -Raw | ConvertFrom-Json
        $profile = $u.profile
        Log "Profile: $profile | User: $($u.name)"
    } catch { Log "שגיאה בקריאת user.json" }
}

# בדיקת עדכון גרסה
Log "בודק עדכון גרסה..."
try {
    $verUrl  = "$GITHUB_BASE/version.json"
    $verData = Invoke-WebRequest -Uri $verUrl -UseBasicParsing -TimeoutSec 8
    $ver     = $verData.Content | ConvertFrom-Json
    $curVer  = "1.0.0"
    if($ver.version -and $ver.version -ne $curVer) {
        Log "עדכון זמין: $($ver.version)"
        # הורדת הסקריפט המעודכן
        if($ver.script_url) {
            Invoke-WebRequest -Uri $ver.script_url -OutFile "$INSTALL_DIR\blocker_new.ps1" -UseBasicParsing
            Copy-Item "$INSTALL_DIR\blocker_new.ps1" "$INSTALL_DIR\blocker.ps1" -Force
            Log "סקריפט עודכן לגרסה $($ver.version)"
        }
    } else {
        Log "גרסה עדכנית: $curVer"
    }
} catch { Log "בדיקת עדכון נכשלה — ממשיך עם גרסה קיימת" }

# הפעלת חסימה עם הפרופיל
Log "מפעיל חסימות..."
try {
    & "$INSTALL_DIR\blocker.ps1" -ProfileName $profile -GitHubBase "$GITHUB_BASE/profiles"
    Log "חסימות הופעלו בהצלחה"
} catch {
    Log "שגיאה בהפעלת חסימות: $_"
}

Log "=== Startup הושלם ==="
