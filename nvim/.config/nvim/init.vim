""Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'           " nerd tree
Plug 'roxma/nvim-completion-manager' " auto completion
Plug 'machakann/vim-swap'            " swap items in comma separated lists
Plug 'Shougo/echodoc.vim'            " show docstring in cmdline
Plug 'majutsushi/tagbar'             " tag explorer
Plug 'hkupty/iron.nvim'              " REPL
Plug 'terryma/vim-multiple-cursors'  " multiple cursors
Plug 'yggdroot/indentline'           " indentation guides
Plug 'davidhalter/jedi-vim'          " python jedi
Plug 'vimwiki/vimwiki'               " wiki
Plug 'neomake/neomake'               " neomake
Plug 'cespare/vim-toml'              " toml
Plug 'plasticboy/vim-markdown'       " markdown
Plug 'tpope/vim-surround'            " vim surround
Plug 'tpope/vim-commentary'          " comment stuff out
Plug 'tpope/vim-repeat'              " repeat almost anything
Plug 'tpope/vim-fugitive'            " git
Plug 'lervag/vimtex'                 " LaTeX
Plug 'ervandew/supertab'             " Use tab for autocompletion
Plug 'SirVer/UltiSnips'              " Snippets
Plug 'honza/vim-snippets'            " default snippets
Plug 'ctrlpvim/ctrlp.vim'            " fuzzy finding
Plug 'ludovicchabant/vim-gutentags'  " automate ctags
Plug 'easymotion/vim-easymotion'     " vim motion on steroids
Plug 'itchyny/lightline.vim'         " nice status line
Plug 'junegunn/goyo.vim'             " distraction free mode
Plug 'Vimjas/vim-python-pep8-indent' " pep8 indenting
Plug 'thaerkh/vim-workspace'         " workspace management
Plug 'junegunn/vim-easy-align'       " simple text alignment
Plug 'tpope/vim-unimpaired'          " some useful keybindings
Plug 'mhinz/vim-startify'            " fancy start screen
Plug 'Valloric/ListToggle'           " toggle quickfix and location list
Plug 'brennier/quicktex'             " very quick latex writing

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
let g:python3_host_prog = '/usr/bin/python'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" colorscheme specific settings
set background=dark

colorscheme slate

" Highlight colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
hi ErrorMsg term=standout cterm=bold ctermfg=0 ctermbg=1 guifg=White guibg=Red
hi Error term=reverse cterm=bold ctermfg=0 ctermbg=1 guifg=White guibg=Red
hi IncSearch term=reverse ctermfg=208 ctermbg=10 gui=reverse guifg=green guibg=black
hi Search term=reverse ctermfg=253 ctermbg=12 guifg=wheat guibg=peru
hi MatchParen term=reverse ctermfg=0 ctermbg=6 guibg=DarkCyan
hi Visual term=reverse cterm=reverse ctermbg=16 ctermfg=40 guifg=khaki guibg=olivedrab
hi Terminal ctermbg=none ctermfg=40 guibg=lightgrey guifg=blue
hi SpellBad ctermbg=9 ctermfg=0 gui=undercurl guisp=Red
hi SpellCap ctermbg=12 ctermfg=0 gui=undercurl guisp=Blue
hi SpellRare ctermbg=13 ctermfg=0 gui=undercurl guisp=Magenta
hi SpellLocal ctermbg=14 ctermfg=0 gui=undercurl guisp=Cyan

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
nnoremap S :%s//g<Left><Left>

" moving up and down work as you expected
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" Navigating with guides
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
nnoremap <Space><Space> /<++><Enter>"_c4l
inoremap ;gui <++>

" preview latex equations
vnoremap <leader>m y:!python<space>~/bin/preview_math.py<space>'<C-r>"'<enter>

" bibtex
autocmd FileType bib inoremap ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journaltitle<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i

