#!/usr/bin/env zsh

# https://github.com/junegunn/fzf/wiki/examples#z
# Like normal z when used with arguments but displays an fzf prompt when
# used without.
j() {
  if [[ -z "$*" ]]; then
    cd "$(zshz -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    zshz "$@"
  fi
}

# Relaunch z with the arguments for the previous command
# as the default input by using zz
jj() {
  cd "$(zshz -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=("$(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fsw - switch to git branch
fsw() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git switch $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

wetter()
{
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Berlin}"
}

md2pdf() {
	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: md2pdf [file]

		EOF
    else
    FILE=$1;
    pandoc --template=default --filter pandoc-citeproc -V colorlinks -V papersize:a4 $1 -o ${file%%.*}.pdf
	fi

}

doi2bib() {
    echo >> bib.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> bib.bib;
    echo >> bib.bib;
}

www() {
	if (( $# == 0 )); then
        w3m https://duckduckgo.com/lite
    else
        w3m $1
	fi
}

pycl() {
    find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete
}

function mkvenv() {
    # shellcheck disable=SC1091
    asdf local python "${1:-3.7.7}" && \
        python3 -m pip install -U virtualenv && \
        python3 -m virtualenv --prompt="(${PWD##*/}) " .venv && \
        .venv/bin/python -m pip install -U pip setuptools pip-tools && \
        source .venv/bin/activate
}

addreq() {
	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: addreq package1 [package2 [package3 [...]]]

            Add entries to `requirements.in`.

		EOF
    else
        for pkg in "$@"
        do
            echo "$pkg" >> requirements.in
        done
    fi
}

vimwiki () {
    if [[ $# == 0 ]]
    then
        nvim +'VimwikiIndex'
    elif [[ $1 == 'git' ]]
    then
        git -C ~/vimwiki/ ${@:2}
    else
        echo 'Usage: vimwiki [git] [args ...]'
    fi
}
