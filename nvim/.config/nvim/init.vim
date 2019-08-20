""Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'            " nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'    " nerd tree git integration
Plug 'ncm2/ncm2'                      " auto completion
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'              " complete words from current buffer
Plug 'ncm2/ncm2-tmux'                 " complete words from tmux panes
Plug 'ncm2/ncm2-path'                 " complete file paths
Plug 'ncm2/ncm2-jedi'                 " python completion source
Plug 'ncm2/ncm2-ultisnips'            " snippet completion source
Plug 'ncm2/ncm2-markdown-subscope'    " fenced code block detection in markdown
Plug 'ncm2/float-preview.nvim'        " nvim 0.4 floating window support
Plug 'machakann/vim-swap'             " swap items in comma separated lists
Plug 'Vigemus/iron.nvim'              " REPL
Plug 'terryma/vim-multiple-cursors'   " multiple cursors
Plug 'yggdroot/indentline'            " indentation guides
Plug 'davidhalter/jedi-vim'           " python jedi
Plug 'vimwiki/vimwiki'                " wiki
Plug 'w0rp/ale'                       " asynchronous linting engine
Plug 'cespare/vim-toml'               " toml
Plug 'plasticboy/vim-markdown'        " markdown
Plug 'tpope/vim-surround'             " vim surround
Plug 'tpope/vim-commentary'           " comment stuff out
Plug 'tpope/vim-repeat'               " repeat almost anything
Plug 'tpope/vim-fugitive'             " git
Plug 'airblade/vim-gitgutter'         " git diff in gutter
Plug 'junegunn/gv.vim'                " git commit browser
Plug 'lervag/vimtex'                  " LaTeX
Plug 'ervandew/supertab'              " Use tab for autocompletion
Plug 'SirVer/UltiSnips'               " Snippets
Plug 'honza/vim-snippets'             " default snippets
Plug 'ctrlpvim/ctrlp.vim'             " fuzzy finding
Plug 'ludovicchabant/vim-gutentags'   " automate ctags
Plug 'vim-airline/vim-airline'        " nice status line
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'junegunn/goyo.vim'              " distraction free mode
Plug 'Vimjas/vim-python-pep8-indent'  " pep8 indenting
Plug 'thaerkh/vim-workspace'          " workspace management
Plug 'junegunn/vim-easy-align'        " simple text alignment
Plug 'tpope/vim-unimpaired'           " some useful keybindings
Plug 'mhinz/vim-startify'             " fancy start screen
Plug 'Valloric/ListToggle'            " toggle quickfix and location list
Plug 'brennier/quicktex'              " very quick latex writing
Plug 'justinmk/vim-sneak'             " sneak motion
Plug 'tpope/vim-obsession'            " session management
Plug 'jpalardy/vim-slime'             " tmux repl
Plug 'MattesGroeger/vim-bookmarks'    " bookmarks
Plug 'jeetsukumaran/vim-pythonsense'  " python text objects
Plug 'Chiel92/vim-autoformat'         " additional autoformatter
Plug 'jiangmiao/auto-pairs'           " auto close delimiters
Plug 'AndrewRadev/switch.vim'         " toggle special words (true/false etc.)
Plug 'ekalinin/Dockerfile.vim'        " Dockerfile syntax highlighting
Plug 'ryanoasis/vim-devicons'         " fancy glyphs
Plug 'morhetz/gruvbox'                " colorscheme
Plug 'tmux-plugins/vim-tmux'          " syntax hightlighting etc for .tmux.conf
Plug 'raimon49/requirements.txt.vim'  " requirements.txt syntax highlighting
Plug 'AndrewRadev/splitjoin.vim'      " easily switch between single- and multi-line statements
Plug 'kovetskiy/sxhkd-vim'            " indent, highlight syntax and detect sxhkd config files

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" C-p and C-n behave like up and down in command line
cmap <C-P> <Up>
cmap <C-N> <Down>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set vim's update time (for gitgutter)
set updatetime=100

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

set relativenumber
set number
set clipboard=unnamedplus

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=3

" Turn on the WiLd menu
set wildmode=longest,list,full
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Highlight current line
set cursorline

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Show unfinished command in status line
set showcmd

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Disable automatic folding
set nofoldenable
set foldlevelstart=99

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" More natural split opening
set splitbelow
set splitright

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Syntax highlighting is very slow for long lines
set synmaxcol=176

" colorscheme specific settings
set background=dark
let g:gruvbox_invert_signs=0
let g:gitgutter_override_sign_column_highlight=1

colorscheme gruvbox
set termguicolors

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set undodir=~/.config/nvim/undodir
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Python
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal tw=88

" tabstop and shiftwidth for markup languages
autocmd Filetype yaml,html,css,javascript,json,tex setlocal tabstop=2
autocmd Filetype yaml,html,css,javascript,json,tex setlocal shiftwidth=2

