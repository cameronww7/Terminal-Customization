# Note
# ---------------------------------------
# Make sure file has needed perms
# sudo chmod +x Mint_terminal_setup.sh


# Create Log FIle
# ---------------------------------------
sudo touch /opt/Mint_terminal_install_logs.txt
cd /opt/


# Update the System
# ---------------------------------------
echo "\n apt update"
echo "\n apt update" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get update >> /opt/Mint_terminal_install_logs.txt


# Terminal Tools
# ---------------------------------------
echo "\n Installing - gedit"
echo "\n Installing - gedit" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y gedit >> /opt/Mint_terminal_install_logs.txt

echo "\n Installing - terminator"
echo "\n Installing - terminator" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y terminator >> /opt/Mint_terminal_install_logs.txt

echo "\n Installing - autojump"
echo "\n Installing - autojump" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y autojump >> /opt/Mint_terminal_install_logs.txt

echo "\n Installing - tree"
echo "\n Installing - tree" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y tree >> /opt/Mint_terminal_install_logs.txt

echo "\n Installing - acpi"
echo "\n Installing - acpi" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y acpi >> /opt/Mint_terminal_install_logs.txt

echo "\n Installing - git"
echo "\n Installing - git" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y git >> /opt/Mint_terminal_install_logs.txt


# install Fonts
# ---------------------------------------
echo "\n Installing - fonts-powerline"
echo "\n Installing - fonts-powerline" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y fonts-powerline

echo "\n Installing - fonts-hack"
echo "\n Installing - fonts-hack" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y fonts-hack

echo "\n Installing - fonts-font-awesome"
echo "\n Installing - fonts-font-awesome" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y fonts-font-awesome

echo "\n Installing - fonts-powerlinesymbols"
echo "\n Installing - fonts-powerlinesymbols" >> /opt/Mint_terminal_install_logs.txt
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
echo "\n Installing - zsh" >> /opt/Mint_terminal_install_logs.txt
sudo apt-get install -y zsh


echo "\n Reload Now Load Part 2" 

echo "\n\n [END] \n\n"  >> /opt/Mint_terminal_install_logs.txt