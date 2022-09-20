zvm_after_init_commands+=('source $PLUGINS_DIR/fzf-tab-git/fzf-tab.plugin.zsh')
zvm_after_init_commands+=('export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK')
zvm_after_init_commands+=('export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK')
zvm_after_init_commands+=('export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE')
# The plugin will auto execute this zvm_after_select_vi_mode function
function zvm_after_select_vi_mode() {
    PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
    PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
}

