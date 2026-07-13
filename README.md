# Fast Proxy Checker

A fast PowerShell-based HTTP proxy checker with parallel testing, authentication support, timeout handling, and CSV export.

## Features

- Tests multiple HTTP proxies in parallel
- Supports username and password authentication
- Measures connection time and download speed
- Handles failed and timed-out proxies
- Sorts successful proxies by performance
- Exports detailed results to CSV
- Ignores empty lines and comments in the hosts file
- Designed for PowerShell 7+

## Requirements

- PowerShell 7 or newer
- curl.exe
- A hosts.txt file containing proxy IP addresses

## Installation

Clone the repository:

git clone https://github.com/USERNAME/Fast-Proxy-Checker.git

Enter the project directory:

cd Fast-Proxy-Checker

## Proxy List

Add one proxy IP address per line to hosts.txt:

104.254.90.218
89.47.234.42
91.198.123.2

Empty lines and lines beginning with # are ignored.

## Authentication

Set your proxy credentials before running the script:

$env:PROXY_USER = "your_username"
$env:PROXY_PASS = "your_password"

These variables remain active only in the current PowerShell session.

## Usage

Run the script:

.\Test-Proxies.ps1

The script tests every proxy listed in hosts.txt.

## Output

Results are displayed in the terminal and saved to:

proxy-results.csv

The output includes:

- Proxy host
- Proxy port
- HTTP status code
- Connection time
- Total request time
- Download speed
- Test result
- Error details

## Configuration

You can change these settings inside the script:

$ProxyPort = 3128
$MaxParallel = 10
$ConnectTimeout = 4
$MaxTime = 10

## Security

Never store real usernames or passwords directly in the script.

Do not commit credentials, result files, or private configuration files to GitHub.

Recommended .gitignore entries:

proxy-results.csv
*.log
.env

## Compatibility

Tested with PowerShell 7 on Windows.

## License

This project is licensed under the MIT (License).
