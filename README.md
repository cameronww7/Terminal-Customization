# 💀 Terminal-Customization

My personal terminal setup. It gets you the same fast, glyph-rich, git-aware prompt whether you're on Kali, Mint, Fedora, macOS, or Windows, plus a handful of quality-of-life plugins on the zsh side.

![Shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square&logo=gnu-bash&logoColor=white)
![Prompt](https://img.shields.io/badge/prompt-oh--my--posh-3EC669?style=flat-square)
![Plugins](https://img.shields.io/badge/plugin%20manager-zinit-orange?style=flat-square)
![Font](https://img.shields.io/badge/font-FiraCode%20Nerd%20Font-blueviolet?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-brightgreen?style=flat-square)

## Pick your OS

| Target | What it is | Setup guide |
|---|---|---|
| 🐉 Kali | Zsh + Zinit + Oh My Posh, tuned for a pentest box | [`Kali/README.MD`](Kali/README.MD) |
| 🌱 Mint | Same stack, tuned for a daily-driver desktop | [`Mint/README.MD`](Mint/README.MD) |
| 🎩 Fedora | Same stack again, built with `dnf` from the shared core | [`Fedora/README.MD`](Fedora/README.MD) |
| 🍎 macOS | Same stack again, built with `brew` from the shared core | [`macOS/README.MD`](macOS/README.MD) |
| 🪟 Windows | Native PowerShell + Oh My Posh, no zsh needed | [`Windows/README.md`](Windows/README.md) |

All five end up rendering basically the same prompt. Under the hood, Kali/Mint/Fedora/macOS all point at one shared config file, so if you jump between machines the muscle memory carries over. See [`shared/README.md`](shared/README.md) for how that's wired up.

## What you actually get

- **One prompt everywhere.** [Oh My Posh](https://ohmyposh.dev/) renders a black-and-neon-green prompt (yeah, kind of a Matrix vibe) showing your OS, user, current path, git status, exit code, battery, and the time.
- **`TryHard3r`.** A little nameplate on the left of every prompt. It's a nod to why this repo exists in the first place, so I left it in.
- **VPN awareness on Linux and macOS.** A segment on the right shows your VPN IP (Linux) or connected VPN profile/tunnel IP (macOS) the second a VPN comes up, and disappears entirely when you're not connected to one.
- **Network status on Linux and macOS.** Shows your wifi signal strength (Linux) or SSID (macOS) when you're on wifi, `WIRED` when you're plugged in over ethernet, and `--` when there's nothing to report.
- **Distro-correct OS icons.** Fedora shows its own blue icon, Kali shows its own icon, Mint shows its own leaf, macOS shows a grey Apple glyph, and anything else falls back to a plain clover. This works correctly even under WSL, where a lot of prompt themes get it wrong (more on that in `shared/README.md` if you're curious why).
- **Fast, modern zsh everywhere but Windows.** [Zinit](https://github.com/zdharma-continuum/zinit) loads `zsh-autosuggestions` (ghost-text completion from your history) and `fast-syntax-highlighting` (colors commands as you type), without any of the overhead Oh My Zsh used to add. `zoxide` gives you `z <fuzzy-dir-name>` so you don't have to remember full paths anymore.
- **One config to change, not five.** Edit the prompt once in [`shared/`](shared/README.md) and Kali, Mint, Fedora, and macOS all pick it up next time you update.

## How the pieces fit together

```
                            shared/omp/*.omp.json
                            (the one config that matters)
                                       |
                +-----------+-----------+-----------+
                |           |           |           |
           Kali/.zshrc  Mint/.zshrc  Fedora/.zshrc  macOS/.zshrc
                |           |           |           |
                +---- Zinit + Oh My Posh, same plugins --+

                    Windows/terminal-customization.omp.json
                    a hand-maintained copy, since PowerShell
                    can't read the Unix config live
```

Kali, Mint, Fedora, and macOS each have their own `.zshrc` (different package managers, different install scripts), but they all load the exact same Zinit plugins and point at the exact same prompt config. Windows can't share that file directly, so it keeps its own copy that has to be updated by hand when the shared one changes.

## Getting started

Every Kali/Mint/Fedora install works the same way, just swap in your OS folder:

```bash
sudo git clone https://github.com/cameronww7/Terminal-Customization /opt/Terminal-Customization/
cd /opt/Terminal-Customization/<Kali|Mint|Fedora>/
chmod +x <distro>_terminal_setup.sh
./<distro>_terminal_setup.sh   # don't run this with sudo, it calls sudo itself when it needs to
exec zsh
```

macOS follows the same shape, just without the `sudo git clone` (no `/opt` convention on Mac) - see [`macOS/README.md`](macOS/README.md) for the exact steps.

After that, set your terminal's font to **FiraCode Nerd Font Mono** (the script installs it for you) so the icons actually render instead of showing empty boxes. Each OS folder above has the full walkthrough plus troubleshooting if something doesn't look right.

Windows doesn't need the git-clone dance. See [`Windows/README.md`](Windows/README.md) for that one.

## Keeping it updated

Each OS folder has a `manual_update.sh` that pulls the latest version of this repo, updates your Zinit plugins, and re-copies your `.zshrc`, `.tmux.conf`, and the shared prompt config so your live setup matches what's in the repo.

## A bit of history

`Terminal_Photo.PNG` in the repo root is a screenshot from the original 2021 setup, back when this ran Oh My Zsh and Powerlevel9k. The prompt looks pretty different now. This repo went through a full rebuild from Oh My Zsh/Powerlevel9k-10k over to Zinit/Oh My Posh, and picked up a handful of real bug fixes along the way (some of them from the very install scripts this README describes, found while actually running them).

## License

[MIT](LICENSE). Do whatever you want with it.
