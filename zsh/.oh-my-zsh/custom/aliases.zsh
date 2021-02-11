#!/usr/bin/env zsh

# global aliases
alias -g L='| less'
alias -g Lc='--color=always | less -r'
alias -g C='| wc -l'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g F='| fzf -m'
alias -g Y='| yank'
alias -g X='| xargs'
alias -g NF='./*(oc[1])'

# suffix aliases
alias -s git="git clone --recurse-submodules"

# personal aliases
alias octave="octave-cli -q"
alias ydl="youtube-dl"
alias yta="youtube-dl -xic"
alias r="ranger"
alias m="ncmpcpp"
alias paper="papis"
alias papo="papis open"
alias papex="papis export --bibtex"
alias papa="papis add"
alias pape="papis edit"
alias sdn="sudo shutdown -h now"
alias def="sdcv"
alias yt="mpsyt"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles"
alias co="/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles"
alias coa="config add"
alias coc="config commit -v"
alias coca="config commit -v -a"
alias cod="config diff"
alias cost="config status"
alias cop="config push"
alias clog="config log --oneline --decorate --graph"
alias clg="config log --stat"
alias Config="/usr/bin/git --git-dir=$HOME/private/.git --work-tree=$HOME/private"
alias Co="/usr/bin/git --git-dir=$HOME/private/.git --work-tree=$HOME/private"
alias Coa="Config add"
alias Coc="Config commit -v"
alias Coca="Config commit -v -a"
alias Cod="Config diff"
alias Cost="Config status"
alias Cop="Config push"
alias Clog="Config log --oneline --decorate --graph"
alias Clg="Config log --stat"
alias rk="run_keybase"
alias Vim="nvim --cmd 'profile start profile.log' --cmd 'profile func *'"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias mutt="neomutt"
alias jc="jupyter console"
alias jce="jupyter console --existing"
alias jn="jupyter notebook"
alias lt="ls -lAht"
alias rm="rm -i"
alias sm="~/bin/syncmail.sh"
alias t="tmux attach || tmux new-session"
alias ta="tmux attach -t"
alias tns="tmux new-session -s"
alias tls="tmux list-sessions"
alias pdf="zathura"
alias ipy="ipython"
alias ipycpu="CUDA_VISIBLE_DEVICES="" ipython"
alias da="cd ~/latex/diplomarbeit"
alias todo="todo.sh"
alias Gst="gitcheck"
alias disks='echo "-- m o u n t . p o i n t s"; lsblk -a; echo ""; echo "-- d i s k . u s a g e"; df -h;'
alias dotfiles='cd ~/dotfiles'
alias Dotfiles='cd ~/private'
alias info='info --vi-keys'
alias md='mkdir -p -v'
alias pdfgrep='pdfgrep -in'	# ignorecase, page number
cpbak() { cp $1{,.bak} ;} # create backup copy
open() { xdg-open "$@" > /dev/null 2>&1 ;} # open with default GUI program
alias radioeins='mpv https://www.radioeins.de/live.m3u'
alias news='newsboat'
alias sv='sudo nvim'
alias ka='killall'
alias crep="grep --color=always" # Color grep
alias help="tldr"
alias h="tldr"
alias wo="workon"
alias pf="pip freeze | sort"
alias pipi="pip install"
alias pipu="pip install -U"
alias pcs="pip-compile && pip-sync"
alias pyinit="touch __init__.py"
alias za="zathura"
alias ncdu="ncdu -rr -x"
compdef so=source
alias so="source"
alias week="date +%V"
alias year="date +%Y"
alias ternimal-anaconda="ternimal length=100 thickness=1,4,1,0,0 radius=6,12 gradient=0:#666600,0.5:#00ff00,1:#003300"
alias ternimal-swarm="ternimal length=200 thickness=0,4,19,0,0"
alias ternimal-rainbow="ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00"
compdef _docker-compose docker-compose
compdef dco=docker-compose
alias pudb=pudb3
alias ffbare='firefox --new-instance -P bare'
alias zshrc='${=EDITOR} ~/.zshrc'
alias vimrc='${=EDITOR} ~/.config/nvim/init.vim'
alias lS='ls -1FSsh'
alias ackpy='ack --ignore-dir .venv --ignore-dir .tools --python'
alias qv='quickvenv'
alias f='fzf'
alias sa='source .venv/bin/activate'
alias .a='source .venv/bin/activate'
alias .d='deactivate'
alias mux='tmuxinator'
alias arst='asdf'
alias lA='ls -A'
alias tiga='tig --all'
alias lg='lazygit'
alias lzd='lazydocker'
alias nh='sudo nethogs'
alias btm='btm -m'
