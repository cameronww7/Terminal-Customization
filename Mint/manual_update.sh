# Note
# ---------------------------------------
# Make sure file has needed perms
# chmod +x terminal_setup.sh


# Updating Plugins
# ---------------------------------------
# Updating highlighting
echo "\n Updating - zsh-syntax-highlighting"
cd /home/$USER/.oh-my-zsh/plugins/zsh-syntax-highlighting
sudo git fetch -A 
sudo git pull 

# Updating auto-suggester
echo "\n Updating - zsh-autosuggestions"
cd /home/$USER/.oh-my-zsh/plugins/zsh-autosuggestions
sudo git fetch -A 
sudo git pull 

# Updating k
echo "\n Updating - k"
cd /home/$USER/.oh-my-zsh/plugins/k
sudo git fetch -A 
sudo git pull 

# Updating powerlevel9k
echo "\n Updating - powerlevel9k"
cd /home/$USER/.oh-my-zsh/custom/themes/powerlevel9k
sudo git fetch -A 
sudo git pull 

# Updating tmux-logging
echo "\n Updating - tmux-logging"
cd /opt/tmux-logging/
sudo git fetch -A 
sudo git pull 

# Updating .zshrc file 
# ---------------------------------------
echo "\n Updating - Terminal-Customization"
echo "\n Updating - Terminal-Customization" 
cd /opt/Terminal-Customization
sudo git fetch -A 
sudo git pull 

sudo cat /opt/Terminal-Customization/Mint/.zshrc > ~/.zshrc

sudo source ~/.zshrc