# Bee Family Operations LLC - Digital Integrity Utility
# Usage: ./audit-hash.ps1 -Path "C:\Target\Directory"

param([string]$Path = ".")

Write-Host "Initiating recursive hash audit for: $Path" -ForegroundColor Cyan

Get-ChildItem -Path $Path -Recurse -File | ForEach-Object {
    $hash = Get-FileHash -Path $.FullName -Algorithm SHA256
    [PSCustomObject]@{
        FilePath = $_.FullName
        Hash     = $hash.Hash
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
} | Export-Csv -Path "$Path/manifest.csv" -NoTypeInformation

Write-Host "Audit complete. Manifest generated at $Path/manifest.csv" -ForegroundColor Green
