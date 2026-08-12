# 🧬 shared/

This is the single source of truth. Every Unix OS in this repo points its prompt at what's in here. This folder is what actually defines what `TryHard3r` looks like, what color git status shows up in, and which icons appear where.

## What's in here

| Path | What it's for |
|---|---|
| `omp/terminal-customization.omp.json` | The canonical [Oh My Posh](https://ohmyposh.dev/) prompt config. Arrow-style segments (not bubbles), Matrix green throughout. Kali, Mint, Fedora, and macOS all reference this exact file through `oh-my-posh init zsh --config ~/.config/oh-my-posh/terminal-customization.omp.json`, as the last line of their `.zshrc` |
| `omp/scripts/vpn_ip.sh` | The VPN IP segment shells out to this. On Linux, prints your `tun0` IP if you're connected to a VPN. On macOS, prints the connected VPN profile's name (via `scutil --nc`) or a tunnel IP for third-party VPN apps (via `utun` interfaces). Prints nothing on either platform when there's no VPN up, which is what actually makes the segment auto-hide |
| `omp/scripts/wifi_signal.sh` | The network status segment shells out to this. On Linux, tries `nmcli` first, falls back to `iw`. On macOS, reports the connected Wi-Fi SSID via `networksetup` instead of a signal percentage (see below for why). Both platforms report `WIRED` if you're on ethernet instead of wifi |
| `omp/scripts/os_icon.sh` | The OS icon segment shells out to this. On Linux, reads `/etc/os-release` directly to figure out which distro you're actually on, see below for why. On macOS (which has no `/etc/os-release` at all) it just checks `uname` and shows a grey Apple glyph |

Two segments worth knowing about that aren't shell scripts, just built into the JSON: a root/sudo indicator that only shows up when you're actually running as root (invisible the rest of the time), and a stash count on the git segment that shows how many stashes you've got sitting in the current repo.

None of Kali, Mint, Fedora, or macOS read these files live out of the repo while your shell starts up. Each one's setup script (`*_terminal_setup.sh`) copies this JSON and these scripts into `~/.config/oh-my-posh/` when you install or update. So editing the repo copy by itself doesn't do anything until you run `manual_update.sh` in the relevant OS folder.

## Why the OS icon segment shells out to a script

Oh My Posh has a built-in way to show a distro-specific icon, but it turns out to be unreliable under WSL. Here's what's actually going on: under WSL, Oh My Posh figures out your distro from the `$WSL_DISTRO_NAME` environment variable, and only keeps the part before the first hyphen. Fedora's official WSL image sets that variable to something like `FedoraLinux-44`, so Oh My Posh ends up reading `fedoralinux` instead of `fedora`, doesn't recognize it, and quietly falls back to a generic icon.

Rather than trying to guess every possible `$WSL_DISTRO_NAME` variant across every distro and every way someone might have imported their WSL image, `os_icon.sh` just reads `/etc/os-release` directly. That file reports the real distro ID consistently whether you're on WSL, in a VM, or on a real non-virtualized install, so this one mechanism works everywhere instead of needing special cases.

## The macOS branches

macOS has none of `ip`, `nmcli`, `iw`, or `/sys/class/net`, so `vpn_ip.sh` and
`wifi_signal.sh` each have a `[[ "$(uname -s)" == "Darwin" ]]` branch that runs and
exits before any of the Linux logic below it ever executes - purely additive, the
Linux behavior is untouched.

The Wi-Fi branch reports the connected SSID instead of a signal percentage on
purpose: the old `airport -I` utility that gives a real RSSI number has been gated
behind macOS's Location Services privacy permissions since Big Sur, and a background
prompt script has no business prompting you for that. Worth knowing: the SSID lookup
it uses instead (`networksetup -getairportnetwork`) hit its own permission wall in
macOS 15 Sequoia's Local Network privacy feature, confirmed via multiple independent
reports - it can return "not associated" even while genuinely connected until the
terminal app is granted Local Network access in System Settings. The script still
fails soft when that happens (shows `--`/`WIRED` instead of the SSID, doesn't break),
see [`macOS/README.md`](../macOS/README.md) for the fix. The VPN branch checks
`scutil --nc list` first (the authoritative source for any VPN profile set up through
System Settings → VPN), then falls back to scanning `utun` interfaces for one with a
real IPv4 address, to catch third-party VPN apps like WireGuard or Tailscale that
don't register with `scutil`. Plain interface-presence isn't enough on its own the way
`tun0` is on Linux, since macOS also opens `utun` interfaces for unrelated system
features (Continuity/Handoff, iCloud Private Relay).

These branches were built from documented macOS behavior, not verified on real
hardware - there's no Mac available in the environment they were written in. See
[`macOS/README.md`](../macOS/README.md) for the current troubleshooting notes.

## The Windows exception

PowerShell can't read this Linux-side config live, and the VPN IP and wifi segments depend on Linux-only tools (`ip`, `nmcli`, `iw`) that don't exist on Windows at all. Because of that, [`Windows/terminal-customization.omp.json`](../Windows/terminal-customization.omp.json) is a standalone, hand-maintained copy of this file, not a live reference, with the VPN IP and wifi segments removed entirely. See [`Windows/README.md`](../Windows/README.md) for what it does keep.

If you change `omp/terminal-customization.omp.json`, the Windows copy will quietly drift out of sync. There's no automation watching for that. You have to manually port any relevant change into `Windows/terminal-customization.omp.json` yourself.

## Making a change here

1. Edit `omp/terminal-customization.omp.json` (or the scripts) in this folder.
2. Test it without touching your live config: `oh-my-posh print primary --config shared/omp/terminal-customization.omp.json --shell zsh`
3. Run `./manual_update.sh` in `Kali/`, `Mint/`, `Fedora/`, and/or `macOS/` to push the change out to each machine.
4. If the change matters visually, port it into `Windows/terminal-customization.omp.json` too (see the exception above).

For how this fits into the rest of the repo, check the root [`README.md`](../README.md).
