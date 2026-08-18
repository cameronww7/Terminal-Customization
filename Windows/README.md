# 🪟 Windows Terminal-Customization

Same prompt look as the Linux side, just running on native PowerShell. No zsh, no Zinit, no plugin manager. Just [Oh My Posh](https://ohmyposh.dev/) and a `$PROFILE`.

## What you get

| Feature | What it does |
|---|---|
| 🟢 `TryHard3r` | Same nameplate segment as Kali, Mint, and Fedora, neon green, left of every prompt |
| 🧭 OS, user, path, git | Same arrow-style layout and colors as the Linux prompt, including a git stash count when you've got one |
| 🛡️ Root/admin indicator | Only shows up if the shell is actually elevated, invisible the rest of the time |
| 🔋 Battery, clock, exit code | Same as Linux, battery color now shifts from green to yellow to red as it drains |
| ⚡ PSReadLine | History-based prediction and Windows-style keybindings, set up automatically in `$PROFILE` |

Two things you won't find here that the Linux versions have: the VPN IP and wifi signal segments. Those shell out to `ip`, `nmcli`, and `iw`, none of which exist on Windows, and the lab-VPN workflow they're built for isn't really a Windows thing anyway. Check [`../shared/README.md`](../shared/README.md) if you want the full explanation for why this file is a standalone copy instead of pointing at the Linux config directly.

## Before you start

- Windows with [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) available (this comes built in on modern Windows 10/11)
- PowerShell 5.1 or newer (Windows PowerShell or PowerShell 7/pwsh both work)

## Installing it

Open PowerShell in this folder and run:

```powershell
.\Win_terminal_setup.ps1
```

That will:
1. Install Oh My Posh through `winget`. This is the real binary, not the old deprecated `Install-Module oh-my-posh` route, which never actually puts a working `oh-my-posh.exe` on your `PATH`
2. Install FiraCode Nerd Font Mono
3. Set VS Code's integrated terminal font to FiraCode Nerd Font Mono too, if VS Code is installed (see the note below - this is a separate setting from Windows Terminal's font)
4. Copy `terminal-customization.omp.json` into `~/.config/oh-my-posh/`
5. Copy `Microsoft.PowerShell_profile.ps1` to your `$PROFILE`

Then:
1. Set your terminal's font to **FiraCode Nerd Font Mono** (in Windows Terminal that's Settings, then your profile, then Appearance, then Font face)
2. Open a new PowerShell window

**About that VS Code step:** Windows Terminal and VS Code's integrated terminal each have their own, completely independent font setting. Installing the Nerd Font doesn't make either of them use it automatically, and setting it in one doesn't touch the other. The script sets `"terminal.integrated.fontFamily": "FiraCode Nerd Font Mono"` in your VS Code `settings.json` automatically (merging into whatever's already there, not overwriting it) if it finds a VS Code user profile on this machine at setup time. If you install VS Code *after* running this script, or it wasn't detected, just set that same key by hand: `Ctrl+,`, search "terminal font", or edit `settings.json` directly.

## If something's not working

- **Prompt shows boxes instead of icons.** Your terminal profile isn't set to FiraCode Nerd Font Mono yet. Installing the font isn't the same as selecting it, you still have to pick it in your terminal settings.
- **Boxes in VS Code's integrated terminal specifically, even though Windows Terminal looks fine.** VS Code has its own separate font setting from Windows Terminal - see the note in "Installing it" above. Either re-run the setup script now that VS Code is installed, or set `"terminal.integrated.fontFamily": "FiraCode Nerd Font Mono"` in VS Code's `settings.json` yourself.
- **`oh-my-posh: command not found` right after installing.** Your current session's `PATH` hasn't picked up the new install yet. Open a new PowerShell window. The script tries to refresh `PATH` in place, but a fresh window is the reliable fix.
- **`winget` not found.** You're probably on an older Windows build without App Installer. Grab it from the Microsoft Store, then run the script again.
- **Script won't run, says "running scripts is disabled on this system".** Your PowerShell execution policy is blocking local scripts. This repo doesn't touch your execution policy at all, so that's a call you have to make yourself. If you want to allow it: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.
- **Prompt looks different from the Linux screenshots.** That's expected. No VPN IP or wifi segments here, see "What you get" above.

## Updating

Just run `.\Win_terminal_setup.ps1` again whenever you want. It overwrites the deployed config and profile with whatever's currently in this folder.

One catch worth knowing: if the Linux side's shared config (`../shared/omp/terminal-customization.omp.json`) changes, this folder's copy doesn't update automatically. Someone has to manually port the relevant changes into `Windows/terminal-customization.omp.json`. See [`../shared/README.md`](../shared/README.md) for more on that.

For how this fits into the rest of the repo, check the root [`README.md`](../README.md).
