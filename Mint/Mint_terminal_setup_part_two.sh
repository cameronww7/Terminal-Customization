# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Mint_terminal_setup.sh

# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n Installing - highlighting"
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/plugins/zsh-syntax-highlighting 

# add auto-suggester
echo "\n Installing - auto-suggester"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /home/$USER/.oh-my-zsh/plugins/zsh-autosuggestions 

# install k
echo "\n Installing - k"
sudo git clone https://github.com/supercrabtree/k /home/$USER/.oh-my-zsh/plugins/k 
# install powerlevel9k
echo "\n Installing - powerlevel9k"
sudo git clone https://github.com/bhilburn/powerlevel9k.git /home/$USER/.oh-my-zsh/custom/themes/powerlevel9k


# Install .zshrc file 
echo "\n Installing - .zshrc"
# ---------------------------------------
sudo cat /opt/Terminal-Customization/Mint/.zshrc > ~/.zshrc

sudo source ~/.zshrc

sudo chsh -s $(which zsh) $USER

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
#		done" >> /home/$USER/.oh-my-zsh/tools/upgrade.sh

echo "\n \n Dont Forget to add in Code at the bottom of upgrade.sh in /home/$USER/.oh-my-zsh/"

echo "\n REBOOT YOUR SYSTEM "

echo "\n\n [END] \n\n"