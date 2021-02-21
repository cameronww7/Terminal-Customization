# Note
# ---------------------------------------
# Make sure file has needed perms
# chmod +x terminal_setup.sh


# Update the System
# ---------------------------------------
echo "\n apt update"
echo "\n apt update" >> terminal_setup_logs.txt
sudo apt update >> terminal_setup_logs.txt


# Install Plugins
# ---------------------------------------
# add highlighting
cd $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
sudo git fetch -A
sudo git pull


# add auto-suggester
cd $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
sudo git fetch -A
sudo git pull

# install k
cd $HOME/.oh-my-zsh/plugins/k
sudo git fetch -A
sudo git pull

# install powerlevel9k
cd $HOME/.oh-my-zsh/custom/themes/powerlevel9k
sudo git fetch -A
sudo git pull

# Install .zshrc file 
# ---------------------------------------
cd /opt/Terminal-Customization
sudo git fetch -A
sudo git pull

sudo cat /opt/Terminal-Customization/mint/.zshrc > ~/.zshrc

sudo source ~/.zshrc

