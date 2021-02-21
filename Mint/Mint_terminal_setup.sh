# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Mint_terminal_setup.sh

if ! [ -d "$HOME/.oh-my-zsh/" ] ; then
    # Create Log FIle
    # ---------------------------------------
    sudo touch /opt/terminal_install_logs.txt
    cd /opt/


    # Update the System
    # ---------------------------------------
    echo "\n apt update"
    echo "\n apt update" >> terminal_install_logs.txt
    sudo apt-get update >> terminal_install_logs.txt


    # Terminal Tools
    # ---------------------------------------
    echo "\n Installing - gedit"
    echo "\n Installing - gedit" >> terminal_install_logs.txt
    sudo apt-get install -y gedit >> terminal_install_logs.txt

    echo "\n Installing - terminator"
    echo "\n Installing - terminator" >> terminal_install_logs.txt
    sudo apt-get install -y terminator >> terminal_install_logs.txt

    echo "\n Installing - autojump"
    echo "\n Installing - autojump" >> terminal_install_logs.txt
    sudo apt-get install -y autojump >> terminal_install_logs.txt

    echo "\n Installing - tree"
    echo "\n Installing - tree" >> terminal_install_logs.txt
    sudo apt-get install -y tree >> terminal_install_logs.txt

    echo "\n Installing - acpi"
    echo "\n Installing - acpi" >> terminal_install_logs.txt
    sudo apt-get install -y acpi >> terminal_install_logs.txt

    echo "\n Installing - git"
    echo "\n Installing - git" >> terminal_install_logs.txt
    sudo apt-get install -y git >> terminal_install_logs.txt


    # Install zsh
    # ---------------------------------------
    # 1. Use which zshto find your zsh location.
    #       $ which zsh
    #       /usr/bin/zsh
    # 2. Add /usr/bin/zsh to /etc/shells
    # 3. Check in /etc/passwd that your config is /usr/bin/zsh
    # 4. Run: chsh -s /usr/bin/zsh
    # ^^^ For DEBUGGIN ^^^^
    echo "\n Installing - zsh"
    echo "\n Installing - zsh" >> terminal_install_logs.txt
    sudo apt-get install -y zsh

    echo "Current Shell - $SHELL"
    echo "Current Shell - $SHELL" >> terminal_install_logs.txt

    sudo echo "/usr/bin/zsh" >> /etc/shells

    sudo chsh -s "$(which zsh)" $USER
    sudo chsh -s /usr/bin/zsh $USER

    chsh -s "$(which zsh)" $USER
    chsh -s /usr/bin/zsh $USER

    echo "Current Shell - $SHELL"
    echo "Current Shell - $SHELL" >> terminal_install_logs.txt

    exit
fi

# install Fonts
# ---------------------------------------
echo "\n Installing - fonts-powerline"
echo "\n Installing - fonts-powerline" >> terminal_install_logs.txt
sudo apt-get install -y fonts-powerline

echo "\n Installing - fonts-hack"
echo "\n Installing - fonts-hack" >> terminal_install_logs.txt
sudo apt-get install -y fonts-hack

echo "\n Installing - fonts-font-awesome"
echo "\n Installing - fonts-font-awesome" >> terminal_install_logs.txt
sudo apt-get install -y fonts-font-awesome

echo "\n Installing - fonts-powerlinesymbols"
echo "\n Installing - fonts-powerlinesymbols" >> terminal_install_logs.txt
sudo apt-get install -y fonts-powerlinesymbols


# Install Plugins
# ---------------------------------------
# add highlighting
echo "\n Installing - highlighting"
echo "\n Installing - highlighting" >> terminal_install_logs.txt
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting >> terminal_install_logs.txt

# add auto-suggester
echo "\n Installing - auto-suggester"
echo "\n Installing - auto-suggester" >> terminal_install_logs.txt
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions >> terminal_install_logs.txt

# install k
echo "\n Installing - k"
echo "\n Installing - k" >> terminal_install_logs.txt
sudo git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/plugins/k >> terminal_install_logs.txt

# install powerlevel9k
echo "\n Installing - powerlevel9k"
echo "\n Installing - powerlevel9k" >> terminal_install_logs.txt
sudo git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k >> terminal_install_logs.txt


# Install .zshrc file 
echo "\n Installing - .zshrc"
echo "\n Installing - .zshrc" >> terminal_install_logs.txt
# ---------------------------------------
sudo cat /opt/Terminal-Customization/mint/.zshrc > ~/.zshrc

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

echo "\n\n [END] \n\n"  >> terminal_install_logs.txt