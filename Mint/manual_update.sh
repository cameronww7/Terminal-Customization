# Note
# ---------------------------------------
# Make sure file has needed perms
# chmod +x terminal_setup.sh

sudo touch /opt/manual_update_logs.txt
cd /opt/

# Update the System
# ---------------------------------------
echo "\n apt update"
echo "\n apt update" >> /opt/manual_update_logs.txt
sudo apt update >> /opt/manual_update_logs.txt


# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n Updating - zsh-syntax-highlighting"
echo "\n Updating - zsh-syntax-highlighting" >> /opt/manual_update_logs.txt
cd $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
sudo git fetch -A >> /opt/manual_update_logs.txt
sudo git pull >> /opt/manual_update_logs.txt


# add auto-suggester
echo "\n Updating - zsh-autosuggestions"
echo "\n Updating - zsh-autosuggestions" >> /opt/manual_update_logs.txt
cd $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
sudo git fetch -A >> /opt/manual_update_logs.txt
sudo git pull >> /opt/manual_update_logs.txt

# install k
echo "\n Updating - k"
echo "\n Updating - k" >> /opt/manual_update_logs.txt
cd $HOME/.oh-my-zsh/plugins/k
sudo git fetch -A >> /opt/manual_update_logs.txt
sudo git pull >> /opt/manual_update_logs.txt

# install powerlevel9k
echo "\n Updating - powerlevel9k"
echo "\n Updating - powerlevel9k" >> /opt/manual_update_logs.txt
cd $HOME/.oh-my-zsh/custom/themes/powerlevel9k
sudo git fetch -A >> /opt/manual_update_logs.txt
sudo git pull >> /opt/manual_update_logs.txt

# Install .zshrc file 
# ---------------------------------------
echo "\n Updating - Terminal-Customization"
echo "\n Updating - Terminal-Customization" >> /opt/manual_update_logs.txt
cd /opt/Terminal-Customization
sudo git fetch -A >> /opt/manual_update_logs.txt
sudo git pull >> /opt/manual_update_logs.txt

sudo cat /opt/Terminal-Customization/mint/.zshrc > ~/.zshrc

sudo source ~/.zshrc