# Enable colors and change prompt:
autoload -U colors && colors

# Version control info
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'

setopt interactivecomments

# History
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

export PLUGINS_DIR="$XDG_CONFIG_HOME/zsh/plugins"
# Theme
setopt PROMPT_SUBST
source $PLUGINS_DIR/ohmyzsh/themes/robbyrussell.zsh-theme
# Plugins
source $PLUGINS_DIR/ohmyzsh/lib/functions.zsh
source $PLUGINS_DIR/ohmyzsh/plugins/urltools/urltools.plugin.zsh
source $PLUGINS_DIR/ohmyzsh/plugins/web-search/web-search.plugin.zsh
source $PLUGINS_DIR/fzf-tab/fzf-tab.plugin.zsh
source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh # Not maintained anymore
source $PLUGINS_DIR/zsh-256color/zsh-256color.plugin.zsh
source $PLUGINS_DIR/zsh-autopair/zsh-autopair.plugin.zsh
source $PLUGINS_DIR/fzf/shell/key-bindings.zsh
source $PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Source some files to set aliases, functions, keys, and environment variables
[ -f "$XDG_CONFIG_HOME/zsh/zsh_aliases"    ] && source "$XDG_CONFIG_HOME/zsh/zsh_aliases"
[ -f "$XDG_CONFIG_HOME/zsh/zsh_functions"  ] && source "$XDG_CONFIG_HOME/zsh/zsh_functions"
[ -f "$XDG_CONFIG_HOME/zsh/zsh_keys"       ] && source "$XDG_CONFIG_HOME/zsh/zsh_keys"
