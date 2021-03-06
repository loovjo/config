#!/bin/zsh

if [ -d /opt/homebrew ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

export ARCHFLAGS='-arch arm64'

autoload -Uz compinit && compinit -u

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/Sage"
export PATH="/Applications/j901/bin:$PATH"
export PATH="$HOME/Documents/SelfCompile/binary-links:$PATH"
export PATH="$HOME/selfcompile-big/binary-links:$PATH"
export PATH="/Applications/ARM/bin:$PATH"

alias lsa="ls -Ga"
alias ls="ls -G"
alias bashcols="python3 ~/Documents/Projekt/Programmering/Python/BashCols.py"
alias bashcurmov="python3 ~/Documents/Projekt/Programmering/Python/Bashcurmoves.py"
alias objdump="objdump -M intel"
alias atsc="patscc -cleanaft -DATS_MEMALLOC_LIBC"
alias i2="idris2"
alias py="python"
alias ipy="ipython"
alias c="cargo"
alias bqn="rlwrap BQN"

_BLUE="\033[38;5;4m"
_GREEN="\033[38;5;2m"
_RED="\033[38;5;1m"
_RESET="\033[0m"
function activate {
    (
        cd ~/Documents/Projekt
        F=$( fd '' -t d -d 4 . | fzf -1 -q "$1" ) || return
        LINKEE=$(realpath "$F")
        DEFAULT_NAME=$(basename "$LINKEE")
        LINK="${2:-${DEFAULT_NAME}}"
        cd ~/Documents/A-Aktivta
        if [[ -d "$LINK" ]] then
            echo "Project ${_BLUE}$LINK${_RESET} already exists!"
        else
            echo "${_BLUE}$LINK${_RESET} -> ${_BLUE}$LINKEE${_RESET} has been ${_GREEN}activated${_RESET}"
            ln -s "$LINKEE" "$LINK"
        fi
    )
    _check_proj_count
}

function _check_proj_count {
    (
        cd ~/Documents/A-Aktivta
        N_FILES=$(ls | wc -l | tr -d ' ')
        if [[ $N_FILES > 4 ]] then
            echo "You have $_RED$N_FILES$_RESET active projets. Consider deactivating some"
        fi
    )
}

function deactivate {
    (
        cd ~/Documents/A-Aktivta
        F=$( fd '' -t l -d 1 . | fzf -1 -q "$1" ) || return
        rm "$F"
        echo "Deactivated $_BLUE$F$RESET"
    )
    _check_proj_count
}

function project {
    pushd >/dev/null
    cd ~/Documents/A-Aktivta
    PROJ_NAME=$( fd '' -t l -d 1 . | fzf -1 -q "$1" ) || { popd >/dev/null ; return }
    F=$(realpath "$PROJ_NAME")

    echo "In $_BLUE${PROJ_NAME}$_RESET"
    cd "$F"
    _check_proj_count
}

alias p=project

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
PATH="$HOME/.ghcup/bin/:${PATH}"
export PATH

export PATH="$HOME/Documents/Commands/:$PATH"

setopt prompt_subst

# Powerline symbols: 
export PROMPT='$(
    echo -en "%{\033[0m\033[38;5;0m\033[48;5;172m%} [";
    if [ -f ~/Documents/Projekt/Programmering/Rust/unambig-path/target/release/unambig-path ] ; then
        ~/Documents/Projekt/Programmering/Rust/unambig-path/target/release/unambig-path
    else
        pwd | tr -d "\n"
    fi
    echo -en "] %T ";
    if [ "$CONDA_DEFAULT_ENV" != "base" ] ; then
        echo -en "%{\033[0m\033[38;5;172m\033[48;5;28m%}%{\033[0m\033[38;5;0m\033[48;5;28m%} 🐍 $CONDA_DEFAULT_ENV %{\033[0m\033[38:5:28m%}";
    else
        echo -en "%{\033[0m\033[38:5:172m%}"
    fi
    echo -en "%{\033[0m%} ";
)'

export RPROMPT='%(?.%F{green}√.%?%F{red}?)%f'

# Save a lot of history
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

setopt appendhistory
setopt incappendhistory
setopt sharehistory

# Right cmd -> shift
# Right shift -> Alt
# Right alt -> cmd
# Key value or'd with 0x700000000
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html

source "$HOME/Documents/kblayouts/keybind.sh"

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# Stack
export PATH="/Users/jonathanloov/.local/bin:$PATH"

# OpenJDK 1.8
export JAVA_HOME=$(/usr/libexec/java_home -v 11.0.11)
# export PATH="/usr/local/opt/binutils/bin:$PATH"

# source /Users/jonathanloov/.config/broot/launcher/bash/br

# tmux stuff

function setwd {
    tmux command-prompt -I "attach -c $(pwd)"
}

export PATH="/Users/jonathanloov/Documents/configs/tmux/:$PATH"

[ -f "/Users/jonathanloov/.ghcup/env" ] && source "/Users/jonathanloov/.ghcup/env" # ghcup-env
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="/Applications/Racket v8.2/bin:$PATH"
export C_INCLUDE_PATH="/Applications/Racket v8.2/include:$C_INCLUDE_PATH"
export LD_LIBRARY_PATH="/Applications/Racket v8.2/lib:$LD_LIBRARY_PATH"

export C_INCLUDE_PATH="/opt/homebrew/include/:$C_INCLUDE_PATH"
export LD_LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jonathanloov/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jonathanloov/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/jonathanloov/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jonathanloov/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/bison/lib"

[ -f "/Users/jonathanloov/.ghcup/env" ] && source "/Users/jonathanloov/.ghcup/env" # ghcup-env
source ~/.zshrc.local
