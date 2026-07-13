$Port = 3128
$Username = "SDPTXQADWYgBGM"
$Password = "@BugFreeNet"

# تنظیمات
$ConnectTimeout = 3     # زمان برای برقراری اتصال
$MaxTime = 5           # سقف کل زمان هر تست
$RepeatCount = 1        # هر هاست چند بار تست شود
$TestUrl = "https://speed.cloudflare.com/__down?bytes=716800"

$Hosts = Get-Content ".\hosts.txt" |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_ -and -not $_.StartsWith("#") }

$Results = foreach ($ProxyHost in $Hosts) {
    $ConnectTimes = @()
    $TotalTimes = @()
    $Speeds = @()
    $Fails = 0
    $LastError = ""

    Write-Host "Testing $ProxyHost ..."

    for ($i = 1; $i -le $RepeatCount; $i++) {
        $Output = curl.exe `
            --proxy "http://$ProxyHost`:$Port" `
            --proxy-user "$Username`:$Password" `
            --connect-timeout $ConnectTimeout `
            --max-time $MaxTime `
            --silent `
            --show-error `
            --output NUL `
            --write-out "%{http_code}|%{time_connect}|%{time_total}|%{speed_download}" `
            $TestUrl 2>&1

        if ($LASTEXITCODE -eq 0) {
            $Parts = $Output -split "\|", 4

            if ($Parts.Count -eq 4) {
                $ConnectTimes += [double]$Parts[1]
                $TotalTimes += [double]$Parts[2]
                $Speeds += [double]$Parts[3]
            }
            else {
                $Fails++
                $LastError = "Unexpected curl output"
            }
        }
        else {
            $Fails++
            $LastError = ($Output | Out-String).Trim()
        }

        Start-Sleep -Milliseconds 400
    }

    $Successes = $RepeatCount - $Fails
    $StabilityPct = [math]::Round(($Successes / $RepeatCount) * 100, 0)

    $AvgConnect = if ($ConnectTimes.Count -gt 0) {
        [math]::Round((($ConnectTimes | Measure-Object -Average).Average), 2)
    } else { 999 }

    $AvgTotal = if ($TotalTimes.Count -gt 0) {
        [math]::Round((($TotalTimes | Measure-Object -Average).Average), 2)
    } else { 999 }

    $AvgSpeedKB = if ($Speeds.Count -gt 0) {
        [math]::Round(((($Speeds | Measure-Object -Average).Average) / 1024), 2)
    } else { 0 }

    [PSCustomObject]@{
        Host          = $ProxyHost
        Successes     = $Successes
        Failures      = $Fails
        StabilityPct  = $StabilityPct
        AvgConnectSec = $AvgConnect
        AvgTotalSec   = $AvgTotal
        AvgSpeedKBps  = $AvgSpeedKB
        LastError     = $LastError
    }
}

$Sorted = $Results | Sort-Object `
    @{ Expression = { $_.StabilityPct }; Descending = $true }, `
    @{ Expression = { $_.AvgSpeedKBps }; Descending = $true }, `
    @{ Expression = { $_.AvgTotalSec }; Descending = $false }

$Sorted | Format-Table -AutoSize
$Sorted | Export-Csv ".\proxy-results.csv" -NoTypeInformation -Encoding UTF8
