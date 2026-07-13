# Fast-Proxy-Checker.ps1 (PS 7.x Required)
$ProxyFile = ".\hosts.txt"
$MaxParallel = 10  # تعداد تست همزمان

# تنظیمات را از محیط یا فایل بگیر
$Creds = @{
    User = $env:PROXY_USER     # ست کردن با: $env:PROXY_USER = 'user'
    Pass = $env:PROXY_PASS
    Port = 3128
}

$Hosts = Get-Content $ProxyFile | Where-Object { $_ -and -not $_.StartsWith("#") }

Write-Host "Starting parallel test on $($Hosts.Count) hosts..." -ForegroundColor Cyan

$Results = $Hosts | ForEach-Object -Parallel {
    $HostName = $_
    $Cfg = $using:Creds
    $TestUrl = "https://speed.cloudflare.com/__down?bytes=102400" # 100KB for speed

    $Result = curl.exe `
        --proxy "http://$($HostName):$($Cfg.Port)" `
        --proxy-user "$($Cfg.User):$($Cfg.Pass)" `
        --connect-timeout 3 --max-time 6 -s -o NUL `
        --write-out "%{http_code}|%{time_connect}|%{speed_download}"

    $Status = $Result -split '\|'
    
    [PSCustomObject]@{
        Host      = $HostName
        Status    = $Status[0]
        Connect   = [double]$Status[1]
        SpeedKBps = [math]::Round(([double]$Status[2] / 1024), 2)
    }
} -ThrottleLimit $MaxParallel

$Results | Sort-Object SpeedKBps -Descending | Format-Table -AutoSize
