# Profile file. Runs at login. Enviromental variables are set here.

# Adds ~/.local/bin to PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/intelFPGA_pro/21.4/questa_fse/bin"


# Default programs
export EDITOR="nvim"
export FILE="ranger"
export TERMINAL="kitty"
export BROWSER="firefox"
export VIEWER="sxiv"
export READER="okular"
export PLAYER="mpv"


# Combine bat with man pages for syntax highlighting
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"

# XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Ranger config files
export RANGER_LOAD_DEFAULT_RC=FALSE
export RANGER_DEVICONS_SEPARATOR=" "

# ZSH history 
export HIST_IGNORE_ALL_DUPS=true
export HIST_EXPIRE_DUPS_FIRST=true

# SDCC library
export SDCC_LIB="/home/logan/programs/sdcc/share/sdcc/lib"

# ModelSim License file
export LM_LICENSE_FILE=/home/logan/intelFPGA_pro/21.4/questa_fse/LR-069627_License.dat

# zsh-vi-mode plugin
export ZVM_KEYTIMEOUT=2
export ZVM_VI_HIGHLIGHT_BACKGROUND=gray 
export ZVM_VI_HIGHLIGHT_FOREGROUND=gray 
