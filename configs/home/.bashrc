#export PAGER='less -s'

PATH=$PATH:~/Scripts

export XDG_CONFIG_HOME="$HOME/.config" EDITOR="nvim"
export MOZ_ENABLE_WAYLAND=1

#required for correct bindings to be loaded for fzf (even though it will be set later by my .inputrc)
set -o vi

#ALIASES
alias v='nvim'
alias ls='ls --color --group-directories-first'
alias l='ls -lh'
alias ll='l -a'
alias e='exit'
alias r='ranger'
alias k='kitty --detach'
alias kp="sudo kill \$(ps -A|fzf|awk '{print \$1}')"
alias kkp="sudo kill -s SIGKILL \$(ps -A|fzf|awk '{print \$1}')"

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

#PURELINE
if [ "$TERM" != "linux" ]; then
    source ~/Self_compiled/pureline/pureline ~/.pureline.conf
fi

#Starts sway only if logging in using tty1
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