" Markdown (soon gonna replace this with quicktex shortcuts)
autocmd FileType markdown inoremap <F5> <esc>:!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter>a
autocmd FileType markdown nnoremap <F5> :!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter>
autocmd Filetype markdown map <F5> :!pandoc<space><c-r>%<space>-o<space>%:r.pdf<space>-f<space>markdown<space>--template<space>eisvogel<space>--listings<space>-V<space>colorlinks<space>--number-sections<space>--toc<enter><enter>
autocmd Filetype markdown map <F6> :!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown nnoremap <F6> :!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown inoremap <F6> <esc>:!zathura<space>%:r.pdf<Enter>
autocmd Filetype markdown inoremap ;n   ---<Enter><Enter>
autocmd Filetype markdown inoremap ;b   ****<Space><++><Esc>F*hi
autocmd Filetype markdown inoremap ;s   ~~~~<Space><++><Esc>F~hi
autocmd Filetype markdown inoremap ;e   **<Space><++><Esc>F*i
autocmd Filetype markdown inoremap ;h   ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ;i   ![](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap ;a   [](<++>)<Space><++><Esc>F[a
autocmd Filetype markdown inoremap ;1   #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;2   ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;3   ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;l   --------<Enter>
autocmd Filetype markdown inoremap ;bib <Esc>Go<Enter><++><Enter><Enter>#<Space>References<Enter><Enter>---<Enter>bibliography:<Space><c-r>=$HOME<Enter>/latex/.bibfiles/<Enter>csl:<Space><c-r>=$HOME<Enter>/.config/csl/ieee.csl<Enter>---<Esc>2kA
autocmd Filetype markdown inoremap ;t   \todo{}<Enter><Enter><++><Esc>2k$i
autocmd Filetype markdown inoremap ;y   ---<Enter>title:<Space>""<Enter>author:<Space>[Christian<Space>Bosdorf]<Enter>date:<Space><C-R>=strftime('%Y-%m-%d')<CR><Enter>...<Esc>3k$i
autocmd FileType markdown inoremap ;;e  \begin{equation}<Enter>\end{equation}<Enter><++><Esc>kko

" Latex
autocmd FileType tex inoremap ;fig   \begin{figure}[ht]<Enter>\centering<Enter>\includegraphics[width=0.8\linewidth]{images/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap ;tikz  \begin{figure}[ht]<Enter>\centering<Enter>\input{tikz/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap ;plot  \begin{figure}[ht]<Enter>\centering<Enter>\input{plots/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>
autocmd FileType tex inoremap ;gle   \newglossaryentry{}<enter>{%<enter>name={<++>},<enter>description={<++>}<enter>}<enter><enter><++><Esc>6kf}i
autocmd FileType tex inoremap ;sym   \newglossaryentry{sym:}<enter>{%<enter>type=symbols,<enter>name={\ensuremath{<++>}},<enter>description={<++>},<enter>symbol=\si{<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>9kf}i
autocmd FileType tex inoremap ;not   \newglossaryentry{not:}<enter>{%<enter>type=notation,<enter>name={<++>},<enter>description={<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>8kf}i
autocmd FileType tex inoremap ;acr   \newacronym{acr:}{<++>}{<++>}<enter><++><Esc>kf}i
autocmd FileType tex inoremap ;acs   \acrshort{acr:}<space><++><Esc>F}i
autocmd FileType tex inoremap ;gls   \gls{}<space><++><Esc>F}i
autocmd FileType tex inoremap ;Gls   \Gls{}<space><++><Esc>F}i
autocmd FileType tex inoremap ;m     \(\)<++><Esc>F\i

" tikz
autocmd FileType tex inoremap ;tp    \begin{tikzpicture}[]<enter><++><enter>\end{tikzpicture}<Esc>2kf]i
autocmd FileType tex inoremap ;node  \node[]<space>(<++>)<space>at<space>(<++>)<space>{<++>};<Esc>F]i
autocmd FileType tex inoremap ;draw  \draw[]<space>(<++>)<space><++><space>(<++>);<Esc>F]i
autocmd FileType tex inoremap ;linu  \linunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap ;tanh  \tanhunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap ;sigm  \sigmunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap ;sum   \sumunit[]{<++>}{<++>}<Esc>F]i
autocmd FileType tex inoremap ;isec  \intersec[]{<++>}<Esc>F]i

" quicktex
let g:quicktex_tex = {
            \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \'m'   : '\( <+++> \) <++>',
        \'Section: Environments' : 'COMMENT',
            \'env':  "\<ESC>Bvedi\\begin{\<ESC>pa}\<CR><+++>\<CR>\\end{\<ESC>pa}",
            \'ol':   "\\begin{enumerate}\<CR>\\item <+++>\<CR>\\end{enumerate}",
            \'ul':   "\\begin{itemize}\<CR>\\item <+++>\<CR>\\end{itemize}",
            \'eqn':  "\\begin{equation*}\<CR><+++>\<CR>\\end{equation*}\<CR><++>",
            \'Eqn':  "\\begin{equation}\\label{<+++>}\<CR><++>\<CR>\\end{equation}\<CR><++>",
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
            \'adj' : "\<ESC>Bi\\adj{\<ESC>Els} ",
            \'star'  : "\<BS>^* ",
            \
        \'Section: Linear Algebra' : 'COMMENT',
            \'matrix' : "\<CR>\\begin{bmatrix}\<CR><+++>\<CR>\\end{bmatrix}\<CR><++>",
            \'vdots'  : '\vdots & ',
            \'ddots'  : '\ddots & ',
            \'cdots'  : '\cdots & ',
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
autocmd FileType vimwiki nnoremap <leader>m :s/%20/\\%20/g<enter>/http<enter>yi)u:noh<enter>:!mpv<space>--quiet<space><C-r>*<enter>

" Vim-Anywhere
autocmd BufRead,BufNewFile /tmp/vim-anywhere* set filetype=txt

" Make calcurse notes markdown compatible:
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown

" Goyo
map <F10> :Goyo<CR>
inoremap <F10> <esc>:Goyo<CR>a

