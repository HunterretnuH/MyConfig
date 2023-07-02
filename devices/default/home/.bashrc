# vim: foldmethod=marker

#export PAGER='less -s'
PATH=/home/$USER/.local/bin/MyPrograms:/home/$USER/.local/bin/:/home/$USER/MyScripts:$PATH
# GLOBAL VARIABLES

# TODO: Verify if export is required
export XDG_CONFIG_HOME="$HOME/.config" 
export EDITOR="nvim"
export GOPATH="/home/$USER/MyPrograms/go"
export MOZ_ENABLE_WAYLAND=1
SCREENSHOT_DIR="$HOME/Documents/Screenshots"
QT_QPA_PLATFORMTHEME=qt5ct
#export MESA_LOADER_DRIVER_OVERRIDE=radeonsi                                         # Test if impacts firefox launch
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json    # If not then remove
export AMD_DEBUG=nodcc

#required for correct bindings to be loaded for fzf (even though it will be set later by my .inputrc)
set -o vi
bind "\eC-H":backward-kill-word
#ALIASES
alias v='nvim'
alias ls='ls --color --group-directories-first'
alias l='ls -lh'
alias ll='l -a'
alias e='exit'
alias ranger='source ranger ranger'
alias r='ranger'
alias cdd="cd ~/Desktop"
alias k='kitty --detach'
alias kp="sudo kill \$(ps -A|fzf|awk '{print \$1}')"
alias kkp="sudo kill -s SIGKILL \$(ps -A|fzf|awk '{print \$1}')"
alias vrg="nvim --listen godothost ."
alias vrgn="cd ~/Documents/godot4-projects/Top-Down-2D-Game-Tutorial/;nvim --listen /tmp/godothost ."
alias musb="udisksctl mount -b \$(echo /dev/\$(lsblk --list|grep -v -e sda -e croot -e cswap -e chome|fzf|cut -d ' ' -f 1))"
alias gusb="cd /run/media/hunter/"


#TEMPORARY ALIASES
alias vpn_zut="sudo openvpn ~/.config/vpn/wi_zut_vpn.ovpn"
alias rdp_zut="xfreerdp /v:rdp.wi.zut.edu.pl /u:gm32673 /dynamic-resolution"

#COLORS FOR LS AND RANGER
LS_COLORS=$LS_COLORS:'di=1;34'
export LS_COLORS

#FZF
#loads basic key-bindings
source /usr/share/fzf/key-bindings.bash
#enables completion like "cd ~/**<TAB>"
source /usr/share/fzf/completion.bash 

# VI-MODE CLIPBOARD
# Macros to enable yanking, killing and putting to and from the system clipboard in vi-mode. Only supports yanking and killing the whole line.
yank_line_to_clipboard () {
  echo $READLINE_LINE | wl-copy
}

kill_line_to_clipboard () {
  yank_line_to_clipboard
  READLINE_LINE=""
}

bind -m vi-command -x '"YY": yank_line_to_clipboard'
bind -m vi-command -x '"DD": kill_line_to_clipboard'

#PURELINE
if [ "$TERM" != "linux" ]; then
    source ~/MyPrograms/from_git/pureline/pureline ~/.config/pureline/pureline.conf
fi

#[[ ${BLE_VERSION-} ]] && ble-attach

#Starts sway only if logging in using tty1
if [ "$(tty)" = "/dev/tty1" ]; then
    #WLR_RENDERER=vulkan
    #/dev/dri/card0:
    WLR_DRM_DEVICES=/dev/dri/card1
    WLR_DRM_NO_MODIFIERS=1
    light -S 100
    exec sway --unsupported-gpu
elif [ "$(tty)" = "/dev/tty2" ]; then
	exec Hyprland
fi
