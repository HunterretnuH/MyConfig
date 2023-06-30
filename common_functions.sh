#!/bin/bash
# vi: foldmethod=marker foldmarker=#{,#} nowrap

# $1 - pass $BASH_SOURCE. Required to print correct file name in error message.
SOURCE=$1
trap error ERR

#{ FUNCTIONS

    function error() { #{
        RESULT=$?
        echo -e "[FILE: \"${SOURCE}\" LINE: \"${BASH_LINENO[0]}\"] \033[31;1mFail! Error code: $RESULT\033[0m"
        exit 1
    } #}

    function press_to_continue() { #{
        read -n 1 -p "\nPress enter to continue... (Esc to cancel)" CONFIRM && if [[ "$CONFIRM" == "" ]]; then exit 1; fi
    } #}

    function section() { #{
    # $1 - message
        MSG=$1
        echo -e "\033[32;1mSuccess!\033[0m"
        if [ -z $AUTO_CONTINUE ]; then press_to_continue; fi
        if [ -z $IS_IT_FIRST_MESSAGE ]; then echo -e "$msg"; fi
        IS_IT_FIRST_MESSAGE=FALSE
    } #}

#} FUNCTIONS



