# Mint Terminal-Customization

1. Clone Terminal-Customization Repo
   1. `sudo git clone https://github.com/cameronww7/Terminal-Customization /opt/Terminal-Customization/`

2. CD to `cd /opt/Terminal-Customization/Mint/`

3. chmod install Mint_terminal_setup.sh
   1. `sudo chmod +x Mint_terminal_setup_part_one.sh`

4. Run Install Script Part 1
   1. `sudo ./Mint_terminal_setup_part_one.sh`
   2. Will Exit (Thats good)

5. Install ohmyzsh
   1. run this in Downloads`sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
   2. Enter your password when prompted

6. After installed your shell will look different
   1. type `exit`, Your in the zsh shell we need to go back to bash shell

7. chmod install Mint_terminal_setup.sh
   1. `sudo chmod +x Mint_terminal_setup_part_two.sh`

8. Run Install Script Part 2
    1. *(DO NOT RUN AS SUDO, enter Password if Prompted)*
    2. `./Kali_terminal_setup_part_two.sh`
    3. You will get prompted for your password