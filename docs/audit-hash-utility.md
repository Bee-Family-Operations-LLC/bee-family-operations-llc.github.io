# Digital Integrity Utility (audit-hash.ps1)

## Overview
The `audit-hash.ps1` script performs a recursive SHA-256 integrity audit on target directories.

## Usage
Run the following command in PowerShell:
```powershell
./audit-hash.ps1 -Path "C:\Your\Target\Path"
```

## Script Source
```powershell
param([string]$Path = ".")

Write-Host "Initiating recursive hash audit for: $Path" -ForegroundColor Cyan

Get-ChildItem -Path $Path -Recurse -File | ForEach-Object {
    $hash = Get-FileHash -Path $_.FullName -Algorithm SHA256
    [PSCustomObject]@{
        FilePath = $_.FullName
        Hash     = $hash.Hash
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
} | Export-Csv -Path "$Path/manifest.csv" -NoTypeInformation

Write-Host "Audit complete. Manifest generated at $Path/manifest.csv" -ForegroundColor Green
```
