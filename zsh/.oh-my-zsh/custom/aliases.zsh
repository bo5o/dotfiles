# global aliases
alias -g L='| less'
alias -g C='| wc -l'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

# aliases
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
alias ta="tmux attach -t"
alias tns="tmux new-session -s"
alias tls="tmux list-sessions"
alias pdf="zathura"
alias ipy="ipython"
alias da="cd ~/latex/diplomarbeit"
alias t="todo.sh"
alias Gst="gitcheck"
alias disks='echo "╓───── m o u n t . p o i n t s"; echo "╙────────────────────────────────────── ─ ─ "; lsblk -a; echo ""; echo "╓───── d i s k . u s a g e"; echo "╙────────────────────────────────────── ─ ─ "; df -h;'
alias dotfiles='cd ~/dotfiles'
alias Dotfiles='cd ~/private'
alias info='info --vi-keys'
alias md='mkdir -p -v'
alias pdfgrep='pdfgrep -in'	# ignorecase, page number
cpbak() { cp $1{,.bak} ;} # create backup copy
open() { xdg-open "$@" > /dev/null 2>&1 ;} # open with default GUI program
alias radioeins='mpc load https://www.radioeins.de/live.m3u'
alias news='newsboat'
alias files='ranger'
alias sv='sudo nvim'
alias ka='killall'
alias crep="grep --color=always" # Color grep
alias ccat="highlight --out-format=xterm256" #Color cat
