#!/usr/bin/env bash
#
# Sets up a Fedora terminal with Zinit (zsh plugin manager) + Oh My Posh (prompt).
# Run this yourself, as your normal user - do NOT run the whole script with
# sudo. The individual lines that need root (dnf, chsh) call sudo on their
# own and will prompt you for your password when they run.
#
#   chmod +x Fedora_terminal_setup.sh
#   ./Fedora_terminal_setup.sh

# Figure out where this repo actually lives, based on where this script is,
# instead of assuming it was cloned to /opt/Terminal-Customization. This way
# the script works no matter where you checked the repo out.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- Update package lists ----------------------------------------------------
printf "\n\n\n dnf check-update \n"
sudo dnf check-update

# --- Install terminal tools --------------------------------------------------
printf "\n\n\n Installing - git \n"
# You already needed git to clone this repo, but installing it explicitly here
# means this script also works if you got the repo some other way (zip download, etc)
sudo dnf install -y git

printf "\n\n\n Installing - gnome-text-editor \n"
# gedit's successor since Fedora 36 / GNOME 42. If you specifically want the
# legacy gedit package, run `dnf search gedit` first - it may still resolve
# on your release.
sudo dnf install -y gnome-text-editor

printf "\n\n\n Installing - zoxide \n"
sudo dnf install -y zoxide

printf "\n\n\n Installing - tree \n"
sudo dnf install -y tree

printf "\n\n\n Installing - gawk \n"
# gawk is required by the shared Oh My Posh VPN-IP / wifi-signal segment scripts
sudo dnf install -y gawk

printf "\n\n\n Installing - acpi \n"
sudo dnf install -y acpi

printf "\n\n\n Installing - terminator \n"
sudo dnf install -y terminator

# tmux-logging is an optional extra, left commented out on purpose. Uncomment
# these two lines (and the matching run-shell line in .tmux.conf) if you want
# tmux session logging.
#printf "\n\n\n Installing - tmux \n"
#sudo dnf install -y tmux
#printf "\n\n\n Installing - tmux-logging \n"
#sudo git clone https://github.com/tmux-plugins/tmux-logging /opt/tmux-logging/
#touch ~/.tmux.conf

# --- Install zsh and make it your login shell --------------------------------
# If the chsh line below doesn't seem to take effect, check that
# /usr/bin/zsh is listed in /etc/shells - some systems require that first.
printf "\n\n\n Installing - zsh \n"
sudo dnf install -y zsh
sudo chsh -s $(which zsh) $USER


# --- Install Oh My Posh (the prompt engine) + its font -----------------------
printf "\n\n\n Installing - oh-my-posh \n"
curl -s https://ohmyposh.dev/install.sh | bash -s
export PATH="$HOME/.local/bin:$PATH"

printf "\n\n\n Installing - FiraCode Nerd Font Mono \n"
oh-my-posh font install FiraCode

# --- Deploy the shared prompt config + its helper scripts --------------------
printf "\n\n\n Installing - shared Oh My Posh config \n"
mkdir -p ~/.config/oh-my-posh/scripts
cp "$REPO_ROOT/shared/omp/terminal-customization.omp.json" ~/.config/oh-my-posh/
cp "$REPO_ROOT/shared/omp/scripts/"*.sh ~/.config/oh-my-posh/scripts/
chmod +x ~/.config/oh-my-posh/scripts/*.sh

# --- Deploy your .zshrc and .tmux.conf ---------------------------------------
printf "\n\n\n Installing - .zshrc file \n"
cp "$REPO_ROOT/Fedora/.zshrc" ~/.zshrc
cp "$REPO_ROOT/Fedora/.tmux.conf" ~/.tmux.conf

# Zinit itself isn't installed here - it clones and bootstraps itself
# automatically the first time .zshrc gets sourced (see the top of Fedora/.zshrc).

# A scratch folder for lab work, in case you don't already have one.
mkdir -p ~/Hacking

printf "\n\n\n Open a new terminal (or run: exec zsh) to load the new shell \n"
printf "\n\n\n\n\n\n [END] \n\n\n\n\n\n"
