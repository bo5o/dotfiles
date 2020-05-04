#!/usr/bin/env zsh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERMINAL="/usr/local/bin/st"
export MANPATH="/usr/local/texlive/2017/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2017/texmf-dist/doc/info:$INFOPATH"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export GPG_TTY=$(tty)
export SDCV_PAGER="less"
export BROWSER="firefox"
export PROJECT_HOME="$HOME/projects"
export PYTHONBREAKPOINT="ipdb.set_trace"
