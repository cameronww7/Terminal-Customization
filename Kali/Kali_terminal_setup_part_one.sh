# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Kali_terminal_setup.sh

# Update the System
# ---------------------------------------
echo "\n\n\n apt update \n"
sudo apt-get update


# Terminal Tools
# ---------------------------------------
echo "\n\n\n Installing - gedit \n"
sudo apt-get install -y gedit

echo "\n\n\n Installing - autojump \n"
sudo apt-get install -y autojump

echo "\n\n\n Installing - tree \n"
sudo apt-get install -y tree

echo "\n\n\n Installing - acpi \n"
sudo apt-get install -y acpi

echo "\n\n\n Installing - terminator \n"
sudo apt-get install -y terminator

echo "\n\n\n Installing - tmux \n"
sudo apt-get install -y tmux

echo "\n\n\n Installing - tmux-logging \n"
sudo git clone https://github.com/tmux-plugins/tmux-logging /opt/tmux-logging/

touch ~/.tmux.conf

# install Fonts
# ---------------------------------------
echo "\n\n\n Installing - fonts-powerline \n"
sudo apt-get install -y fonts-powerline

echo "\n\n\n Installing - fonts-hack \n"
sudo apt-get install -y fonts-hack

echo "\n\n\n Installing - fonts-font-awesome \n"
sudo apt-get install -y fonts-font-awesome

echo "\n\n\n Installing - fonts-powerlinesymbols \n"
sudo apt-get install -y fonts-powerlinesymbols

# Install zsh
# ---------------------------------------
# 1. Use which zshto find your zsh location.
#       $ which zsh
#       /usr/bin/zsh
# 2. Add /usr/bin/zsh to /etc/shells
# 3. Check in /etc/passwd that your config is /usr/bin/zsh
# 4. Run: chsh -s /usr/bin/zsh
# ^^^ For DEBUGGIN ^^^^
echo "\n\n\n Installing - zsh \n"
sudo apt-get install -y zsh

sudo chsh -s $(which zsh) $USER

echo "\n\n\n Reload Now Load Part 2 \n" 

echo "\n\n\n\n\n\n [END] \n\n\n\n\n\n" 