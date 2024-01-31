################################# BASH CONFIG ##################################

#####################    GLOBAL VARIABLES    #####################
#--1 GENERAL            - PATH, editor, screenshot dir, qt theme platform
    PATH=/home/$USER/.local/bin/MyPrograms:/home/$USER/.local/bin/:/home/$USER/MyScripts:$PATH
    export EDITOR="nvim"
    export SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
    export QT_QPA_PLATFORMTHEME=qt5ct
	export XDG_CONFIG_HOME="$HOME/.config"

#--1 XDG                - xdg config_home
    export XDG_CONFIG_HOME="$HOME/.config" 

#--1 APP SPECIFIC       - ls colors, golang, firefox
    # COLORS FOR RANGER, LS AND FD
    export LS_COLORS=$LS_COLORS:'di=1;34'   # colors used by i.e. ls, ranger, fd

    # GOLANG
    export GOPATH="/home/$USER/MyPrograms/go"

    # FIREFOX
    export MOZ_ENABLE_WAYLAND=1

#++#++#++#++#++#++#++# END OF GLOBAL VARIABLES #++#++#++#++#++#++#++#

#####################    ALIASES    #####################
    #--1 LS
    alias ls='ls --color=always --group-directories-first'
    alias l='ls -lh'
    alias ll='l -a'

    #--1 APPS
    alias v='nvim'
    alias k='kitty --detach --session none'
	alias ranger='source ranger ranger' # Allows both CD on exit and passing args to work
    alias r='ranger'
    alias e='exit'

    #--1 CD
    alias cdd="cd ~/Desktop"
    alias cdp="cd -P ."

    #--1 CP
    alias rcp="rsync -ah --progress"

    #--1 KILL
    alias kp="sudo kill \$(ps -A|fzf|awk '{print \$1}')"
    alias kkp="sudo kill -s SIGKILL \$(ps -A|fzf|awk '{print \$1}')"

    #--1 GIT
    alias ga='git add'
    alias gaa='git add -A'
    alias gau='git add -u'
    alias gb='git branch'
    alias gc='git checkout'
    alias gC='git commit'
    alias gcp='git cherry-pick'
    alias gd='git diff'
    alias gf='git fetch'
    alias gl='git log'
    alias gp='git pull'
    alias gP='git push'
    alias gr='git reset'
    alias grh='gr --hard'
    alias grhm='gr --hard master'
    alias grhom='gr --hard origin/master'
    alias gs='git status'
    alias gsu='git submodule update'
    alias gsui='git submodule update --init'

    #--1 OTHER
    print_ascii() {
        OUTPUT=""
        for i in {32..127}
        do
            INT=$(printf "%3d" $i)
            HEX=$(printf "%02X" $i)
            BIN=$(printf "%08d\n" $(echo "obase=2; $i" | bc))
            CHAR=$(awk "BEGIN{printf \"%c\", $i}")
            if [[ "$CHAR" == "\\" ]]; then CHAR="\\\\"; fi
            OUTPUT="$OUTPUT $INT $BIN $HEX $CHAR\n"
        done
        echo -e "$OUTPUT" |pr --columns=3 -l 37 -t
        }

    alias ascii='print_ascii'
	
	#Cleaning repo
	function clean_repo	{
    git reset --hard --recurse-submodule -q &&
    git submodule sync --recursive &&
    git submodule update --init --force --recursive &&
    git clean -ffdx &&
    git submodule foreach --recursive git clean -ffxd
	}

    #--1 Consider removing
    alias vrg="nvim --listen godothost ."
    alias vrgn="cd ~/Documents/godot4-projects/Top-Down-2D-Game-Tutorial/;nvim --listen /tmp/godothost ."
    alias musb="udisksctl mount -b \$(echo /dev/\$(lsblk --list|grep -v -e nvme -e cryptlvm -e MyVolGroup|fzf|cut -d ' ' -f 1))"
    alias gusb="cd /run/media/hunter/"
    #alias vpn_zut="sudo openvpn ~/.config/vpn/wi_zut_vpn.ovpn"
    #alias rdp_zut="xfreerdp /v:rdp.wi.zut.edu.pl /u:gm32673 /dynamic-resolution"

#++#++#++#++#++#++#++# END OF ALIASES #++#++#++#++#++#++#++#

#####################    OTHERS    #####################
#--1 POWERLINE                      - pureline
    if [ "$TERM" != "linux" ]; then
        source ~/MyPrograms/from_git/pureline/pureline ~/.config/pureline/pureline.conf
    fi

#--1 FUZZY FINDER                   - fzf
    set -o vi   #required for correct bindings to be loaded by fzf (duplicate - .inpurc)
    source /usr/share/fzf/key-bindings.bash #loads basic key-bindings
    source /usr/share/fzf/completion.bash   #enables completion like "cd ~/**<TAB>"

#--1 VI-MODE CLIPBOARD              - yank or cut whole lines to system clipboard in bash vi-mode. 
    yank_line () { echo $READLINE_LINE | wl-copy; }
    cut_line () { yank_line; READLINE_LINE=""; }

    bind -m vi-command -x '"YY": yank_line_to_clipboard'
    bind -m vi-command -x '"DD": cut_line_to_clipboard'

#--1 COMPOSITOR CONFIG AND START    - sway, hyprland
    if [ "$(tty)" = "/dev/tty1" ]; then
        startx
    elif [ "$(tty)" = "/dev/tty2" ]; then
        exec Hyprland
    elif [ "$(tty)" = "/dev/tty3" ]; then
        #WLR_DRM_DEVICES=/dev/dri/card1
        #light -S 100
        exec sway
        # --unsupported-gpu
    fi

#++#++#++#++#++#++#++# END OF OTHERS #++#++#++#++#++#++#++#

# vim: foldmethod=marker foldmarker=#--,#++
