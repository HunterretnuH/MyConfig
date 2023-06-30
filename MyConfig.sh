#!/bin/sh
# vi: foldmethod=marker foldmarker=#{,#}
#

#{ FUNCTIONS

    source ./lib/common_functions.sh $BASH_SOURCE

    function print_help() { #{
        echo -e "MyConfig.sh -(heiI) <device>\n" 
        echo -e "Description: Simple utility to import and export config files and install programs."
        echo -e "             NOTE: <device> is required if \$MY_DEVICE is not set. <device> is directory name inside ./devices/ directory\n"
        echo -e "Options:"
        echo -e "    -h, --help     - prints help message."
        echo -e "    -e, --export   - copies files and directories to home directory from user home folder."
        echo -e "    -i, --import   - copies files and directories from <device>/home to user home directory."
        echo -e "    -I, --install  - installs programs\n"
        echo -e "General MyConfig.sh structure:\n"
        echo -e "    if [ -z \$VARIABLE ]; then      # Variable from device config file. Program is disabled if it's empty or not set."
        echo -e "        install <program_name>     # Program to be installed. Requires setting INSTALL_COMMAND variable in conf.sh file."
        echo -e "        file <file_path>           # File to be imported/exported. Path is relative to /home/$USER directory."
        echo -e "        dir <dir_path>             # Directory to be imported/exported. Don't add \/ at the end."
        echo -e "    fi\n"
        echo -e "    NOTE: <file_path> and <dir_path> are relative to /home/$USER.\n"
        echo -e "General directory structure:\n"
        echo -e "    ./devices/<device>             - path to device"
        echo -e "    ./devices/<device>/conf.sh     - path to device config file"
        echo -e "    ./devices/<device>/home        - path to home folder, where files and dirs are stored"
    } #}

    function program() { #{
    # $1 - program name
        if [ -n "$INSTALL" ]; then
            $INSTALL_COMMAND $1
        fi
    } #}

    function file() { #{
        # $1 - path to dir or file (relative to USER_HOME_DIR)
        # $2 - "TRUE" if $1 is directory
        FS_NODE=$1
        IS_DIR=$2
        LOCAL_FS_NODE="./devices/$DEVICE/home/$FS_NODE"
        REMOTE_FS_NODE="$USER_HOME_DIR/$FS_NODE"

        if [ -n "$EXPORT" ]; then
            echo "Exporting ~/$FS_NODE"

            if [ -e $LOCAL_FS_NODE ]; then
                if [[ "$IS_DIR" == "TRUE" ]]; then REMOTE_FS_NODE=$(dirname $REMOTE_FS_NODE); fi
                mkdir -p $(dirname $REMOTE_FS_NODE)
                cp -r $LOCAL_FS_NODE $REMOTE_FS_NODE
            else
                echo "Error: Path $LOCAL_FS_NODE not found. Skipped during export."
            fi

        elif [ -n "$IMPORT" ]; then
            echo "Importing ~/$FS_NODE"

            if [ -e $REMOTE_FS_NODE ]; then
                if [[ "$IS_DIR" == "TRUE" ]]; then LOCAL_FS_NODE=$(dirname $LOCAL_FS_NODE); fi
                mkdir -p $(dirname $LOCAL_FS_NODE)
                mkdir -p $(dirname $LOCAL_FS_NODE)
                cp -r $REMOTE_FS_NODE $LOCAL_FS_NODE
            else
                echo "Error: Path $REMOTE_FS_NODE not found. Skipped during import."
            fi
        fi
    } #}

    function dir() { #{
        file $1 "TRUE"
    } #}

    function initialize_globals() { #{
        # usage: initialize_globals $@

        FLAG=$1
        DEVICE=${2:-$MY_DEVICE}

        EXPORT=""
        IMPORT=""
        INSTALL=""

        if   [[ "$FLAG" == "-e" || $FLAG == "--export"  ]]; then
            EXPORT=TRUE
        elif [[ "$FLAG" == "-i" || $FLAG == "--import"  ]]; then
            IMPORT=TRUE
        elif [[ "$FLAG" == "-I" || $FLAG == "--install" ]]; then
            INSTALL=TRUE
        elif [[ "$FLAG" == "-h" || $FLAG == "--help"    ]]; then
            print_help; exit 0 
        else
            print_help; exit 1
        fi

        if [ $# -gt 2 ]; then
            echo "Error: Too many arguments were used."
            exit 1
        fi

        if [ -z "$DEVICE" ]; then
            echo "Error: MY_DEVICE is not set and <device> was not provided."
            exit 1
        fi

        if [ -n "$INSTALL" ]; then
            if [ -z "$INSTALL_COMMAND" ]; then
                echo "INSTALL_COMMAND is not set."
                exit 1
            fi
        fi

        USER_HOME_DIR="/home/$USER"

        if   [ -n "$IMPORT" ]; then
            #Create directory and configuration file for device if it doesn't exist
            if [ ! -d ./devices/$DEVICE ]; then 
                mkdir -p ./devices/$DEVICE/home
                cp  conf.sh.template ./devices/$DEVICE/conf.sh
            fi
        elif [ -n "$EXPORT" ]; then
            #Create user home folder if it does not exist
            mkdir -p $USER_HOME_DIR
        fi

        source ./devices/$DEVICE/conf.sh
    } #}

#}

#{ CONFIGS TO IMPORT/EXPORT

    # Set quit on error
    set -e
    trap error ERR

    initialize_globals $@

    if [ -n "$BASH" ]; then
        file .bashrc                                    # Config
    fi

    if [ -n "$READLINE" ]; then
        file .inputrc                                   # Config
    fi


    if [ -n "$SWAY" ]; then
        program sway
        file .config/sway/config            # Config
        file .config/sway/autostart         # Config - autostart  (NWG managed)
        file .config/sway/keyboard          # Config - keyboard   (NWG managed)
        file .config/sway/outputs           # Config - outputs    (NWG managed)
        file .config/sway/pointer           # Config - pointer    (NWG managed)
        file .config/sway/touchpad          # Config - touchpad   (NWG managed)
        file .config/sway/variables         # Config - variables  (NWG managed)
        file .config/sway/workspaces        # Config - workspaces (NWG managed)
    fi

    if [ -n "$HYPRLAND" ]; then
        file .config/hypr/hyprland.conf     # Config
        file .config/hypr/includes.conf     # Config - additional settings  (NWG managed)
        file .config/hypr/monitors.conf     # Config - monitors (outputs)   (NWG managed)
        file .config/hypr/workspaces.conf   # Config - workspaces           (NWG managed)
    fi

    if [ -n "$NWGSHELL" ]; then
        file .config/azote/azoterc                             # Background config               (NWG managed)

        file .config/foot/foot.ini                             # Update terminal config          (NWG managed)

        file .config/nwg-bar/MySwayQuit.css                    # Sway quit menu .css files       (NWG managed defaults?)
        file .config/nwg-bar/MyHyprlandQuit.css                # Hyprland quit menu .css files   (NWG managed defaults?)

        file .config/nwg-dock/MySwayDock.css                   # Sway dock .css files            (NWG managed defaults?)
        file .config/nwg-dock-hyprland/MyHyprlandDock.css      # Hyprland dock .css files        (NWG managed defaults?)

        file .config/nwg-drawer/MySwayDrawer.css               # Sway drawer .css files          (NWG managed defaults?)
        file .config/nwg-drawer/MyHyprlandDrawer.css           # Hyprland drawer .css files      (NWG managed defaults?)

        file .config/nwg-panel/MySwayPanel                     # Sway nwg-panel settings         (NWG managed)
        file .config/nwg-panel/MySwayPanel.css                 # Sway nwg-panel .css file        (NWG managed defaults?)
        file .config/nwg-panel/MyHyprlandPanel                 # Hyprland nwg-panel settings     (NWG managed)
        file .config/nwg-panel/MyHyprlandPanel.css             # Hyprland nwg-panel .css file    (NWG managed defaults?)

        file .local/share/nwg-shell-config/custom              # Sway NWG Shell config for Sway       (NWG managed)
        file .local/share/nwg-shell-config/settings            # Sway NWG Shell settings for Sway      (NWG managed)
        file .local/share/nwg-shell-config/help.pango          # Sway help file                  (NWG managed)
        file .local/share/nwg-shell-config/custom-hyprland     # Hyprland NWG Shell config for Hyprland   (NWG managed)
        file .local/share/nwg-shell-config/settings-hyprland   # Hyprland NWG Shell settings for Hyprland (NWG managed)
        file .local/share/nwg-shell-config/help-hyprland.pango # Hyprland help file              (NWG managed)

        file .local/share/nwg-look/gsettings                   # GTK programs appereance         (NWG managed)

        file .config/swaync/config.json                        # notification manager config     (NWG managed)
        file .config/swaync/style.css                          # notification manager .css file  (NWG managed defaults?)

       #file .config/nwg-displays/config                       # nwg-displays config             (NWG managed)
       #file .config/nwg-look/config                           # nwg-look config                 (NWG managed)
       #dir .config/gtklock/                                   # lock screen .css files          (NWG managed defaults?)
    fi

    if [ -n "$KITTY" ]; then
        program kitty
        file .config/kitty/kitty.conf                   # Config
        dir  .config/kitty/sessions/                    # Sessions config
        file .local/share/applications/kitty.desktop    # Modified kitty.desktop
        file .local/bin/kitty                           # Script which replaces kitty bin
    fi

    if [ -n "$NEOVIM" ]; then
        program neovim
        file .config/nvim/init.vim                      # Config
        file .config/nvim/after/ftplugin/html.vim       # Html FTPlugin
        file .config/nvim/coc-settings.json             # Coc-nvim LSP settings
        file .config/nvim/lua/coc-init.lua              # Coc-nvim init script
    fi

    if [ -n "$RANGER" ]; then
        program ranger
        file .config/ranger/rc.conf ~/.config/ranger/   # Config
        file .config/ranger/rifle.conf                  # Config of default programs used to open files 
        echo -e "\tWARNING: File .config/ranger/rifle.conf can change with updates."
        file .local/share/ranger/bookmarks              # Bookmarks
    fi

    if [ -n "$ZATHURA" ]; then
        program zathura
        dir .config/zathura
    fi

    #TODO: MyConfig should add below line to .bashrc if it ist'nt already there:
    #      $MY_DEVICE=<device_name>
    #Configs to add: .pufeline.conf, mpv.conf

#}
