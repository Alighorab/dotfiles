# Enable colors and change prompt:
autoload -U colors && colors
# Version control info
autoload -Uz vcs_info
precmd() { vcs_info }
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=10000000
SAVEHIST=10000000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
export KEYTIMEOUT=1

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

export PLUGINS_DIR="$HOME/.config/zsh/plugins"

# Plugins
source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 
source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $PLUGINS_DIR/zsh-256color/zsh-256color.plugin.zsh
source $PLUGINS_DIR/dirhistory/dirhistory.plugin.zsh
source $PLUGINS_DIR/git/git.zsh
source $PLUGINS_DIR/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $PLUGINS_DIR/zsh-vi-mode/config.zsh
zvm_after_init_commands+=('source $PLUGINS_DIR/zsh-autopair/zsh-autopair.plugin.zsh')
zvm_after_init_commands+=('source $PLUGINS_DIR/fzf-key-bindings/key-bindings.zsh')

# Source some files to set aliases, functions, keys, and environment variables
[ -f "$HOME/.config/zsh/zsh_aliases"    ] && source "$HOME/.config/zsh/zsh_aliases"
[ -f "$HOME/.config/zsh/zsh_functions"  ] && source "$HOME/.config/zsh/zsh_functions"
[ -f "$HOME/.config/zsh/zsh_keys"       ] && source "$HOME/.config/zsh/zsh_keys"
