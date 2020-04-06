#!/bin/sh
#This script creates soft links to config files and directories if required.
#If location of config changes the script should be rerun.
#This script shouldn't be moved outside repository

#CONFIGURATION START (0 - DISABLED, 1 - ENABLED):
    INPUTRC=1
    BASHRC=1
    SWAY=1
    KITTY=1
    NEOVIM=1
    NEOVIM_NOTES=1
    QUTEBROWSER=1
    ZATHURA=1
    RANGER=1

#CONFIGURATION END

#CREATE USER FOLDER IF IT DOES NOT EXIST
mkdir -p /home/$USER

#INPUTRC
if [ $INPUTRC -eq 1 ]; then
    ln -sf $(pwd)/home/.inputrc ~/
fi

#BASHRC
if [ $BASHRC -eq 1 ]; then
    ln -sf $(pwd)/home/.bashrc ~/
fi

#SWAY
if [ $SWAY -eq 1 ]; then
    mkdir -p ~/.config/sway/
    ln -sf $(pwd)/sway/config ~/.config/sway/
fi

#KITTY
if [ $KITTY -eq 1 ]; then
    mkdir -p ~/.config/kitty/
    ln -sf $(pwd)/kitty/kitty.conf ~/.config/kitty/
fi

#NEOVIM
if [ $NEOVIM -eq 1 ]; then
    mkdir -p ~/.config/nvim/
    ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/
fi

#NEOVIM_NOTES
if [ $NEOVIM -eq 1 ]; then
    mkdir -p ~/.config/nvim/ftdetect
    ln -sf $(pwd)/nvim/ftdetect/notes.vim ~/.config/nvim/ftdetect/
    mkdir -p ~/.config/nvim/after/ftplugin
    ln -sf $(pwd)/nvim/after/ftplugin/notes.vim ~/.config/nvim/after/ftplugin
fi

#QUTEBROWSER
if [ $QUTEBROWSER -eq 1 ]; then
    mkdir -p ~/.config/qutebrowser/
    ln -sf $(pwd)/qutebrowser/config.py ~/.config/qutebrowser/
    echo -e "WARNING: (QUTEBROWSER) config.py can change with updates."
fi

#ZATHURA
if [ $ZATHURA -eq 1 ]; then
    mkdir -p ~/.config/zathura/
    ln -sf $(pwd)/zathura/zathurarc ~/.config/zathura/
fi

#RANGER
if [ $RANGER -eq 1 ]; then
    mkdir -p ~/.config/ranger/
    ln -sf $(pwd)/ranger/rc.conf ~/.config/ranger/
    ln -sf $(pwd)/ranger/rifle.conf ~/.config/ranger/
    echo -e "WARNING: (RANGER) rifle.conf can change with updates. To make sure that config is up to date run \"ranger --copy-config=rifle\" to copy default and move changes manually."
fi
#Configs to add: .pufeline.conf rc.conf (ranger) rifle.conf (ranger), mpv.conf