" markdown
autocmd Filetype markdown setlocal tw=80

" gitcommit
autocmd BufRead,BufNewFile *COMMIT_EDITMSG setlocal tw=72


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" go back to normal mode
inoremap jk <ESC>

" options for vim diff
set diffopt=vertical

" Esc switches to terminal normal mode
tnoremap <Esc> <C-\><C-n>

" alt+hjkl for moving in insert mode
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

" open file under cursor in vertical split
nnoremap <C-W><C-F> <C-W>vgf

au TermOpen * setlocal nonumber norelativenumber

" terminal keybindings
" Zoom / Restore terminal window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        set showtabline=1
        tabc
        let t:zoomed = 0
    else
        tab split
        set showtabline=0
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
tnoremap <C-F> <C-\><C-n>:ZoomToggle<CR>i
" switch to previous window
tnoremap <C-Q> <C-\><C-n><C-W>p

" ask before jump if ambigous
nnoremap <C-]> g<C-]>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" search and replace
nnoremap <leader>S :%s//g<Left><Left>

" moving up and down work as you expected
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" Navigating with guides
" inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>:call<space>search('<+.*+>')<CR>"_c/+>/e<CR>
nnoremap <Space><Space> :call<space>search('<+.*+>')<CR>"_c/+>/e<CR>
inoremap ;gui <++>

" preview latex equations
" vnoremap <leader>m y:!python<space>~/bin/preview_math.py<space>'<C-r>"'<enter>

" bibtex
autocmd FileType bib inoremap <buffer> ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journaltitle<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap <buffer> ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap <buffer> ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i

" Markdown (soon gonna replace this with quicktex shortcuts)
autocmd FileType markdown inoremap <buffer> <F5> <esc>:!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter>a
autocmd FileType markdown nnoremap <buffer> <F5> :!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter>
autocmd Filetype markdown map <buffer> <F5> :!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter><enter>
autocmd Filetype markdown map <buffer> <F6> :!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown nnoremap <buffer> <F6> :!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown inoremap <buffer> <F6> <esc>:!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown inoremap <buffer> ;n   ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ;b   ****<Space><++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ;s   ~~~~<Space><++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ;e   **<Space><++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ;h   ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap <buffer> ;i   ![](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ;a   [](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ;1   #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ;2   ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ;3   ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ;l   --------<Enter>
autocmd Filetype markdown inoremap <buffer> ;bib <Esc>Go<Enter><++><Enter><Enter>#<Space>References<Enter><Enter>---<Enter>bibliography:<Space><c-r>=$HOME<Enter>/latex/.bibfiles/<Enter>csl:<Space><c-r>=$HOME<Enter>/.config/csl/ieee.csl<Enter>---<Esc>2kA
autocmd Filetype markdown inoremap <buffer> ;t   \todo{}<Enter><Enter><++><Esc>2k$i
autocmd Filetype markdown inoremap <buffer> ;y   ---<Enter>title:<Space>""<Enter>author:<Space>[Christian<Space>Bosdorf]<Enter>date:<Space><C-R>=strftime('%Y-%m-%d')<CR><Enter>...<Esc>3k$i
autocmd FileType markdown inoremap <buffer> ;;e  \begin{equation}<Enter>\end{equation}<Enter><++><Esc>kko

" Latex
autocmd FileType tex inoremap <buffer> ;fig   \begin{figure}[ht]<Enter>\centering<Enter>\includegraphics[width=0.8\linewidth]{images/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap <buffer> ;tikz  \begin{figure}[ht]<Enter>\centering<Enter>\input{tikz/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap <buffer> ;plot  \begin{figure}[ht]<Enter>\centering<Enter>\input{plots/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap <buffer> ;gle   \newglossaryentry{}<enter>{%<enter>name={<++>},<enter>description={<++>}<enter>}<enter><enter><++><Esc>6kf}i
autocmd FileType tex inoremap <buffer> ;sym   \newglossaryentry{sym:}<enter>{%<enter>type=symbols,<enter>name={\ensuremath{<++>}},<enter>description={<++>},<enter>symbol=\si{<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>9kf}i
autocmd FileType tex inoremap <buffer> ;not   \newglossaryentry{not:}<enter>{%<enter>type=notation,<enter>name={<++>},<enter>description={<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>8kf}i
autocmd FileType tex inoremap <buffer> ;acr   \newacronym{acr:}{<++>}{<++>}<enter><++><Esc>kf}i
autocmd FileType tex inoremap <buffer> ;acs   \acrshort{acr:}<space><++><Esc>F}i
autocmd FileType tex inoremap <buffer> ;gls   \gls{}<space><++><Esc>F}i
autocmd FileType tex inoremap <buffer> ;Gls   \Gls{}<space><++><Esc>F}i
autocmd FileType tex inoremap <buffer> ;m     \(\)<++><Esc>F\i

" restructured text
autocmd Filetype rst inoremap <buffer> ;1   <Esc>YpVr=o
autocmd Filetype rst inoremap <buffer> ;2   <Esc>YpVr-o
autocmd Filetype rst inoremap <buffer> ;3   <Esc>YpVr~o

autocmd Filetype rst inoremap <buffer> ;b   ****<Space><++><Esc>F*hi
autocmd Filetype rst inoremap <buffer> ;c   ````<Space><++><Esc>F`hi
autocmd Filetype rst inoremap <buffer> ;e   **<Space><++><Esc>F*i
autocmd Filetype rst inoremap <buffer> ;i   `<Space><<++>>`__<++><Esc>2F`a
autocmd Filetype rst inoremap <buffer> ;a   ::`<++><Space><<++>>`__<++><Esc>2F:a

autocmd Filetype rst inoremap <buffer> ..c  ..<Space>code::<CR><CR><Tab><++><Esc>2kA<Space>
autocmd Filetype rst inoremap <buffer> ..i  ..<Space>image::<CR><Tab><++><Esc>kA<Space>

" tikz
autocmd FileType tex inoremap <buffer> ;tp    \begin{tikzpicture}[]<enter><++><enter>\end{tikzpicture}<Esc>2kf]i
autocmd FileType tex inoremap <buffer> ;node  \node[]<space>(<++>)<space>at<space>(<++>)<space>{<++>};<Esc>F]i
autocmd FileType tex inoremap <buffer> ;draw  \draw[]<space>(<++>)<space><++><space>(<++>);<Esc>F]i
autocmd FileType tex inoremap <buffer> ;linu  \linunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap <buffer> ;tanh  \tanhunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap <buffer> ;sigm  \sigmunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap <buffer> ;sum   \sumunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap <buffer> ;isec  \intersec[]{<++>}<Esc>F]i

