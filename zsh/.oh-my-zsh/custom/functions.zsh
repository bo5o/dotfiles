wttr()
{
    # change Paris to your default location
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Dresden}"
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

gitcheck() {
    # check all git repositories in specified directories for changes
    checkdirs=( ~/dotfiles ~/private ~/code ~/latex ~/Documents ~/vimwiki ~/sites )
    for d in "${checkdirs[@]}"
    do
        find $d -maxdepth 2 -name "*.git" -type d -exec sh -c '(cd {} && cd .. && if [[ $(git status -s) || $(git cherry) ]]; then printf "### " && git rev-parse --show-toplevel; git status -bs; echo; fi)' \;
    done
}

function email() {
    if [ "$#" -eq 3 ]; then
        echo $3 | neomutt -s $2 $1
    elif [ "$#" -gt 3 ]; then
        echo $3 | neomutt -s $2 -a ${@:4} -- $1
    else
        echo "Usage:";
        echo "\temail recipient subject message [files]"
    fi
}

function pretty() {
    pygmentize -f terminal -g $* | less -R
}
