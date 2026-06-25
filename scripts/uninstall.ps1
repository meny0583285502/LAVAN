# ============================================================
#  NetBlocker Uninstall — מסיר את כל החסימות
# ============================================================

$INSTALL_DIR = "C:\NetBlocker"
$HostsFile   = "$env:SystemRoot\System32\drivers\etc\hosts"

Write-Host "מסיר NetBlocker..." -ForegroundColor Yellow

# שחזור הרשאות Hosts
try {
    $acl = Get-Acl $HostsFile
    $acl.SetAccessRuleProtection($false, $true)
    Set-Acl $HostsFile $acl
} catch {}

# הסרת בלוקים מ-Hosts
$content = Get-Content $HostsFile -Raw
$content = $content -replace "(?s)# \[NetBlocker-.*?\].*?# \[/NetBlocker-.*?\]\r?\n?", ""
$content | Set-Content $HostsFile -Encoding UTF8

# הסרת חוקי Firewall
Get-NetFirewallRule -DisplayName "NetBlocker-*" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

# הסרת Task Scheduler
schtasks /delete /tn "NetBlocker" /f 2>$null

# ניקוי DNS
ipconfig /flushdns | Out-Null

# מחיקת תיקייה
Start-Sleep 1
Remove-Item $INSTALL_DIR -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "NetBlocker הוסר בהצלחה!" -ForegroundColor Green
