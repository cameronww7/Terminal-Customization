#!/usr/bin/env bash
#
# Re-pulls this repo and re-syncs your live Zinit plugins, .zshrc,
# .tmux.conf, and the shared Oh My Posh config from it. Run as your normal
# user - do NOT run this with sudo.
#
#   chmod +x manual_update.sh
#   ./manual_update.sh

# Figure out where this repo actually lives, based on where this script is,
# instead of assuming it was cloned to /opt/Terminal-Customization.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

printf "\n Updating - Terminal-Customization\n"
cd "$REPO_ROOT"
git fetch -a
git pull
# If you originally cloned this repo with `sudo git clone` (e.g. into /opt)
# it'll be owned by root, and the two git commands above will fail with a
# permission error. Fix that once with:
#   sudo chown -R "$USER" "$REPO_ROOT"

# --- Update Zinit itself and every plugin it manages -------------------------
# `zinit` is a zsh function defined inside .zshrc, not a real standalone
# command - it doesn't exist in this bash script's environment. Running it
# through `zsh -ic` opens an interactive zsh, which sources .zshrc (loading
# zinit) before running the update commands.
printf "\n Updating - Zinit plugins\n"
zsh -ic "zinit self-update && zinit update --all"

# --- Re-sync your dotfiles and the shared prompt config from the repo --------
cp "$REPO_ROOT/Mint/.zshrc" ~/.zshrc
cp "$REPO_ROOT/Mint/.tmux.conf" ~/.tmux.conf
cp "$REPO_ROOT/shared/omp/terminal-customization.omp.json" ~/.config/oh-my-posh/
cp "$REPO_ROOT/shared/omp/scripts/"*.sh ~/.config/oh-my-posh/scripts/
chmod +x ~/.config/oh-my-posh/scripts/*.sh

printf "\n Open a new terminal (or run: exec zsh) to load the updated shell \n"
