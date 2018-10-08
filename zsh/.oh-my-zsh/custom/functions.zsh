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

function pretty() {
    pygmentize -f terminal -g $* | less -R
}
