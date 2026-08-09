# Sets up Oh My Posh on native Windows PowerShell - installs the real
# oh-my-posh binary and the FiraCode Nerd Font, then copies this folder's
# prompt config and PowerShell profile into place. Just run it:
#
#   .\Win_terminal_setup.ps1
#
# https://ohmyposh.dev/docs/installation/windows

# The previous `Install-Module oh-my-posh` route only installed
# PowerShell-Gallery cmdlet wrappers, not a PATH-resident oh-my-posh.exe -
# `oh-my-posh init` needs the real binary, so this uses winget instead.
winget install JanDeDobbeleer.OhMyPosh --source winget

# Windows PowerShell 5.1 ships with PSReadLine 2.0.0, which doesn't support
# -PredictionSource (added in 2.1). Upgrade it so history-based prediction in
# $PROFILE actually works instead of silently no-op'ing.
Install-Module PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber -MinimumVersion 2.2.0

# Refresh PATH in this session so the newly-installed binary resolves immediately
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

oh-my-posh font install FiraCode

# Deploy the standalone Oh My Posh config copy (see ../shared/README.md -
# this file is a manually-maintained copy, not a live reference)
$configDir = Join-Path $HOME ".config\oh-my-posh"
New-Item -ItemType Directory -Force -Path $configDir | Out-Null
Copy-Item -Path "$PSScriptRoot\terminal-customization.omp.json" -Destination $configDir -Force

# Deploy the PowerShell profile
New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE) | Out-Null
Copy-Item -Path "$PSScriptRoot\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force

Write-Host "Done. Set your terminal profile's font to 'FiraCode Nerd Font Mono' and open a new PowerShell session."
