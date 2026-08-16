# 🎩 Fedora Terminal-Customization

The newest addition. Built from the shared, cleaned-up core of the Kali and Mint configs, not copied from either one individually. Same prompt, same plugins, just `dnf` instead of `apt`.

The stack is [Zinit](https://github.com/zdharma-continuum/zinit) as the plugin manager and [Oh My Posh](https://ohmyposh.dev/) for the prompt, both pointed at the shared config in [`../shared/`](../shared/README.md). Zinit bootstraps itself the first time your shell starts, so there's no separate plugin-manager install step to worry about.

## What you get

| Feature | What it does |
|---|---|
| 🟢 `TryHard3r` | A nameplate segment, neon green, on the left of every prompt |
| 🔌 VPN IP | Shows your `tun0` IP the moment a VPN connection comes up, `No-VPN` otherwise |
| 📶 Network status | Wifi signal strength when you're on wifi, `WIRED` when you're plugged in over ethernet |
| 🔵 Distro icon | Shows Fedora's own blue icon, not a generic penguin, and it's accurate even under WSL (see the Notes section below, that one turned out to be trickier than it sounds) |
| ⚡ `zsh-autosuggestions` | Ghost-text completion pulled from your history as you type |
| 🌈 `fast-syntax-highlighting` | Commands turn green when they're valid, red when they'd fail |
| 🧭 `zoxide` | `z <fuzzy-dir-name>` jumps you to any directory you've visited before |
| 📂 [`lsd`](https://github.com/lsd-rs/lsd) | A colorful, icon-rich `ls` replacement. `l`/`la`/`lla`/`lt` aliases give you a plain, all-files, long-all-files, and tree listing respectively |
| 🔎 `zsh-completions` | Extra tab-completion definitions for tools the built-in completion system doesn't already know about (`node`, `yarn`, etc). Just adds to `fpath`, no visual or keybinding changes |
| 🎨 `colored-man-pages`, `vscode`, `git`, `dnf` aliases | Loaded through Zinit's Oh My Zsh snippet support. The `dnf` plugin is turned on by default here. Everywhere else in this repo it was a leftover copy-paste mistake, but on Fedora it's actually the right plugin to have |

## Before you start

- A Fedora box with `dnf` and `sudo` access
- An internet connection, since Zinit, Oh My Posh, and the font all get downloaded the first time you run this

## Installing it

```bash
# clone the repo
sudo git clone https://github.com/cameronww7/Terminal-Customization /opt/Terminal-Customization/
cd /opt/Terminal-Customization/Fedora/

# run the setup script as yourself, not with sudo
# it calls sudo on its own for the lines that actually need root (dnf, chsh)
chmod +x Fedora_terminal_setup.sh
./Fedora_terminal_setup.sh

# load it
exec zsh
```

Then set your terminal profile's font to **FiraCode Nerd Font Mono** (the script installs it, but you still have to select it in your terminal settings). Without that, the prompt's icons will just show up as empty boxes.

The first shell launch takes a little longer than usual since Zinit clones itself and its plugins the first time `.zshrc` gets sourced. Every launch after that is fast.

## Updating

```bash
cd /opt/Terminal-Customization/Fedora/
./manual_update.sh
```

This pulls the latest version of the repo, updates every Zinit plugin, and copies your `.zshrc`, `.tmux.conf`, and the shared prompt config back into place.

## If something's not working

- **Prompt shows boxes or question marks instead of icons.** Your terminal profile isn't actually using FiraCode Nerd Font Mono yet. Set it in terminator's profile preferences and reopen the tab.
- **VPN segment always says `No-VPN`.** That's correct as long as `tun0` doesn't exist. It only lights up once you've connected to something that actually brings up a `tun0` interface.
- **Network status shows `--`.** No `nmcli` or `iw` found, and no wired connection detected either. If you think you should be connected, check `ip a` to see what interface is actually up.
- **`zinit: command not found`.** Open a new terminal tab or window. Zinit only becomes available after `.zshrc` has been sourced at least once.
- **A `zinit snippet OMZP::<name>` line fails with `curl: (22) ... 404`.** That plugin isn't actually bundled in the Oh My Zsh repo. Some well-known "Oh My Zsh plugins" like `zsh-completions` are really third-party repos people used to install by hand. Check the [ohmyzsh/ohmyzsh `plugins/` folder](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) to see if it's really there. If it's not, load it with `zinit light <github-user>/<repo>` instead of `zinit snippet OMZP::<name>`.
- **`gedit` won't install.** Fedora dropped `gedit` as the default text editor as of Fedora 36 (GNOME 42). This setup installs `gnome-text-editor` instead, which is its direct successor. If you specifically want the old `gedit`, run `dnf search gedit` first to see if it still resolves on your release.
- **Nothing changed after editing `shared/omp/terminal-customization.omp.json`.** Editing that file in the repo only changes the repo copy. Run `./manual_update.sh` (or manually `cp` it into `~/.config/oh-my-posh/`) to actually push it live.

## Notes

Package names are verified against Fedora's actual repos: `gnome-text-editor`, `zoxide`, `tree`, `lsd`, `acpi`, `terminator`, `zsh`, and `gawk` all install under those exact names via `dnf`.

The distro icon deserves a quick explanation, because the reason it needed a fix is genuinely interesting. Oh My Posh normally figures out which distro icon to show using `$WSL_DISTRO_NAME` when you're running under WSL. The problem is Fedora's official WSL image sets that variable to something like `FedoraLinux-44`, and Oh My Posh only keeps the part before the first hyphen, so it sees `fedoralinux` instead of `fedora` and silently falls back to a generic icon. This repo works around that by reading `/etc/os-release` directly instead (see `shared/omp/scripts/os_icon.sh`), which gives the right answer whether you're on WSL, in a VM, or on a real non-virtualized install.

For the bigger picture, check the root [`README.md`](../README.md) and [`shared/README.md`](../shared/README.md).
