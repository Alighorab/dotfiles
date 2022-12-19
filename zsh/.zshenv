# Profile file. Runs at login. Enviromental variables are set here.

# Adds ~/.local/bin to PATH
export PATH="$PATH:$HOME/.local/bin"


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

# zsh-vi-mode plugin
export ZVM_KEYTIMEOUT=2
export ZVM_VI_HIGHLIGHT_BACKGROUND=gray 
export ZVM_VI_HIGHLIGHT_FOREGROUND=gray 

# Rust
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$GEM_HOME/bin:$HOME/.cargo/bin:$PATH"

# # GPU
# export DRI_PRIME=1
# export LIBVA_DRIVER_NAME=radeonsi
# export VDPAU_DRIVER=radeonsi

# Go
export PATH="$PATH:$HOME/go/bin/"

# catppuccin
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
