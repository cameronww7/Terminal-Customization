#!/usr/bin/env zsh

# Note
# ---------------------------------------
# Make sure file has needed perms
# chmod +x terminal_setup.sh



# Update the System
# ---------------------------------------
sudo apt update


# Terminal Tools
# ---------------------------------------
sudo apt install -y terminator
sudo apt install -y autojump
sudo apt install -y tree
sudo apt install -y acpi
sudo apt install -y git


# Install Oh-My_ZSH
# ---------------------------------------
# Install oh-my-zsh
sudo curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh; zsh


# Install Plugins
# ---------------------------------------
# add highlighting
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting

# add auto-suggester
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions

# install k
sudo git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/plugins/k

# install powerlevel9k
sudo git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k



# Install .zshrc file 
# ---------------------------------------
sudo wget https://github.com/cameronww7/Terminal-Customization /opt/

sudo cat /opt/Terminal-Customization/.zshrc > ~/.zshrc

sudo source ~/.zshrc


# Add Plugin Update Code to Update File
# https://unix.stackexchange.com/questions/477258/how-to-auto-update-custom-plugins-in-oh-my-zsh
# ---------------------------------------
#echo "printf "\n${BLUE}%s${RESET}\n" "Updating custom plugins"
#		cd custom/plugins
#
#		for plugin in */; do
#		  if [ -d "$plugin/.git" ]; then
#			 printf "${YELLOW}%s${RESET}\n" "${plugin%/}"
#			 git -C "$plugin" pull
#		  fi
#		done" >> $HOME/.oh-my-zsh/tools/upgrade.sh

echo "\n \n Dont Forget to add in Code at the bottom of upgrade.sh in .oh-my-zsh"