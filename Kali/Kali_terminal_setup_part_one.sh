# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Kali_terminal_setup.sh

# Update the System
# ---------------------------------------
echo "\n apt update"
sudo apt-get update


# Terminal Tools
# ---------------------------------------
echo "\n Installing - gedit"
sudo apt-get install -y gedit

echo "\n Installing - terminator"
sudo apt-get install -y terminator

echo "\n Installing - autojump"
sudo apt-get install -y autojump

echo "\n Installing - tree"
sudo apt-get install -y tree

echo "\n Installing - acpi"
sudo apt-get install -y acpi


# install Fonts
# ---------------------------------------
echo "\n Installing - fonts-powerline"
sudo apt-get install -y fonts-powerline

echo "\n Installing - fonts-hack"
sudo apt-get install -y fonts-hack

echo "\n Installing - fonts-font-awesome"
sudo apt-get install -y fonts-font-awesome

echo "\n Installing - fonts-powerlinesymbols"
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
echo "\n Installing - zsh"
sudo apt-get install -y zsh

sudo chsh -s $(which zsh) $USER

echo "\n Reload Now Load Part 2" 

echo "\n\n [END] \n\n" 