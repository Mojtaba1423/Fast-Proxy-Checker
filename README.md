# Fast-Proxy-Checker

A high-performance PowerShell script for testing proxy server connectivity and latency. Designed for reliability and speed.

## Features
- Fast connection testing (multi-threaded approach).
- Customizable timeout and retry settings.
- Lightweight, no external dependencies.

## Usage
Simply run the script with your proxy list:
```powershell
.\Check-Proxy.ps1 -ProxyList .\proxies.txt
