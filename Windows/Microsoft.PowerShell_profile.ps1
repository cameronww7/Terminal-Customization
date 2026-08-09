Import-Module PSReadLine

# -PredictionSource needs PSReadLine 2.1+; Windows PowerShell 5.1 ships with
# 2.0.0, which doesn't have it. Only set it when the loaded module supports it.
if ((Get-Module PSReadLine).Version -ge [version]'2.1.0') {
    Set-PSReadLineOption -PredictionSource History
}
Set-PSReadLineOption -EditMode Windows

oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\terminal-customization.omp.json" | Invoke-Expression
