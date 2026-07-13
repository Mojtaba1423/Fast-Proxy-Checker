# Fast-Proxy-Checker

A high-performance PowerShell 7+ script for testing proxy server connectivity and latency. Designed for reliability, speed, and automation workflows.

## Features
- **Parallel Processing**: Uses `ForEach-Object -Parallel` for lightning-fast testing.
- **Detailed Metrics**: Reports status, latency (ms), and server headers.
- **Secure**: Supports environment variables for sensitive credentials.
- **Lightweight**: No external dependencies; built on `.NET HttpClient`.

## Usage
1. Prepare your `hosts.txt` file.
2. Run the script:
```powershell
.\Check-Proxy.ps1
