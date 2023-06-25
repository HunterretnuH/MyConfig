#!/bin/sh
#This script creates soft links to config files and directories if required.
#If location of config changes the script should be rerun.
#This script shouldn't be moved outside repository

source configuration.sh

if [[ "$PACKAGE_MANAGER" == "pacman" ]];then
    install="pacman -S"
else
    echo "PACKAGE_MANAGER is not set"
    exit 1
fi
}

# Set quit on error
set -e

#Create user folder if it does not exist
mkdir -p /home/$USER

#INPUTRC
if [ $INPUTRC -eq 1 ]; then
    ln -sf $(pwd)/home/.inputrc ~/
fi

#BASHRC
if [ $BASHRC -eq 1 ]; then
    ln -sf $(pwd)/home/.bashrc ~/
fi

#SWAY - TODO Check
if [ $SWAY -eq 1 ]; then
    $install sway
    mkdir -p ~/.config/sway/
    ln -sf $(pwd)/sway/config ~/.config/sway/
fi

#KITTY
if [ $KITTY -eq 1 ]; then
    $install kitty
    mkdir -p ~/.config/kitty/               && ln -sf $(pwd)/kitty/.config/kitty/kitty.conf ~/.config/kitty/
    mkdir -p ~/.local/share/applications/   && ln -sf $(pwd)/kitty/.local/share/applications/kitty.desktop ~/.local/share/applications/
    mkdir -p ~/.local/bin                   && ln -sf $(pwd)/kitty/.local/bin/kitty ~/.local/bin/
fi

#NEOVIM - TODO Check
if [ $NEOVIM -eq 1 ]; then
    $install neovim
    mkdir -p ~/.config/nvim/ && ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/
fi

#NEOVIM FTDETECT AND FTPLUGINS - TODO Check
if [ $NEOVIM_FT -eq 1 ]; then
    mkdir -p ~/.config/nvim/ && ln -sf $(pwd)/nvim/ftdetect ~/.config/nvim/
    mkdir -p ~/.config/nvim/after && ln -sf $(pwd)/nvim/after/ftplugin ~/.config/nvim/after/
fi


#ZATHURA TODO Check
if [ $ZATHURA -eq 1 ]; then
    $install zathura
    mkdir -p ~/.config/zathura/ && ln -sf $(pwd)/zathura/zathurarc ~/.config/zathura/
fi

#RANGER TODO Check
if [ $RANGER -eq 1 ]; then
    $install ranger
    mkdir -p ~/.config/ranger/ &&
        ln -sf $(pwd)/ranger/rc.conf ~/.config/ranger/
        ln -sf $(pwd)/ranger/rifle.conf ~/.config/ranger/
    echo -e "WARNING: (RANGER) rifle.conf can change with updates. To make sure that config is up to date run \"ranger --copy-config=rifle\" to copy default and move changes manually."
fi
#Configs to add: .pufeline.conf rc.conf (ranger) rifle.conf (ranger), mpv.conf

#QUTEBROWSER - OLD CONFIG
if [ $QUTEBROWSER -eq 1 ]; then
    mkdir -p ~/.config/qutebrowser/ && ln -sf $(pwd)/qutebrowser/config.py ~/.config/qutebrowser/
    echo -e "WARNING: (QUTEBROWSER) config.py can change with updates."
fi
