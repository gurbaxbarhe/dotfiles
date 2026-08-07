PROMPT="%(?:%{$fg_bold[blue]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )"
PROMPT+='%{$fg_bold[red]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}git:(%B%F{#ffab70}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[magenta]%}) %{$fg_bold[blue]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[magenta]%})"
