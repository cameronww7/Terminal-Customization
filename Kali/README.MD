# Kali Terminal-Customization

1. Clone Terminal-Customization Repo
   1. `sudo git clone https://github.com/cameronww7/Terminal-Customization /opt/Terminal-Customization/`

2. CD to `cd /opt/Terminal-Customization/Kali/`

3. chmod install Kali_terminal_setup.sh
   1. `sudo chmod +x Kali_terminal_setup_part_one.sh`

4. Run Install Script Part 1
   1. `sudo ./Kali_terminal_setup_part_one.sh`
   2. Will Exit (Thats good)

5. Install ohmyzsh
   1. cd to `cd ~/Downloads`
   2. run this in Downloads`sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

6. CD to `cd /opt/Terminal-Customization/Kali/`

7. Run Install Script Part 2
   1. *(DO NOT RUN AS SUDO, enter Password if Prompted)*
   2. `./Kali_terminal_setup_part_two.sh`