" sql
au BufRead /tmp/psql.edit.* set syntax=sql
autocmd BufWrite /tmp/psql.edit.* :Autoformat
autocmd BufWrite *.sql :Autoformat

" sphinx
autocmd BufRead */services/docs/*.rst set makeprg=make\ -f\ Makefile.docs\ html

" quicktex (or better 'quick_anything')
autocmd FileType python inoremap ;- <Esc>Ypviwr-o

let g:quicktex_markdown = {
            \' '      : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \}

let g:quicktex_rst = {
            \' '      : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
        \'Section: cross referencing' : 'COMMENT',
            \':mod'   : ":mod:`<+++>` <++>",
            \':class' : ":class:`<+++>` <++>",
            \':meth'   : ":meth:`<+++>` <++>",
            \':func'   : ":func:`<+++>` <++>",
            \':math'   : ":math:`<+++>` <++>",
            \':data'   : ":data:`<+++>` <++>",
            \':const'   : ":const:`<+++>` <++>",
            \':attr'   : ":attr:`<+++>` <++>",
            \':exc'   : ":exc:`<+++>` <++>",
            \':obj'   : ":obj:`<+++>` <++>",
            \':program'   : ":program:`<+++>` <++>",
            \':ref'   : ":ref:`<+++>` <++>",
            \':doc'   : ":doc:`<+++>` <++>",
            \':download'   : ":download:`<+++>` <++>",
            \':file'   : ":file:`<+++>` <++>",
            \}

"" Python
let g:quicktex_python = {
            \' '      : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
        \'Section: docstrings' : 'COMMENT',
            \';doc'   : "\""."\""."\""."<+++>"."\""."\""."\"",
            \';arg'   : "<+++> : <++>",
            \';tod'   : "# TODO: <+++>",
            \';todo'  : "# TODO: <+++>",
            \';par'   : "Parameters\<CR>----------\<CR>",
            \';params': "Parameters\<CR>----------\<CR>",
            \';args'  : "Parameters\<CR>----------\<CR>",
            \';ret'   : "Returns\<CR>-------\<CR>",
            \';rai'   : "Raises\<CR>------\<CR>",
            \';err'   : "Raises\<CR>------\<CR>",
            \';yie'   : "Yields\<CR>------\<CR>",
            \';att'   : "Attributes\<CR>----------\<CR>",
            \';exa'   : "Examples\<CR>--------\<CR>",
            \';not'   : "Notes\<CR>-----\<CR>",
            \';see'   : "See Also\<CR>--------\<CR>",
            \';key'   : "Keyword\<CR>-------\<CR>",
            \';Ref'   : "References\<CR>----------\<CR>",
            \';war'   : "Warning\<CR>-------\<CR>",
            \';oth'   : "Other\<CR>-----\<CR>",
            \';met'   : "Methods\<CR>-------\<CR>",
            \';obj'   : ":obj:`<+++>`<++>",
        \'Section: cross referencing' : 'COMMENT',
            \';ref'   : ":ref:`<+++>`<++>",
        \'Section: classes and functions' : 'COMMENT',
            \';cls'   : "class <+++>(<++>):\<CR><++>",
            \';class'   : "class <+++>(<++>):\<CR><++>",
            \';defi'  : "def __init__(self, <+++>):\<CR><++>",
            \';defc'  : "@classmethod\<CR>def <+++>(cls, <++>):\<CR><++>",
            \';defs'  : "@staticmethod\<CR>def <+++>(<++>):\<CR><++>",
            \';defm'  : "def <+++>(self, <++>):\<CR><++>",
            \';defd'  : "def __<+++>__(self, <++>):\<CR><++>",
            \';def'  : "def <+++>(<++>):\<CR><++>",
            \';fun'   : "def <+++>(<++>):\<CR><++>",
            \';get'  : "@property\<CR>def <+++>(self):\<CR><++>",
            \';prop'  : "@property\<CR>def <+++>(self):\<CR><++>",
            \';set'  : "@<+++>.setter\<CR>def <++>(self, value):\<CR><++>",
        \'Section: keywords' : 'COMMENT',
            \';im'    : "import <+++>",
        \'Section: general' : 'COMMENT',
            \';pd'    : "import pandas as pd",
            \';plt'    : "import matplotlib.pyplot as plt",
            \';np'    : "import numpy as np",
            \';#'    : " # ",
            \}

"" LaTeX
let g:quicktex_tex = {
            \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \'m'   : '\( <+++> \) <++>',
        \'Section: Environments' : 'COMMENT',
            \'env':  "\<ESC>Bvedi\\begin{\<ESC>pa}\<CR><+++>\<CR>\\end{\<ESC>pa}",
            \'ol':   "\\begin{enumerate}\<CR>\\item <+++>\<CR>\\end{enumerate}",
            \'ul':   "\\begin{itemize}\<CR>\\item <+++>\<CR>\\end{itemize}",
            \'eqn':  "\\begin{equation*}\<CR><+++>\<CR>\\end{equation*}\<CR><++>",
            \'Eqn':  "\\begin{equation}\\label{<+++>}\<CR><++>\<CR>\\end{equation}\<CR><++>",
            \'frm':  "\\begin{frame}\<CR>\\frametitle{<+++>}\<CR><++>\<CR>\\end{frame}",
            \
        \'Section: Other Commands' : 'COMMENT',
            \'itm':     '\item ',
            \'chap':    "\\chapter{<+++>}\<CR><++>",
            \'sec':     "\\section{<+++>}\<CR><++>",
            \'ssec':    "\\subsection{<+++>}\<CR><++>",
            \'sssec':   "\\subsubsection{<+++>}\<CR><++>",
            \'para':    '(<+++>) <++>',
            \'todo':    "\\todo{<+++>}\<CR><++>",
            \'cmd':    "\<ESC>Bi\\\<ESC>Ea{<+++>}<++>",
            \'texroot': '%!TEX root=.',
            \
        \'Section: Citing and Referencing' : 'COMMENT',
            \'cref':  "\\cref{<+++>}<++>",
            \'(cref': "(\\cref{<+++>}<++>",
            \'Cref':  "\\Cref{<+++>}<++>",
            \'eqref': "\\eqref{eq:<+++>}<++>",
            \'ref':   "\\ref{<+++>}<++>",
            \'cite':  "\<BS>~\\autocite{<+++>}<++>",
            \'enq':   "\\enquote{<+++>} <++>",
            \
        \'Section: Greek Letters' : 'COMMENT',
            \'alpha'   : '\(\alpha\) ',
            \'ga'      : '\(\alpha\) ',
            \'beta'    : '\(\beta\) ',
            \'gamma'   : '\(\gamma\) ',
            \'delta'   : '\(\delta\) ',
            \'epsilon' : '\(\varepsilon\) ',
            \'ge'      : '\(\varepsilon\) ',
            \'zeta'    : '\(\zeta\) ',
            \'eta'     : '\(\eta\) ',
            \'theta'   : '\(\theta\) ',
            \'iota'    : '\(\iota\) ',
            \'kappa'   : '\(\kappa\) ',
            \'lambda'  : '\(\lambda\) ',
            \'gl'      : '\(\lambda\) ',
            \'mu'      : '\(\mu\) ',
            \'nu'      : '\(\nu\) ',
            \'xi'      : '\(\xi\) ',
            \'omega'   : '\(\omega\) ',
            \'pi'      : '\(\pi\) ',
            \'rho'     : '\(\rho\) ',
            \'sigma'   : '\(\sigma\) ',
            \'tau'     : '\(\tau\) ',
            \'upsilon' : '\(\upsilon\) ',
            \'gu'      : '\(\upsilon\) ',
            \'phi'     : '\(\varphi\) ',
            \'chi'     : '\(\chi\) ',
            \'psi'     : '\(\psi\) ',
            \
        \'Section: Uppercase Greek Letters' : 'COMMENT',
            \'Gamma'   : '\(\Gamma\) ',
            \'Delta'   : '\(\Delta\) ',
            \'Theta'   : '\(\Theta\) ',
            \'Lambda'  : '\(\Lambda\) ',
            \'Xi'      : '\(\Xi\) ',
            \'Omega'   : '\(\Omega\) ',
            \'Pi'      : '\(\Pi\) ',
            \'Sigma'   : '\(\Sigma\) ',
            \'Upsilon' : '\(\Upsilon\) ',
            \'Phi'     : '\(\Phi\) ',
            \'Chi'     : '\(\Chi\) ',
            \'Psi'     : '\(\Psi\) ',
            \
        \'Section: Text formatting' : 'COMMENT',
            \'em'     : "\\emph{<+++>} <++>",
            \'sc'     : "\\textsc{<+++>} <++>",
            \'tt'     : "\\texttt{<+++>} <++>",
            \'bf'     : "\\textbf{<+++>} <++>",
            \'it'     : "\\textit{<+++>} <++>",
            \
            \}

let g:quicktex_math = {
            \' '       : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
        \'Section: Lowercase Greek Letters' : 'COMMENT',
            \'alpha'   : '\alpha ',
            \'ga'      : '\alpha ',
            \'beta'    : '\beta ',
            \'gamma'   : '\gamma ',
            \'delta'   : '\delta ',
            \'epsilon' : '\epsilon ',
            \'ge'      : '\varepsilon ',
            \'zeta'    : '\zeta ',
            \'eta'     : '\eta ',
            \'theta'   : '\theta ',
            \'iota'    : '\iota ',
            \'kappa'   : '\kappa ',
            \'lambda'  : '\lambda ',
            \'gl'      : '\lambda ',
            \'mu'      : '\mu ',
            \'nu'      : '\nu ',
            \'xi'      : '\xi ',
            \'omega'   : '\omega ',
            \'pi'      : '\pi ',
            \'rho'     : '\rho ',
            \'sigma'   : '\sigma ',
            \'tau'     : '\tau ',
            \'upsilon' : '\upsilon ',
            \'gu'      : '\upsilon ',
            \'phi'     : '\varphi ',
            \'chi'     : '\chi ',
            \'psi'     : '\psi ',
            \
        \'Section: Uppercase Greek Letters' : 'COMMENT',
            \'Gamma'   : '\Gamma ',
            \'Delta'   : '\Delta ',
            \'Theta'   : '\Theta ',
            \'Lambda'  : '\Lambda ',
            \'Xi'      : '\Xi ',
            \'Omega'   : '\Omega ',
            \'Pi'      : '\Pi ',
            \'Sigma'   : '\Sigma ',
            \'Upsilon' : '\Upsilon ',
            \'Phi'     : '\Phi ',
            \'Chi'     : '\Chi ',
            \'Psi'     : '\Psi ',
            \
        \'Section: Set Theory' : 'COMMENT',
            \'bn'    : '\mathbb{N} ',
            \'bz'    : '\mathbb{Z} ',
            \'bq'    : '\mathbb{Q} ',
            \'br'    : '\mathbb{R} ',
            \'bc'    : '\mathbb{C} ',
            \'ba'    : '\mathbb{A} ',
            \'bf'    : '\mathbb{F} ',
            \'in'    : '\in ',
            \'nin'   : '\not\in ',
            \'cup'   : '\cup ',
            \'cap'   : '\cap ',
            \'union' : '\cup ',
            \'sect'  : '\cap ',
            \'set'   : '\{<+++>\} <++>',
            \'pair'  : '(<+++>, <++>) <++>',
            \
        \'Section: Logic' : 'COMMENT',
            \'exists'  : '\exists ',
            \'nexists' : '\nexists ',
            \'forall'  : '\forall ',
            \'implies' : '\implies ',
            \'iff'     : '\iff ',
            \
        \'Section: Relations' : 'COMMENT',
            \'lt'      : '< ',
            \'gt'      : '> ',
            \'gg'      : '\gg ',
            \'ll'      : '\ll ',
            \'leq'     : '\leq ',
            \'geq'     : '\geq ',
            \'eq'      : '= ',
            \'aeq'     : '&= ',
            \'nl'      : '\nless ',
            \'ng'      : '\ngtr ',
            \'nleq'    : '\nleq ',
            \'ngeq'    : '\ngeq ',
            \'neq'     : '\neq ',
            \'neg'     : '\neg ',
            \
        \'Section: Operations' : 'COMMENT',
            \'plus'   : '+ ',
            \'min'   : '- ',
            \'frac'  : '\frac{<+++>}{<++>} <++>',
            \'recip' : '\frac{1}{<+++>} <++>',
            \'dot'   : '\cdot ',
            \'hada'  : '\odot ',
            \'exp'   : "\<BS>^{<+++>} <++>",
            \'pow'   : "\<BS>^{<+++>} <++>",
            \'tp'    : "\<BS>^{\\top} ",
            \'sq'    : "\<BS>^2 ",
            \'inv'   : "\<BS>^{-1} ",
            \'cross' : '\times ',
            \
        \'Section: Delimiters' : 'COMMENT',
            \'bpara' : '\left( <+++> \right) <++>',
            \'para'  : '(<+++>) <++>',
            \'bsb'   : '\left[ <+++> \right] <++>',
            \'sb'    : '[<+++>] <++>',
            \'bbra'  : '\left\{ <+++> \right\} <++>',
            \'bra'   : '\{<+++>\} <++>',
            \
        \'Section: Functions' : 'COMMENT',
            \'to'     : '\to ',
            \'mapsto' : '\mapsto ',
            \'of'     : "\<BS>(<+++>) <++>",
            \'sin'    : '\sin ',
            \'cos'    : '\cos ',
            \'tan'    : '\tan ',
            \'tanh'   : '\tanh ',
            \'ln'     : '\ln ',
            \'log'    : '\log ',
            \'df'     : '<+++> : <++> \to <++>',
            \'sqrt'   : '\sqrt{<+++>} <++>',
            \'case'   : '\begin{cases} <+++> \end{cases} <++>',
            \
        \'Section: LaTeX commands' : 'COMMENT',
            \'sub'    : "\<BS>_{<+++>} <++>",
            \'sone'   : "\<BS>_1 ",
            \'stwo'   : "\<BS>_2 ",
            \'sthree' : "\<BS>_3 ",
            \'sfour'  : "\<BS>_4 ",
            \'text'   : '\text{<+++>} <++>',
            \
        \'Section: Fancy Variables' : 'COMMENT',
            \'fA' : '\mathcal{A} ',
            \'fo' : '\mathcal{O} ',
            \'fn' : '\mathcal{N} ',
            \'fp' : '\mathcal{P} ',
            \'ft' : '\mathcal{T} ',
            \'fc' : '\mathcal{C} ',
            \'fm' : '\mathcal{M} ',
            \'ff' : '\mathcal{F} ',
            \'fz' : '\mathcal{Z} ',
            \'fi' : '\mathcal{I} ',
            \'fb' : '\mathcal{B} ',
            \'fl' : '\mathcal{L} ',
            \'fv' : '\mathcal{V} ',
            \
        \'Section: Encapsulating keywords' : 'COMMENT',
            \'hat'  : "\<ESC>Bi\\hat{\<ESC>Els} ",
            \'bar'  : "\<ESC>Bi\\overline{\<ESC>Els} ",
            \'tild'  : "\<ESC>Bi\\tilde{\<ESC>Els} ",
            \'vec' : "\<ESC>Bi\\vect{\<ESC>Els} ",
            \'comp' : "\<ESC>Bi\\underline{\<ESC>Els} ",
            \'adj' : "\<ESC>Bi\\adj{\<ESC>Els} ",
            \'star'  : "\<BS>^* ",
            \
        \'Section: Linear Algebra' : 'COMMENT',
            \'matrix' : "\<CR>\\begin{bmatrix}\<CR><+++>\<CR>\\end{bmatrix}\<CR><++>",
            \'vdots'  : '\vdots & ',
            \'ddots'  : '\ddots & ',
            \'cdots'  : '\cdots & ',
            \'ldots'  : '\ldots ',
            \
        \'Section: Constants' : 'COMMENT',
            \'inf'   : '\infty ',
            \'e'     : '\e ',
            \'one'   : '1 ',
            \'null'  : '0 ',
            \'zero'  : '0 ',
            \'two'   : '2 ',
            \'three' : '3 ',
            \'four'  : '4 ',
            \
        \'Section: Operators' : 'COMMENT',
            \'int'    : '\int <+++> \mathop{\dr <++>} <++>',
            \'diff'   : '\frac{\mathrm{d}}{\mathrm{d} <+++>} <++>',
            \'partial': '\frac{\partial <+++>}{\partial <++>} <++>',
            \'lim'    : '\lim_{<+++>} <++>',
            \'norm'   : '\norm{<+++>}_{<++>} <++>',
            \'nabla'  : '\nabla ',
            \'sum'    : '\sum ',
            \'prod'   : '\prod ',
            \'limsup' : '\limsup ',
            \'liminf' : '\liminf ',
            \'sup'    : '\sup ',
            \'sinf'   : '\inf ',
            \}

" Mail
autocmd FileType mail inoremap mfg Mit<space>freundlichen<space>Grüßen<Esc>

" Vimwiki
" autocmd FileType vimwiki nnoremap <leader>m :s/%20/\\%20/g<enter>/http<enter>yi)u:noh<enter>:!mpv<space>--quiet<space><C-r>*<enter>

" Vim-Anywhere
autocmd BufRead,BufNewFile /tmp/vim-anywhere* set filetype=txt

" Make calcurse notes markdown compatible:
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown

" Goyo
map <F9> :Goyo<CR>
inoremap <F9> <esc>:Goyo<CR>a

" Insert date
inoremap ;dt <C-R>=strftime('%Y-%m-%d')<CR>
" nnoremap ;dt a<C-R>=strftime('%Y-%m-%d')<CR><Esc>

" indent/dedent in visual mode
vnoremap L >gv
vnoremap H <gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell! spelllang=en_us<cr>
map <leader>sd :set spelllang=de_de<cr>

" Shortcuts using <leader>
map <leader>sa zg
map <leader>s? z=
map <leader>st 1z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatdef_pg_format = '"pg_format"'
let g:formatters_sql = ['pg_format', 'sqlformat']

""Startify
let g:startify_list_order = ['files', 'dir', 'bookmarks']
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}]
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 4
let g:startify_custom_indices = ['1', '2', '3', '4', '7', '8', '9', '0']

"" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" nerd tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <leader>T :NERDTreeFind<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapUpdir = 'H'
let g:NERDTreeMapChangeRoot = 'L'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=[
            \ '\.aux$', '\.lo[lft]$', '\.sl[gso]$', '\.not$', '\.ntn$', '\.ac[nrg]$',
            \ '\.gl[gso]$', '\.ist$', '\.nlg$', '\.log$', '\.gz$', '\.run.xml$',
            \ '\.toc$', '\.out$', '\.bbl$', '\.bcf$', '\.blg$', '\.snm$', '\.nav$',
            \ '\.fdb_latexmk$', '\.fls$', '\.xdv$', '\.py[co]$', '^tags$[[file]]',
            \ '_minted[[dir]]', '.mypy_cache[[dir]]', '__pycache__[[dir]]',
            \ '\.synctex\(busy\)$'
            \]

"" sneak
let g:sneak#use_ic_scs = 1
map <leader><leader> <Plug>Sneak_,

"" autopairs
let g:AutoPairsMapSpace = 0
let g:AutoPairsMapCR = 0

"" vimtex
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

augroup vimtex_event_1
    au!
    au User VimtexEventQuit     call vimtex#compiler#clean(0)
augroup END

" ysc mapping
augroup latexSurround
    autocmd!
    autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
    let b:surround_{char2nr("e")}
                \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
    let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

"" supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

"" nvim completion manager / ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Press enter key to trigger snippet expansion
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" line completion with C-Space
inoremap <C-Space> <C-x><C-l>

" ncm vimtex
augroup my_cm_setup
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-cmds',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'prefix', 'key': 'word'},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-labels',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'substr', 'key': 'word'},
                \               {'name': 'substr', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#labels,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-files',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'abbrfuzzy', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#files,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'bibtex',
                \ 'priority': 8,
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'prefix', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \               {'name': 'abbrfuzzy', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
augroup END

"" jedi
let g:jedi#completions_enabled = 0

"" UltiSnips
let g:UltiSnipsExpandTrigger		= "<c-j>"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit="vertical"

"" switch.vim
let g:switch_mapping = "-"

"" vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = ''

"" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.root']
nnoremap <leader>/ :CtrlPLine<space>%<enter>
nnoremap <leader>ta :CtrlPBufTagAll<enter>

set wildignore+=*.mat,*.pdfpc,*/tmp/*,*.so,*.swp,*.zip,*.aux,*.gz,*.fdb_latexmk,*.fls,
            \*.log,*.pdf,*.glg,*.glo,*.ist,*.bcf,*.bbl,*.blg,*.gls,*.run.xml,*.toc,
            \*.acn,*.acr,*.alg,*.ntn,*.slo,*.not,*.nlg,*.slg,*.sls,*.lof,*.lot,*.lol,
            \*.xdv

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git|\.hg|\.svn|_minted)$',
            \ 'file': '\v\.(mat|pdfpc|latexmain|gitignore|root|exe|so|dll|aux|gz|'.
                \ 'fdb_latexmk|fls|log|pdf|run|blg|toc|bcf|run\.xml|png|jpeg|bmp|out|bbl|'.
                \ 'snm|nav|glg|gls|glo|ist|acn|acr|alg|ntn|slo|not|nlg|slg|sls|lof|lot|'.
                \ 'lol|xdv)$',
            \ }

let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \}

"" vim-workspace
" nnoremap <leader>s :ToggleWorkspace<CR>

"" vim-bookmarks
let g:bookmark_disable_ctrlp = 0
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_no_default_key_mappings = 1

nmap <Leader>mm <Plug>BookmarkToggle
nmap <Leader>mi <Plug>BookmarkAnnotate
nmap <Leader>ma <Plug>BookmarkShowAll
nmap <Leader>mn <Plug>BookmarkNext
nmap <Leader>mp <Plug>BookmarkPrev
nmap <Leader>mc <Plug>BookmarkClear
nmap <Leader>mx <Plug>BookmarkClearAll
nmap <Leader>mkk <Plug>BookmarkMoveUp
nmap <Leader>mjj <Plug>BookmarkMoveDown
nmap <Leader>mg <Plug>BookmarkMoveToLine

"" airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

"" vim-markdown
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 0

autocmd FileType markdown nnoremap <localleader>lt :Toc<Enter>

"" indentline
let g:indentLine_fileTypeExclude = ['vimwiki', 'markdown']
let g:indentLine_setConceal = 0
let g:indentLine_char = '┊'

"" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'


let g:ale_linters = {
            \   'python': ['flake8', 'pydocstyle', 'mypy'],
            \   'tex': ['chktex'],
            \   'sql': ['sqlint'],
            \   'Dockerfile': ['hadolint', 'dockerfile_lint'],
            \   'yaml': ['yamllint'],
            \   'json': ['jsonlint'],
            \}

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['black', 'isort'],
            \   'yaml': ['prettier'],
            \   'html': ['prettier'],
            \   'css': ['prettier'],
            \   'javascript': ['prettier'],
            \   'json': ['prettier'],
            \   'tex': ['latexindent'],
            \}

"" iron
" deactivate default mappings
let g:iron_map_defaults=0
" define custom mappings for the python filetype
augroup ironmapping
    autocmd!
    " autocmd FileType python nmap <buffer> <localleader>r :call<space>SetReplSize()<enter>:IronRepl<Enter><C-\><C-n><C-W>p
    autocmd FileType python nmap <buffer> <localleader>r :call<space>SetReplSize()<enter>:IronRepl<Enter><C-\><C-n><C-W>p
    autocmd FileType python nmap <buffer> <localleader>R :call<space>SetReplSize()<enter>:IronPromptCommand<Enter>
    autocmd Filetype python nmap <buffer> <localleader><space> :IronFocus<enter>i<enter><enter><C-\><C-n><C-W>p
    autocmd Filetype python nmap <buffer> <localleader>is yiw:call<space>IronSend('<C-r>+')<enter>
    autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
    " autocmd FileType python nmap <buffer> <F5> :w<enter>:call<space>IronSend('run<space><C-r>%')<enter>
    " autocmd FileType python imap <buffer> <F5> <C-o>:w<enter><C-o>:call<space>IronSend('run<space><C-r>%')<enter>
augroup END

" set repl size
function! SetReplSize()
    " if winwidth(0)>99
        " let g:iron_repl_open_cmd = '50vsplit'
    " else
    let g:iron_repl_open_cmd = '15split'
    " endif
endfunction

"" vim-slime

let g:slime_target = "tmux"
let g:slime_python_ipython = 1
autocmd FileType python nmap <buffer> <F5> :w<cr>:exec "SlimeSend1 " . "run -m " . substitute(expand("%:r"), "\/", "\.", "g")<cr>
autocmd FileType python imap <buffer> <F5> <C-o>:w<cr><C-o>:exec "SlimeSend1 " . "run -m " . substitute(expand("%:r"), "\/", "\.", "g")<cr>

"" gutentags
let g:gutentags_exclude_filetypes = ['gitcommit', 'requirements']

"" echodoc
let g:echodoc#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn formatted text into a python string
xnoremap <leader>x <esc>:'<,'>!sed -e '0,/^.*"\{3\}\\\?/s///' -e 's/"\{3\}$//' -e 's/\s\{4\}/\\t/g' -e 's/^/"/' -e 's/$/",/' -e '1i "\\n".join((' -e '$a ))'<cr>

" Press: vai, vii to select outer/inner python blocks by indetation.
" Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
vnoremap <silent>ii <Esc>:call IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
    let curline = line(".")
    let lastline = line("$")
    let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
    let i = i < 0 ? 0 : i
    if getline(".") =~ "^\\s*$"
        return
    endif
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && (nextblank || indent(p) >= i )
        -
        let p = line(".") - 1
        let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    if (!a:inner)
        -
    endif
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && (nextblank || indent(p) >= i )
        +
        let p = line(".") + 1
        let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    if (!a:inner)
        +
    endif
    normal! $
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
