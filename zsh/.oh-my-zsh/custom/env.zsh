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
export GPG_TTY=$TTY
export SDCV_PAGER="less"
export BROWSER="firefox"
export PROJECT_HOME="$HOME/projects"
export PYTHONBREAKPOINT="ipdb.set_trace"
export VI_MODE_SET_CURSOR=true
export XDG_DATA_HOME="$HOME/.local/share"
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export RESTIC_REPOSITORY="sftp:storagebox:backup/$(hostname)"
export RESTIC_PASSWORD_COMMAND="pass restic/$(hostname)/RESTIC_PASSWORD"
export NEOVIM_CONTEXT="home"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
