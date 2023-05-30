# vim: foldmethod=marker

#export PAGER='less -s'
PATH=$PATH:~/Scripts:/home/$USER/.local/bin
# GLOBAL VARIABLES

export XDG_CONFIG_HOME="$HOME/.config" EDITOR="nvim"

#required for correct bindings to be loaded for fzf (even though it will be set later by my .inputrc)
set -o vi
bind "\eC-H":backward-kill-word
#ALIASES
alias v='nvim'
alias ls='ls --color --group-directories-first'
alias l='ls -lh'
alias ll='l -a'
alias e='exit'
alias r='. ranger'
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
    source ~/Self_compiled/pureline/pureline ~/.pureline.conf
fi

#[[ ${BLE_VERSION-} ]] && ble-attach

#Starts sway only if logging in using tty1
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
