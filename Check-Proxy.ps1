# Fast-Proxy-Checker.ps1
# Requires PowerShell 7+
# Tests HTTP proxies from hosts.txt using curl and exports results to CSV.

$ProxyFile = ".\hosts.txt"
$OutputFile = ".\proxy-results.csv"

$ProxyPort = 3128
$MaxParallel = 5

$ConnectTimeout = 4
$MaxTime = 10
$TestUrl = "https://speed.cloudflare.com/__down?bytes=102400" # 100KB test file

$ProxyUser = $env:PROXY_USER
$ProxyPass = $env:PROXY_PASS

if (-not (Test-Path $ProxyFile)) {
    Write-Error "Proxy file not found: $ProxyFile"
    exit 1
}

if ([string]::IsNullOrWhiteSpace($ProxyUser) -or [string]::IsNullOrWhiteSpace($ProxyPass)) {
    Write-Error "Missing proxy credentials. Set PROXY_USER and PROXY_PASS environment variables first."
    Write-Host "Example:" -ForegroundColor Yellow
    Write-Host '$env:PROXY_USER = "your_username"' -ForegroundColor Yellow
    Write-Host '$env:PROXY_PASS = "your_password"' -ForegroundColor Yellow
    exit 1
}

$Hosts = Get-Content $ProxyFile |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_ -and -not $_.StartsWith("#") }

if ($Hosts.Count -eq 0) {
    Write-Error "No proxy hosts found in $ProxyFile"
    exit 1
}

Write-Host "Starting proxy test..." -ForegroundColor Cyan
Write-Host "Hosts: $($Hosts.Count) | Port: $ProxyPort | Parallel: $MaxParallel" -ForegroundColor Cyan

$Results = $Hosts | ForEach-Object -Parallel {
    $HostName = $_

    $ProxyPort = $using:ProxyPort
    $ProxyUser = $using:ProxyUser
    $ProxyPass = $using:ProxyPass
    $ConnectTimeout = $using:ConnectTimeout
    $MaxTime = $using:MaxTime
    $TestUrl = $using:TestUrl

    $CurlOutput = curl.exe `
        --proxy "http://$HostName`:$ProxyPort" `
        --proxy-user "$ProxyUser`:$ProxyPass" `
        --connect-timeout $ConnectTimeout `
        --max-time $MaxTime `
        --silent `
        --show-error `
        --output NUL `
        --write-out "%{http_code}|%{time_connect}|%{time_total}|%{speed_download}" `
        $TestUrl 2>&1

    $ExitCode = $LASTEXITCODE
    $Parts = ($CurlOutput | Out-String).Trim() -split "\|", 4

    if ($ExitCode -eq 0 -and $Parts.Count -eq 4 -and $Parts[0] -ne "000") {
        [PSCustomObject]@{
            Host          = $HostName
            Port          = $ProxyPort
            Status        = $Parts[0]
            ConnectSec    = [math]::Round([double]$Parts[1], 3)
            TotalSec      = [math]::Round([double]$Parts[2], 3)
            SpeedKBps     = [math]::Round(([double]$Parts[3] / 1024), 2)
            Result        = "Success"
            Error         = ""
        }
    }
    else {
        [PSCustomObject]@{
            Host          = $HostName
            Port          = $ProxyPort
            Status        = if ($Parts.Count -gt 0 -and $Parts[0]) { $Parts[0] } else { "000" }
            ConnectSec    = 999.0
            TotalSec      = 999.0
            SpeedKBps     = 0.0
            Result        = "Failed"
            Error         = ($CurlOutput | Out-String).Trim()
        }
    }
} -ThrottleLimit $MaxParallel

$SortedResults = $Results | Sort-Object `
    @{ Expression = { $_.Result -eq "Success" }; Descending = $true }, `
    @{ Expression = { $_.SpeedKBps }; Descending = $true }, `
    @{ Expression = { $_.TotalSec }; Descending = $false }

$SortedResults | Format-Table -AutoSize
$SortedResults | Export-Csv $OutputFile -NoTypeInformation -Encoding UTF8

Write-Host "Done. Results saved to: $OutputFile" -ForegroundColor Green
