# Like normal z when used with arguments but displays an fzf prompt when
# used without.
j() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}
compctl -U -K _z_zsh_tab_completion j

# Relaunch z with the arguments for the previous command
# as the default input by using zz
jj() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
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

a() {
	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: a [project]

		EOF
        echo "Projects:\n"
        echo "`ls $PROJECT_HOME`"
    else
        DIR="$PROJECT_HOME/$1"
        if [ -d "$DIR" ]; then
            cd $DIR
            if [ -f "$DIR/activate" ]; then
                if (( $# == 1)); then
                    source activate venv
                elif (( $# == 2)); then
                    source activate $2
                fi
            fi
        else
            echo "Project does not exist."
        fi
    fi
}

pycl() {
    find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete
}

function pretty() {
    pygmentize -f terminal -g $* | less -R
}


function quickvenv() {
    pyenv local ${1:-"system"} && \
        python3 -m venv .venv && \
        .venv/bin/python -m pip install -U pip setuptools && \
        .venv/bin/python -m pip install -U pip-tools && \
        echo "ipython\nipdb" > requirements.in && \
        .venv/bin/pip-compile && \
        .venv/bin/pip-sync && \
        source .venv/bin/activate
}

function reproenv() {
    pyenv local > /dev/null 2>&1 && [ -z "$VIRTUAL_ENV" ] && \
        python -m venv --prompt ${PWD##*/} .venv && \
        .venv/bin/python -m pip install -U pip setuptools && \
        .venv/bin/python -m pip install -r requirements.txt && \
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