" Insert date
inoremap ;dt <C-R>=strftime('%Y-%m-%d')<CR>
nnoremap ;dt a<C-R>=strftime('%Y-%m-%d')<CR><Esc>

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
""Startify
let g:startify_list_order = ['files', 'dir', 'bookmarks']
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}]
let g:startify_change_to_dir = 1
let g:startify_files_number = 4
let g:startify_custom_indices = ['1', '2', '3', '4', '7', '8', '9', '0']

"" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" nerd tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <leader>t :NERDTreeFind<CR>

let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapUpdir = 'H'
let g:NERDTreeMapChangeRoot = 'L'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.aux$', '\.lol$', '\.lof$', '\.lot$', '\.slg$', '\.sls$', '\.not$', '\.ntn$', '\.slo$', '\.acn$', '\.acr$', '\.alg$', '\.glg$', '\.gls$', '\.glo$', '\.ist$', '\.nlg$', '\.log$', '\.gz$', '\.run.xml$', '\.pdf$', '\.toc$', '\.out$', '\.bbl$', '\.bcf$', '\.blg$', '\.fdb_latexmk$', '\.fls$', '^tags$[[file]]', '_minted[[dir]]']

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

"" nvim completion manager
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <c-c> <ESC>

" ncm vimtex
augroup my_cm_setup
    autocmd!
    autocmd User CmSetup call cm#register_source({
                \ 'name' : 'vimtex',
                \ 'priority': 8,
                \ 'scoping': 1,
                \ 'scopes': ['tex'],
                \ 'abbreviation': 'tex',
                \ 'cm_refresh_patterns': g:vimtex#re#ncm,
                \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
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

"" vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = ''

"" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_root_markers = ['.root']
nnoremap <leader>/ :CtrlPLine<space>%<enter>

set wildignore+=*.mat,*.pdfpc,*/tmp/*,*.so,*.swp,*.zip,*.aux,*.gz,*.fdb_latexmk,*.fls,*.log,*.pdf,*.glg,*.glo,*.ist,*.bcf,*.bbl,*.blg,*.gls,*.run.xml,*.toc,*.acn,*.acr,*.alg,*.ntn,*.slo,*.not,*.nlg,*.slg,*.sls,*.lof,*.lot,*.lol

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(mat|pdfpc|latexmain|gitignore|root|exe|so|dll|aux|gz|fdb_latexmk|fls|log|pdf|run|blg|toc|bcf|run\.xml|bbl|snm|nav|glg|gls|glo|ist|acn|acr|alg|ntn|slo|not|nlg|slg|sls|lof|lot|lol)$',
            \ }

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]_minted',
            \ 'file': '\v\.(out)$',
            \ }

let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \}

"" vim-workspace
" nnoremap <leader>s :ToggleWorkspace<CR>

"" lightline
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],
      \             [ 'neomake' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \   'paste': 'LightlinePaste',
      \   'neomake': 'LightlineNeomake',
      \ },
      \ 'component_type': {
      \   'paste': 'warning',
      \   'neomake': 'error',
      \ },
      \ }

function! LightlinePaste()
    return '%{&paste?"PASTE":""}'
endfunction

function! LightlineNeomake()
    return '%{neomake#statusline#LoclistStatus()}'
endfunction

"" vim-markdown
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 0

autocmd FileType markdown nnoremap <localleader>lt :Toc<Enter>

"" neomake
" When writing a buffer.
call neomake#configure#automake('w')

" colors
hi NeomakeWarningDefault cterm=underline ctermfg=0 ctermbg=11 gui=undercurl guisp=orangered
hi SignColumn term=standout ctermfg=14 ctermbg=None guifg=Cyan guibg=Grey
hi NeomakeWarningSignDefault ctermfg=15 guifg=orangered guibg=Grey
hi NeomakeWarningSign ctermfg=15 guifg=orangered guibg=Grey

" enabled makers
let g:neomake_python_enabled_makers = ['python', 'flake8']

"" Multiple cursors
" highlighting
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

"" indentline
let g:indentLine_fileTypeExclude = ['vimwiki', 'markdown']
let g:indentLine_setConceal = 0

"" tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

"" iron
" deactivate default mappings
let g:iron_map_defaults=0
" define custom mappings for the python filetype
augroup ironmapping
    autocmd!
    autocmd FileType python nmap <buffer> <localleader>r :call<space>SetReplSize()<enter>:IronRepl<Enter><C-\><C-n><C-W>p
    autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
    autocmd FileType python nmap <buffer> <F5> :w<enter>:call<space>IronSend('run<space><C-r>%')<enter>
    autocmd FileType python imap <buffer> <F5> <C-o>:w<enter><C-o>:call<space>IronSend('run<space><C-r>%')<enter>
augroup END

" set repl size
function! SetReplSize()
    " if winwidth(0)>99
        " let g:iron_repl_open_cmd = '50vsplit'
    " else
    let g:iron_repl_open_cmd = '10split'
    " endif
endfunction

"" echodoc
let g:echodoc#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
