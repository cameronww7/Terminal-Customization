# 🍎 macOS Terminal-Customization

Same prompt, same plugins, same shared config as Kali/Mint/Fedora - just `brew`
instead of `dnf`/`apt`. Unlike Windows, macOS is a real Unix with zsh, so this points
straight at the exact same [`../shared/`](../shared/README.md) config file, live, no
hand-maintained copy involved.

The stack is [Zinit](https://github.com/zdharma-continuum/zinit) as the plugin manager
and [Oh My Posh](https://ohmyposh.dev/) for the prompt. Zinit bootstraps itself the
first time your shell starts, so there's no separate plugin-manager install step to
worry about.

## What you get

| Feature | What it does |
|---|---|
| 🟢 `TryHard3r` | A nameplate segment, neon green, on the left of every prompt |
| 🔌 VPN indicator | Shows the connected VPN's name when a profile set up through System Settings → VPN is active, or the tunnel IP for third-party VPN apps (WireGuard, Tailscale, etc.) |
| 📶 Network status | Your Wi-Fi network name when you're on Wi-Fi, `WIRED` when you're plugged in over ethernet |
| ⚪ Apple icon | A grey Apple glyph in the OS-icon slot, same place Fedora/Kali/Mint show their own distro icon |
| ⚡ `zsh-autosuggestions` | Ghost-text completion pulled from your history as you type |
| 🌈 `fast-syntax-highlighting` | Commands turn green when they're valid, red when they'd fail |
| 🧭 `zoxide` | `z <fuzzy-dir-name>` jumps you to any directory you've visited before |
| 📂 [`lsd`](https://github.com/lsd-rs/lsd) | A colorful, icon-rich `ls` replacement. `l`/`la`/`lla`/`lt` aliases give you a plain, all-files, long-all-files, and tree listing respectively |
| 🔎 `zsh-completions` | Extra tab-completion definitions for tools the built-in completion system doesn't already know about (`node`, `yarn`, etc). Just adds to `fpath`, no visual or keybinding changes |
| 🎨 `colored-man-pages`, `vscode`, `git` aliases | Loaded through Zinit's Oh My Zsh snippet support |

## Before you start

- A Mac with admin rights (Homebrew and `chsh` will ask for your password when they need it)
- An internet connection - Homebrew, Zinit, Oh My Posh, and the font all get downloaded the first time you run this

## Installing it

```bash
git clone https://github.com/cameronww7/Terminal-Customization ~/Terminal-Customization
cd ~/Terminal-Customization/macOS/

# run the setup script as yourself, not with sudo
# it calls sudo/brew on its own for the lines that actually need it
chmod +x macOS_terminal_setup.sh
./macOS_terminal_setup.sh

# load it
exec zsh
```

Then set your terminal profile's font to **FiraCode Nerd Font Mono** (the script
installs it, but you still have to select it - in iTerm2 that's
**Preferences → Profiles → Text → Font**). Without that, the prompt's icons will just
show up as empty boxes.

The first shell launch takes a little longer than usual since Zinit clones itself and
its plugins the first time `.zshrc` gets sourced. Every launch after that is fast.

## Updating

```bash
cd ~/Terminal-Customization/macOS/
./manual_update.sh
```

This pulls the latest version of the repo, updates every Zinit plugin, and copies your
`.zshrc`, `.tmux.conf`, and the shared prompt config back into place.

## If something's not working

- **The setup script exits right after Homebrew's installer runs.** That means Homebrew needed the Xcode Command Line Tools and popped up a GUI dialog for them - this script can't click through that for you. Finish the dialog, then just run `./macOS_terminal_setup.sh` again; everything it already did is safe to repeat.
- **Prompt shows boxes or question marks instead of icons.** Your terminal profile isn't actually using FiraCode Nerd Font Mono yet. Set it in iTerm2's profile preferences (or Terminal.app's, if you skipped iTerm2) and reopen the tab.
- **Wi-Fi segment always shows `--` even though you're clearly on Wi-Fi.** Confirmed, sourced issue, not a guess: starting with macOS 15 Sequoia, Apple added a Local Network permission gate that can make `networksetup -getairportnetwork` return `You are not associated with an AirPort network.` even while genuinely connected, for apps (including terminals) that haven't been granted Local Network access - some users report this being flaky even after granting it. Check **System Settings → Privacy & Security → Local Network** and make sure your terminal app (iTerm2 or Terminal) is toggled on there; if it's already on, try toggling it off and back on, or toggling Wi-Fi off/on, which several people reported fixed it for them. This script fails soft either way - you'll just see `--`/`WIRED` instead of your SSID, not a broken segment.
- **VPN segment doesn't show up even though you're connected.** This one's built two ways: it first checks `scutil --nc list` for a VPN profile configured through System Settings → VPN, then falls back to checking for a `utun` interface with a real IPv4 address for third-party VPN apps. If your VPN client does neither of those (uncommon, but possible), the segment just won't have anything to show - this is the one part of the macOS setup that hasn't been tested against a real Mac yet, so if this happens, that's useful to know.
- **`zinit: command not found`.** Open a new terminal tab or window. Zinit only becomes available after `.zshrc` has been sourced at least once.
- **`brew: command not found` even after installing it.** Open a new terminal tab, or manually run `eval "$(/opt/homebrew/bin/brew shellenv)"` (Apple Silicon) or `eval "$(/usr/local/bin/brew shellenv)"` (Intel) once to pick it up in the current shell.
- **Nothing changed after editing `shared/omp/terminal-customization.omp.json`.** Editing that file in the repo only changes the repo copy. Run `./manual_update.sh` (or manually `cp` it into `~/.config/oh-my-posh/`) to actually push it live.

## Notes

Unlike the Linux distros, this setup deliberately doesn't install `zsh` (macOS already
ships a recent enough one at `/bin/zsh` as the default login shell since Catalina) or
a `gawk` equivalent (the shared scripts only use plain POSIX awk features, which
macOS's built-in BSD awk already handles).

The VPN and Wi-Fi segment scripts (`shared/omp/scripts/vpn_ip.sh` and
`wifi_signal.sh`) both got a macOS-specific branch added alongside their existing
Linux logic - see [`shared/README.md`](../shared/README.md) for what those branches
actually do and why they're built the way they are. Worth knowing going in: those
branches were built from documented macOS behavior, not tested against real macOS
hardware, so treat the "If something's not working" section above as a first draft
until you've actually run this once.

For the bigger picture, check the root [`README.md`](../README.md) and
[`shared/README.md`](../shared/README.md).
