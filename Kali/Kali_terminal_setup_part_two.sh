# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Kali_terminal_setup.sh

# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n\n\n Installing - highlighting \n"
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/plugins/zsh-syntax-highlighting 

# add auto-suggester
echo "\n\n\n Installing - auto-suggeste \n"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /home/$USER/.oh-my-zsh/plugins/zsh-autosuggestions 

# install k
echo "\n\n\n Installing - k"
sudo git clone https://github.com/supercrabtree/k /home/$USER/.oh-my-zsh/plugins/k 

# install powerlevel9k
echo "\n\n\n Installing - powerlevel9k \n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc



# Install .zshrc file 
# ---------------------------------------
echo "\n\n\n Installing - .zshrc file \n"
sudo cat /opt/Terminal-Customization/Kali/.zshrc > ~/.zshrc
sudo source ~/.zshrc


# Setup my File Strucutres 
sudo mkdir ~/Hacking
sudo chmod -R 777 ~/Hacking  
sudo chmod -R 777 /opt 

# Add Plugin Update Code to Update File
# https://unix.stackexchange.com/questions/477258/how-to-auto-update-custom-plugins-in-oh-my-zsh
# ---------------------------------------
#echo "printf "\n\n\n${BLUE}%s${RESET}\n\n\n" "Updating custom plugins"
#		cd custom/plugins
#
#		for plugin in */; do
#		  if [ -d "$plugin/.git" ]; then
#			 printf "${YELLOW}%s${RESET}\n\n\n" "${plugin%/}"
#			 git -C "$plugin" pull
#		  fi
#		done" >> /home/$USER/.oh-my-zsh/tools/upgrade.sh

echo "\n\n\n \n\n\n Dont Forget to add in Code at the bottom of upgrade.sh in /home/$USER/.oh-my-zsh/ \n"

echo "\n\n\n Reload the Terminal \n"

echo "\n\n\n\n\n\n [END] \n\n\n\n\n\n"  >> /opt/Kali_terminal_install_logs.txt