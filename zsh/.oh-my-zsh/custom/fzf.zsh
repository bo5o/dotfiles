# fzf related settings
bindkey '^r' fzf-history-widget
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

export FZF_DEFAULT_OPTS='
    --color bw
'

export FZF_DEFAULT_COMMAND='
    ag --hidden --ignore .git -f -g ""
'

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND


