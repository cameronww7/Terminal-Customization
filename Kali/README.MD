# 🐉 Kali Terminal-Customization

A zsh setup built for the lab. Fast, git-aware, and it tells you your VPN IP without you having to check yourself.

The stack is [Zinit](https://github.com/zdharma-continuum/zinit) as the plugin manager and [Oh My Posh](https://ohmyposh.dev/) for the prompt, both pointed at the shared config in [`../shared/`](../shared/README.md). There's no Oh My Zsh and no Powerlevel9k/10k here anymore. This folder used to run both, and honestly not well (see [History](#history-if-youre-curious) below if you want the details).

## What you get

| Feature | What it does |
|---|---|
| 🟢 `TryHard3r` | A nameplate segment, neon green, on the left of every prompt |
| 🔌 VPN IP | Shows your `tun0` IP the moment you connect to a lab or VPN, `No-VPN` when you're not |
| 📶 Network status | Wifi signal strength when you're on wifi, `WIRED` when you're plugged in over ethernet |
| 🎩 Distro icon | Shows Kali's own icon, not a generic penguin, and it's accurate even under WSL |
| ⚡ `zsh-autosuggestions` | Ghost-text completion pulled from your history as you type |
| 🌈 `fast-syntax-highlighting` | Commands turn green when they're valid, red when they'd fail |
| 🧭 `zoxide` | `z <fuzzy-dir-name>` jumps you to any directory you've visited before |
| 📂 [`lsd`](https://github.com/lsd-rs/lsd) | A colorful, icon-rich `ls` replacement. `l`/`la`/`lla`/`lt` aliases give you a plain, all-files, long-all-files, and tree listing respectively |
| 🔎 `zsh-completions` | Extra tab-completion definitions for tools the built-in completion system doesn't already know about (`node`, `yarn`, etc). Just adds to `fpath`, no visual or keybinding changes |
| 🎨 `colored-man-pages`, `vscode`, `git` aliases | Loaded through Zinit's Oh My Zsh snippet support, so you get the same conveniences without any of the Oh My Zsh overhead |

## Before you start

- A Kali box with `apt` and `sudo` access
- An internet connection, since Zinit, Oh My Posh, and the font all get downloaded the first time you run this

## Installing it

```bash
# clone the repo
sudo git clone https://github.com/cameronww7/Terminal-Customization /opt/Terminal-Customization/
cd /opt/Terminal-Customization/Kali/

# run the setup script as yourself, not with sudo
# it calls sudo on its own for the lines that actually need root (apt-get, chsh)
chmod +x Kali_terminal_setup.sh
./Kali_terminal_setup.sh

# load it
exec zsh
```

Then set your terminal profile's font to **FiraCode Nerd Font Mono** (the script installs it, but you still have to select it in your terminal settings). Without that, the prompt's icons will just show up as empty boxes.

The first shell launch takes a little longer than usual since Zinit clones itself and its plugins the first time `.zshrc` gets sourced. Every launch after that is fast.

## Updating

```bash
cd /opt/Terminal-Customization/Kali/
./manual_update.sh
```

This pulls the latest version of the repo, updates every Zinit plugin, and copies your `.zshrc`, `.tmux.conf`, and the shared prompt config back into place.

## If something's not working

- **Prompt shows boxes or question marks instead of icons.** Your terminal profile isn't actually using FiraCode Nerd Font Mono yet. Set it in terminator's profile preferences and reopen the tab.
- **VPN segment always says `No-VPN`.** That's correct as long as `tun0` doesn't exist. It only lights up once you've connected to something (OpenVPN, etc.) that actually brings up a `tun0` interface.
- **Network status shows `--`.** No `nmcli` or `iw` found, and no wired connection detected either. If you think you should be connected, check `ip a` to see what interface is actually up.
- **`zinit: command not found`.** Open a new terminal tab or window. Zinit only becomes available after `.zshrc` has been sourced at least once.
- **A `zinit snippet OMZP::<name>` line fails with `curl: (22) ... 404`.** That plugin isn't actually bundled in the Oh My Zsh repo. Some well-known "Oh My Zsh plugins" like `zsh-completions` are really third-party repos people used to install by hand. Check the [ohmyzsh/ohmyzsh `plugins/` folder](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) to see if it's really there. If it's not, load it with `zinit light <github-user>/<repo>` instead of `zinit snippet OMZP::<name>`.
- **Nothing changed after editing `shared/omp/terminal-customization.omp.json`.** Editing that file in the repo only changes the repo copy. Run `./manual_update.sh` (or manually `cp` it into `~/.config/oh-my-posh/`) to actually push it live.

## History, if you're curious

This folder used to run Oh My Zsh with the old, long-archived Powerlevel9k engine, while a completely separate `.p10k.zsh` file sat right next to it doing nothing (it was never actually sourced). On top of that, the install script cloned real Powerlevel10k and tacked a second theme-loading line onto the bottom of `.zshrc`, after Oh My Zsh had already loaded Powerlevel9k. Three theme engines total, and only one of them ever actually rendered. All of that's gone now. One prompt engine, one config, shared with every other OS in this repo.

For the bigger picture, check the root [`README.md`](../README.md) and [`shared/README.md`](../shared/README.md).
