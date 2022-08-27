zvm_after_init_commands+=('source $PLUGINS_DIR/fzf-tab-git/fzf-tab.plugin.zsh')
zvm_after_init_commands+=('export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK')
zvm_after_init_commands+=('export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK')
zvm_after_init_commands+=('export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE')
# The plugin will auto execute this zvm_after_select_vi_mode function
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
      $ZVM_MODE_NORMAL)
          PROMPT="%{$fg[yellow]%}[N] %{$fg[blue]%}%2~ %{$fg[red]%}❭%{$fg[yellow]%}❭%{$fg[green]%}❭%{$reset_color%}%b ";;
      $ZVM_MODE_INSERT)
          PROMPT="%{$fg[yellow]%}[I] %{$fg[blue]%}%2~ %{$fg[red]%}❭%{$fg[yellow]%}❭%{$fg[green]%}❭%{$reset_color%}%b ";;
      $ZVM_MODE_VISUAL)
          PROMPT="%{$fg[yellow]%}[v] %{$fg[blue]%}%2~ %{$fg[red]%}❭%{$fg[yellow]%}❭%{$fg[green]%}❭%{$reset_color%}%b ";;
      $ZVM_MODE_VISUAL_LINE)
          PROMPT="%{$fg[yellow]%}[V] %{$fg[blue]%}%2~ %{$fg[red]%}❭%{$fg[yellow]%}❭%{$fg[green]%}❭%{$reset_color%}%b ";;
      $ZVM_MODE_REPLACE)
        PROMPT="%{$fg[yellow]%}[R] %{$fg[blue]%}%2~ %{$fg[red]%}❭%{$fg[yellow]%}❭%{$fg[green]%}❭%{$reset_color%}%b ";;
  esac
}
