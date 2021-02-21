# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x terminal_setup.sh

# Create Log FIle
# ---------------------------------------
sudo touch /opt/terminal_setup_logs.txt

cd /opt/


# Update the System
# ---------------------------------------
echo "\n apt update"
echo "\n apt update" >> terminal_setup_logs.txt
sudo apt update >> terminal_setup_logs.txt


# Terminal Tools
# ---------------------------------------
echo "\n Installing - gedit"
echo "\n Installing - gedit" >> terminal_setup_logs.txt
sudo apt install -y gedit >> terminal_setup_logs.txt

echo "\n Installing - terminator"
echo "\n Installing - terminator" >> terminal_setup_logs.txt
sudo apt install -y terminator >> terminal_setup_logs.txt

echo "\n Installing - autojump"
echo "\n Installing - autojump" >> terminal_setup_logs.txt
sudo apt install -y autojump >> terminal_setup_logs.txt

echo "\n Installing - tree"
echo "\n Installing - tree" >> terminal_setup_logs.txt
sudo apt install -y tree >> terminal_setup_logs.txt

echo "\n Installing - acpi"
echo "\n Installing - acpi" >> terminal_setup_logs.txt
sudo apt install -y acpi >> terminal_setup_logs.txt

echo "\n Installing - git"
echo "\n Installing - git" >> terminal_setup_logs.txt
sudo apt install -y git >> terminal_setup_logs.txt


# Install zsh
# ---------------------------------------
echo "\n Installing - zsh"
echo "\n Installing - zsh" >> terminal_setup_logs.txt
sudo apt install -y zsh >> terminal_setup_logs.txt

echo "Current Shell - $SHELL"
echo "Current Shell - $SHELL" >> terminal_setup_logs.txt

chsh -s $(which zsh) 
chsh -s /usr/bin/zsh

echo "Current Shell - $SHELL"
echo "Current Shell - $SHELL" >> terminal_setup_logs.txt


# Install Oh-My_ZSH
# ---------------------------------------
# Install oh-my-zsh
echo "\n Installing - oh-my-zsh"
echo "\n Installing - oh-my-zsh" >> terminal_setup_logs.txt
sudo wget -P /opt/OhMyZSH/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh >> terminal_setup_logs.txt
cd /opt/OhMyZSH/
sudo chmod +x /opt/OhMyZSH/install.sh
./install.sh >> terminal_setup_logs.txt


# install Fonts
# ---------------------------------------
echo "\n Installing - fonts-powerline"
echo "\n Installing - fonts-powerline" >> terminal_setup_logs.txt
sudo apt-get install -y fonts-powerline

echo "\n Installing - fonts-hack"
echo "\n Installing - fonts-hack" >> terminal_setup_logs.txt
sudo apt-get install -y fonts-hack

echo "\n Installing - fonts-font-awesome"
echo "\n Installing - fonts-font-awesome" >> terminal_setup_logs.txt
sudo apt-get install -y fonts-font-awesome

echo "\n Installing - fonts-powerlinesymbols"
echo "\n Installing - fonts-powerlinesymbols" >> terminal_setup_logs.txt
sudo apt-get install -y fonts-powerlinesymbols


# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n Installing - highlighting"
echo "\n Installing - highlighting" >> terminal_setup_logs.txt
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting >> terminal_setup_logs.txt

# add auto-suggester
echo "\n Installing - auto-suggester"
echo "\n Installing - auto-suggester" >> terminal_setup_logs.txt
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions >> terminal_setup_logs.txt

# install k
echo "\n Installing - k"
echo "\n Installing - k" >> terminal_setup_logs.txt
sudo git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/plugins/k >> terminal_setup_logs.txt

# install powerlevel9k
echo "\n Installing - powerlevel9k"
echo "\n Installing - powerlevel9k" >> terminal_setup_logs.txt
sudo git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k >> terminal_setup_logs.txt



# Install .zshrc file 
echo "\n Installing - .zshrc"
echo "\n Installing - .zshrc" >> terminal_setup_logs.txt
# ---------------------------------------
sudo cat /opt/Terminal-Customization/kali/.zshrc > ~/.zshrc

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

echo "\n Reload the Terminal"

echo "\n\n [END] \n\n"  >> terminal_setup_logs.txt