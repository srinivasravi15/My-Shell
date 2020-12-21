#!/bin/bash

__kube_ps1()
{
    # Get current context
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        echo "(k8s: ${CONTEXT})"
    fi
}

.bash_profile

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

NORMAL="\[\033[00m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"

source ~/kube-prompt.sh

export PS1="${BLUE}\W ${GREEN}\u${YELLOW}\$(__kube_ps1)${NORMAL} \$ "
