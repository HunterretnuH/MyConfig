#export PAGER='less -s'

PATH=$PATH:~/bin/

export XDG_CONFIG_HOME="$HOME/.config" EDITOR="nvim"

#required for correct bindings to be loaded for fzf (even though it will be set later by my .inputrc)
set -o vi
#loads basic key-bindings
source /usr/share/fzf/key-bindings.bash
#enables completion like "cd ~/**<TAB>"
source /usr/share/fzf/completion.bash 

alias v='nvim'
alias ls='ls --color --group-directories-first'
alias l='ls -lh'
alias ll='l -a'
alias e='exit'
alias r='ranger'
alias k='kitty --detach'
alias kp="sudo kill \$(ps -A|fzf|awk '{print \$1}')"
alias kkp="sudo kill -s SIGKILL \$(ps -A|fzf|awk '{print \$1}')"


LS_COLORS=$LS_COLORS:'di=1;4;34'
export LS_COLORS

#PURELINE
if [ "$TERM" != "linux" ]; then
    source ~/git/3rd_party/pureline/pureline ~/.pureline.conf
fi

#Starts sway only if logging in using tty1
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
