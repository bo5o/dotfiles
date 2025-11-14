#!/usr/bin/env zsh

# global aliases
alias -g A='| llm -f - '
alias -g B='| bat'
alias -g Bmd='| bat -l md'
alias -g Bsh='| bat -l sh'
alias -g Bjson='| jq | bat -l json'
alias -g Bhelp='| bat -l help'
alias -g C='| wc -l'
alias -g E='| entr'
alias -g F='| fzf -m'
alias -g G='| rg -i'
alias -g H='| head'
alias -g HH='--help | bat --style=plain -l help'
alias -g J='| jq'
alias -g L='| less'
alias -g NF='./*(oc[1])'
alias -g T='| tail'
alias -g X='| xargs'
alias -g Y='| yq'

# suffix aliases
alias -s git="git clone --recurse-submodules"

# personal aliases
alias .a='source .venv/bin/activate'
alias .d='deactivate'
alias ackpy='ack --ignore-dir .venv --ignore-dir .tools --python'
alias alu='sudo apt update && apt list -u && sudo apt upgrade'
alias arst='mise'
alias boo='ghostty +boo'
alias btm='btm --theme gruvbox'
alias chat='nvim -c "CodeCompanionChat" -c "only"'
alias crep="grep --color=always" # Color grep
alias da="cd ~/latex/diplomarbeit"
alias dbtlm="dbt ls -s state:modified"
alias dbtrm="dbt run -s state:modified"
alias dbttm="dbt test -m state:modified"
alias dcupw='docker compose up --watch'
alias def="sdcv"
alias disks='echo "-- m o u n t . p o i n t s"; lsblk -a; echo ""; echo "-- d i s k . u s a g e"; df -h;'
alias dotfiles='cd ~/dotfiles'
alias Dotfiles='cd ~/private'
alias dots='cd ~/dotfiles'
alias f='fzf'
alias ffbare='firefox --new-instance -P bare'
alias fluff='sqlfluff'
alias gab='git absorb'
alias gg='lazygit'
alias Gst="gitcheck"
alias h="tldr"
alias help="tldr"
alias info='info --vi-keys'
alias ipy="ipython"
alias ipycpu="CUDA_VISIBLE_DEVICES="" ipython"
alias jc="jupyter console"
alias jce="jupyter console --existing"
alias jn="jupyter notebook"
alias ka='killall'
alias lA='ls -A'
alias lg='lazygit'
alias lgb='lazygit branch'
alias lS='ls -1FSsh'
alias lt="ls -lAht"
alias lvim='NVIM_APPNAME=nvim-lazy nvim'
alias lzd='lazydocker'
alias m="ncmpcpp"
alias md='mkdir -p -v'
alias mutt="neomutt"
alias mux='tmuxinator'
alias ncdu="ncdu -rr -x"
alias news='newsboat'
alias nh='sudo nethogs'
alias octave="octave-cli -q"
alias papa="papis add"
alias pape="papis edit"
alias paper="papis"
alias papex="papis export --bibtex"
alias papo="papis open"
alias pdf="zathura"
alias pdfgrep='pdfgrep -in'	# ignorecase, page number
alias pipc='uv pip compile requirements.in -o requirements.txt'
alias pipf="pip freeze | sort"
alias pipi="pip install"
alias pipls="pip list"
alias piplso="pip list --outdated"
alias pips='uv pip sync requirements.txt'
alias pipu="pip install -U"
alias pipup="pipc && pips"
alias pudb="pudb3"
alias pyinit="touch __init__.py"
alias qv='quickvenv'
alias r="yazi"
alias radioeins='mpv https://www.radioeins.de/live.m3u'
alias rm="rm -i"
alias sa='source .venv/bin/activate'
alias sdn="sudo shutdown -h now"
alias sm="~/bin/syncmail.sh"
alias spot="ncspot"
alias stow='stow -v'
alias t="tmux attach || tmux new-session"
alias ta="tmux attach -t"
alias ternimal-anaconda="ternimal length=100 thickness=1,4,1,0,0 radius=6,12 gradient=0:#666600,0.5:#00ff00,1:#003300"
alias ternimal-rainbow="ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00"
alias ternimal-swarm="ternimal length=200 thickness=0,4,19,0,0"
alias tig='lazygit log'
alias tls="tmux list-sessions"
alias tns="tmux new-session -s"
alias todo="todo.sh"
alias uvad='uv add --dev'
alias v="nvim"
alias vec="vectorcode"
alias vi="nvim"
alias vim="nvim"
alias vimprofile="nvim --cmd 'profile start profile.log' --cmd 'profile func *'"
alias vimrc='${=EDITOR} ~/.config/nvim/init.vim'
alias week="date +%V"
alias wo="workon"
alias ydl="yt-dlp"
alias year="date +%Y"
alias yt="yt"
alias yta="yt-dlp -xic"
alias za="zathura"
alias zj='zellij'
alias zshrc='${=EDITOR} ~/.zshrc'

# short functions
cpbak() { cp $1{,.bak} ;} # create backup copy
open() { xdg-open "$@" > /dev/null 2>&1 ;} # open with default GUI program
