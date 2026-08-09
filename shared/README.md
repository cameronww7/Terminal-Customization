# 🧬 shared/

This is the single source of truth. Every OS in this repo points its prompt at what's in here. This folder is what actually defines what `TryHard3r` looks like, what color git status shows up in, and which icons appear where.

## What's in here

| Path | What it's for |
|---|---|
| `omp/terminal-customization.omp.json` | The canonical [Oh My Posh](https://ohmyposh.dev/) prompt config. Arrow-style segments (not bubbles), Matrix green throughout. Kali, Mint, and Fedora all reference this exact file through `oh-my-posh init zsh --config ~/.config/oh-my-posh/terminal-customization.omp.json`, as the last line of their `.zshrc` |
| `omp/scripts/vpn_ip.sh` | The VPN IP segment shells out to this. Prints your `tun0` IP if you're connected to a VPN, `No-VPN` if you're not |
| `omp/scripts/wifi_signal.sh` | The network status segment shells out to this. Tries `nmcli` first, falls back to `iw`, and reports `WIRED` if you're on ethernet instead of wifi |
| `omp/scripts/os_icon.sh` | The OS icon segment shells out to this. Reads `/etc/os-release` directly to figure out which distro you're actually on, see below for why |

Two segments worth knowing about that aren't shell scripts, just built into the JSON: a root/sudo indicator that only shows up when you're actually running as root (invisible the rest of the time), and a stash count on the git segment that shows how many stashes you've got sitting in the current repo.

None of the Linux distros read these files live out of the repo while your shell starts up. Each one's setup script (`*_terminal_setup.sh`) copies this JSON and these scripts into `~/.config/oh-my-posh/` when you install or update. So editing the repo copy by itself doesn't do anything until you run `manual_update.sh` in the relevant distro folder.

## Why the OS icon segment shells out to a script

Oh My Posh has a built-in way to show a distro-specific icon, but it turns out to be unreliable under WSL. Here's what's actually going on: under WSL, Oh My Posh figures out your distro from the `$WSL_DISTRO_NAME` environment variable, and only keeps the part before the first hyphen. Fedora's official WSL image sets that variable to something like `FedoraLinux-44`, so Oh My Posh ends up reading `fedoralinux` instead of `fedora`, doesn't recognize it, and quietly falls back to a generic icon.

Rather than trying to guess every possible `$WSL_DISTRO_NAME` variant across every distro and every way someone might have imported their WSL image, `os_icon.sh` just reads `/etc/os-release` directly. That file reports the real distro ID consistently whether you're on WSL, in a VM, or on a real non-virtualized install, so this one mechanism works everywhere instead of needing special cases.

## The Windows exception

PowerShell can't read this Linux-side config live, and the VPN IP and wifi segments depend on Linux-only tools (`ip`, `nmcli`, `iw`) that don't exist on Windows at all. Because of that, [`Windows/terminal-customization.omp.json`](../Windows/terminal-customization.omp.json) is a standalone, hand-maintained copy of this file, not a live reference, with the VPN IP and wifi segments removed entirely. See [`Windows/README.md`](../Windows/README.md) for what it does keep.

If you change `omp/terminal-customization.omp.json`, the Windows copy will quietly drift out of sync. There's no automation watching for that. You have to manually port any relevant change into `Windows/terminal-customization.omp.json` yourself.

## Making a change here

1. Edit `omp/terminal-customization.omp.json` (or the scripts) in this folder.
2. Test it without touching your live config: `oh-my-posh print primary --config shared/omp/terminal-customization.omp.json --shell zsh`
3. Run `./manual_update.sh` in `Kali/`, `Mint/`, and/or `Fedora/` to push the change out to each machine.
4. If the change matters visually, port it into `Windows/terminal-customization.omp.json` too (see the exception above).

For how this fits into the rest of the repo, check the root [`README.md`](../README.md).
