#!/usr/bin/env bash
#
# Sets up a macOS terminal with Zinit (zsh plugin manager) + Oh My Posh (prompt).
# Run this yourself, as your normal user - do NOT run the whole script with
# sudo. Homebrew and chsh prompt for your password on their own when they
# actually need it.
#
#   chmod +x macOS_terminal_setup.sh
#   ./macOS_terminal_setup.sh

# Figure out where this repo actually lives, based on where this script is,
# instead of assuming a fixed clone location. This way the script works no
# matter where you checked the repo out.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- Install Homebrew, if it's not already here ------------------------------
if ! command -v brew >/dev/null 2>&1; then
  printf "\n\n\n Installing - Homebrew \n"
  # Homebrew itself needs the Xcode Command Line Tools. If they're not
  # already on this Mac, the installer below pops up a GUI dialog to install
  # them that this script can't click through for you - finish that dialog,
  # then just re-run this script and it'll pick up where it left off.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew installs to /opt/homebrew on Apple Silicon and /usr/local on
# Intel. Load whichever one actually exists so the rest of this script (and
# this same shell session) can see `brew` right away, not just future shells.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  printf "\n\n\n Homebrew still isn't on PATH - finish the Xcode Command Line Tools install if it prompted you, then re-run this script.\n\n\n"
  exit 1
fi

# --- Update Homebrew ----------------------------------------------------------
printf "\n\n\n brew update \n"
brew update

# --- Install terminal tools --------------------------------------------------
printf "\n\n\n Installing - git \n"
# You already needed git to clone this repo, but installing it explicitly here
# means this script also works if you got the repo some other way (zip download, etc)
brew install git

printf "\n\n\n Installing - zoxide \n"
brew install zoxide

printf "\n\n\n Installing - tree \n"
brew install tree

printf "\n\n\n Installing - lsd \n"
# Powers the l/la/lla/lt aliases set up below - a colorful, icon-rich ls
# replacement (https://github.com/lsd-rs/lsd)
brew install lsd

printf "\n\n\n Installing - iTerm2 \n"
brew install --cask iterm2

# No gawk here on purpose: the shared VPN-IP / wifi-signal segment scripts
# only use plain field-splitting and pattern matching, nothing GNU-specific,
# so macOS's built-in BSD awk already covers what they need.

# --- Make sure you're on zsh --------------------------------------------------
# macOS has shipped zsh as the default login shell since Catalina, already
# at /bin/zsh - no install needed. This just covers anyone who switched back
# to bash at some point; harmless (and a no-op) if you're already on zsh.
printf "\n\n\n Setting default shell - zsh \n"
sudo chsh -s /bin/zsh "$USER"


# --- Install Oh My Posh (the prompt engine) + its font -----------------------
printf "\n\n\n Installing - oh-my-posh \n"
brew install jandedobbeleer/oh-my-posh/oh-my-posh

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
cp "$REPO_ROOT/macOS/.zshrc" ~/.zshrc
cp "$REPO_ROOT/macOS/.tmux.conf" ~/.tmux.conf

# Zinit itself isn't installed here - it clones and bootstraps itself
# automatically the first time .zshrc gets sourced (see the top of macOS/.zshrc).

printf "\n\n\n Open a new terminal (or run: exec zsh) to load the new shell \n"
printf "\n\n\n\n\n\n [END] \n\n\n\n\n\n"
