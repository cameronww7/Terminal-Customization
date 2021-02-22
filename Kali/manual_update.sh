# Note
# ---------------------------------------
# Make sure file has needed perms
# chmod +x terminal_setup.sh

sudo touch /opt/manual_update_logs.txt
cd /opt/


# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n Updating - zsh-syntax-highlighting"
cd /home/$USER/.oh-my-zsh/plugins/zsh-syntax-highlighting
sudo git fetch -A 
sudo git pull 

# add auto-suggester
echo "\n Updating - zsh-autosuggestions"
cd /home/$USER/.oh-my-zsh/plugins/zsh-autosuggestions
sudo git fetch -A 
sudo git pull 

# install k
echo "\n Updating - k"
cd /home/$USER/.oh-my-zsh/plugins/k
sudo git fetch -A 
sudo git pull 

# install powerlevel9k
echo "\n Updating - powerlevel9k"
cd /home/$USER/.oh-my-zsh/custom/themes/powerlevel9k
sudo git fetch -A 
sudo git pull 

# Install .zshrc file 
# ---------------------------------------
echo "\n Updating - Terminal-Customization"
cd /opt/Terminal-Customization
sudo git fetch -A 
sudo git pull 

sudo cat /opt/Terminal-Customization/Kali/.zshrc > ~/.zshrc

sudo source ~/.zshrc