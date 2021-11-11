set encoding=utf-8
scriptencoding utf-8

""Plugins
lua require("plugins")

" Function to source only if file exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let mapleader = ','
let g:mapleader = ','

" Fast saving
nmap <leader>w :w!<cr>

set relativenumber
set number
set clipboard=unnamedplus

let g:python_host_prog = $HOME . '/.virtualenvs/py2nvim/bin/python'
let g:python3_host_prog = $HOME . '/.virtualenvs/py3nvim/bin/python'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 3 lines to the cursor - when moving vertically using j/k
set scrolloff=8
set sidescrolloff=1

" Turn on the WiLd menu
set wildmode=longest,list,full
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

set wildignore+=*.mat,*.pdfpc,*/tmp/*,*.so,*.swp,*.zip,*.aux,*.gz,*.fdb_latexmk,*.fls,
            \*.log,*.pdf,*.glg,*.glo,*.ist,*.bcf,*.bbl,*.blg,*.gls,*.run.xml,*.toc,
            \*.acn,*.acr,*.alg,*.ntn,*.slo,*.not,*.nlg,*.slg,*.sls,*.lof,*.lot,*.lol,
            \*.xdv,**/.venv/**,**/.direnv/**,**/.tools/**,tags

" Always show current position
set ruler

" Enable mouse in normal mode
set mouse=n

" Highlight current line
set cursorline

" Highlight column at 88 chars
set colorcolumn=88

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

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


" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set nofoldenable
set foldlevelstart=99

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" More natural split opening
set splitbelow
set splitright

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

set completeopt=noinsert,menuone,noselect

set signcolumn=yes

" view options for saving/restoring views
set viewoptions=cursor,folds

" don't open folds when moving through paragraphs
set foldopen-=block

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Syntax highlighting is very slow for long lines
set synmaxcol=176

" " colorscheme specific settings
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_sign_column_background = 'none'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_diagnostic_line_highlight = 0
let g:gruvbox_material_diagnostic_text_highlight = 1

" Custom highlighting
function! MyHighlights() abort
    hi PopupWindow guifg=#ebdbb2 guibg=#3c3836

    hi QuickScopePrimary guifg=#fe8019 gui=bold ctermfg=155 cterm=underline
    hi QuickScopeSecondary guifg=#d65d0e gui=bold ctermfg=81 cterm=underline
    hi NormalFloat guibg=#32302f
endfunction

augroup my_colors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

set termguicolors
set background=dark
colorscheme gruvbox-material

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile

set undofile
set undodir=~/.config/nvim/undodir

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

set autoindent
set smartindent
set nowrap " don't wrap lines

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" filetype settings
augroup filetype_settings
    autocmd!
    autocmd FileType python setlocal textwidth=88
    autocmd FileType yaml,html,css,javascript,typescript,json,vue,tex,bib,xml,vimwiki setlocal tabstop=2
    autocmd FileType yaml,html,css,javascript,typescript,json,vue,tex,bib,xml,vimwiki setlocal shiftwidth=2
    autocmd FileType vimwiki setlocal tabstop=4
    autocmd FileType vimwiki setlocal shiftwidth=4
    autocmd FileType vimwiki setlocal textwidth=88
    autocmd FileType markdown setlocal textwidth=88
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType requirements setlocal commentstring=#\ %s
    autocmd BufRead,BufNewFile *COMMIT_EDITMSG setlocal textwidth=80
    autocmd BufRead,BufNewFile .env.* setlocal filetype=sh
    autocmd FileType gitcommit setlocal textwidth=80
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close all buffers
map <leader>ba :bufdo bd<cr>

" Close all buffers (except current)
map <leader>bo :BufOnly<cr>

" Close current buffer and ignore unsaved changes
map <leader>bd :Bclose!<cr>

" Close current buffer if there are no unsaved changes
map <leader>x :Bclose<cr>

" Close preview window
nnoremap <c-w>pc :pclose<cr>
nnoremap <c-w>C :tabclose<cr>
nnoremap <c-w>O :tabonly<cr>

" Re-open last closed buffer
map <leader>X :e#<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" keep things centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" moving text
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
" inoremap <C-j> <esc>:m .+1<cr>==gi
" inoremap <C-k> <esc>:m .-2<cr>==gi

" quick replace
nnoremap cn *``cgn
nnoremap cN *``cgN

" go back to normal mode
inoremap jk <ESC>

" options for vim diff
set diffopt=vertical

" alt+hjkl for moving in insert mode
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

" open file under cursor in vertical split
nnoremap <C-W><C-F> <C-W>vgf

au TermOpen * setlocal nonumber norelativenumber

" terminal keybindings
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" ask before jump if ambigous
nnoremap <C-]> g<C-]>

" navigate quickfix relative to cursor
nmap <silent> [d :cabove<CR>
nmap <silent> ]d :cbelow<CR>

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

" paste from 0 register
nnoremap <leader>p "0p
nnoremap <leader>P "0P

" Navigating with guides
" inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>:call<space>search('<+.*+>')<CR>"_c/+>/e<CR>
nnoremap <Space><Space> :call<space>search('<+.*+>')<CR>"_c/+>/e<CR>
inoremap ;gui <++>

" Turn the word under cursor to upper case
inoremap <silent> <c-u> <Esc>viwUea

" Toggle search highlight, see https://goo.gl/3H85hh
nnoremap <silent><expr> <Leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Yank from current cursor position to the end of the line
nnoremap Y y$

" preview latex equations
" vnoremap <leader>m y:!python<space>~/bin/preview_math.py<space>'<C-r>"'<enter>

" bibtex
augroup bibtex_snippets
    autocmd!
    autocmd FileType bib inoremap <buffer> ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journaltitle<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i
    autocmd FileType bib inoremap <buffer> ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>6kA,<Esc>i
    autocmd FileType bib inoremap <buffer> ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i
augroup END

" Markdown (soon gonna replace this with quicktex shortcuts)
augroup markdown_snippets
    autocmd!
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
augroup END

" Latex
augroup latex_snippets
    autocmd!
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
augroup END

" restructured text
augroup restructured_text_snippets
    autocmd!
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
augroup END

" tikz
augroup tikz_snippets
    autocmd!
    autocmd FileType tex inoremap <buffer> ;tp    \begin{tikzpicture}[]<enter><++><enter>\end{tikzpicture}<Esc>2kf]i
    autocmd FileType tex inoremap <buffer> ;node  \node[]<space>(<++>)<space>at<space>(<++>)<space>{<++>};<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;draw  \draw[]<space>(<++>)<space><++><space>(<++>);<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;linu  \linunit[]{<++>}{<++>}<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;tanh  \tanhunit[]{<++>}{<++>}<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;sigm  \sigmunit[]{<++>}{<++>}<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;sum   \sumunit[]{<++>}{<++>}<Esc>F]i
    autocmd FileType tex inoremap <buffer> ;isec  \intersec[]{<++>}<Esc>F]i
augroup END

augroup buffer_settings
    autocmd!
    " psql
    au BufRead /tmp/psql.edit.* set syntax=sql
    " pass
    au BufRead */pass.*.txt set noundofile
    "sphinx
    autocmd BufRead */services/docs/*.rst set makeprg=make\ -f\ Makefile.docs\ html
augroup END

augroup underline_python_doc_section
    autocmd!
    autocmd FileType python inoremap ;- <Esc>Ypviwr-o
augroup END

" quicktex (or better 'quick_anything')
let g:quicktex_markdown = {
            \' '      : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \}

" vint: -ProhibitUnnecessaryDoubleQuote

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
            \';noqa'  : "# noqa: <+++>",
            \';par'   : "Parameters\<CR>----------\<CR>",
            \';params': "Parameters\<CR>----------\<CR>",
            \';args'  : "Parameters\<CR>----------\<CR>",
            \';ret'   : "Returns\<CR>-------\<CR>",
            \';rai'   : "Raises\<CR>------\<CR>",
            \';err'   : "Raises\<CR>------\<CR>",
            \';yie'   : "Yields\<CR>------\<CR>",
            \';att'   : "Attributes\<CR>----------\<CR>",
            \';catt'  : "Class Attributes\<CR>----------------\<CR>",
            \';exa'   : "Examples\<CR>--------\<CR>",
            \';not'   : "Notes\<CR>-----\<CR>",
            \';see'   : "See Also\<CR>--------\<CR>",
            \';key'   : "Keyword\<CR>-------\<CR>",
            \';Ref'   : "References\<CR>----------\<CR>",
            \';war'   : "Warning\<CR>-------\<CR>",
            \';oth'   : "Other\<CR>-----\<CR>",
            \';met'   : "Methods\<CR>-------\<CR>",
            \';exp'   : "Examples\<CR>--------\<CR>",
            \';obj'   : ":obj:`<+++>`<++>",
        \'Section: cross referencing' : 'COMMENT',
            \';ref'   : ":ref:`<+++>`<++>",
        \'Section: classes and functions' : 'COMMENT',
            \';cls'   : "class <+++>(<++>):\<CR><++>",
            \';class' : "class <+++>(<++>):\<CR><++>",
            \';defi'  : "def __init__(self, <+++>):\<CR><++>",
            \';defc'  : "@classmethod\<CR>def <+++>(cls, <++>):\<CR><++>",
            \';defs'  : "@staticmethod\<CR>def <+++>(<++>):\<CR><++>",
            \';def@'  : "@<+++>\<CR>def <++>(<++>):\<CR><++>",
            \';defm'  : "def <+++>(self, <++>):\<CR><++>",
            \';defm@'  : "@<+++>\<CR>def <++>(self, <++>):\<CR><++>",
            \';defp'  : "@property\<CR>def <+++>(self):\<CR><++>",
            \';defd'  : "def __<+++>__(self, <++>):\<CR><++>",
            \';def'  : "def <+++>(<++>):\<CR><++>",
            \';fun'   : "def <+++>(<++>):\<CR><++>",
            \';get'  : "@property\<CR>def <+++>(self):\<CR><++>",
            \';prop'  : "@property\<CR>def <+++>(self):\<CR><++>",
            \';set'  : "@<+++>.setter\<CR>def <++>(self, value):\<CR><++>",
        \'Section: keywords' : 'COMMENT',
            \';im'    : "import <+++>",
            \';bp'    : "breakpoint()<+++>",
            \';debug' : "breakpoint()<+++>",
            \';rt' : "reveal_type(<+++>)",
        \'Section: general' : 'COMMENT',
            \';pd'    : "import pandas as pd",
            \';plt'    : "import matplotlib.pyplot as plt",
            \';np'    : "import numpy as np",
            \';#'    : " # ",
            \';c'    : "# %%",
            \}

"" Javascript
let g:quicktex_javascript = {
            \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
        \'Section: docstrings' : 'COMMENT',
            \';tod' : "// TODO: <+++>",
        \'Section: functions' : 'COMMENT',
            \';af'  : "(<+++>) => {<++>}",
        \'Section: keywords' : 'COMMENT',
            \';im'  : 'import {<++>} from "<+++>"',
            \}

"" Typescript
let g:quicktex_typescript = extend(g:quicktex_javascript, {
            \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
        \'Section: functions' : 'COMMENT',
            \';taf'  : "\<<++>\>(<+++>): \<<++>\> => {<++>}",
            \})

"" LaTeX
let g:quicktex_tex = {
            \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
            \'m'   : "\( <+++> \) <++>",
        \'Section: Environments' : 'COMMENT',
            \'env':  "\<ESC>Bvedi\\begin{\<ESC>pa}\<CR><+++>\<CR>\\end{\<ESC>pa}",
            \'ol':   "\\begin{enumerate}\<CR>\\item <+++>\<CR>\\end{enumerate}",
            \'ul':   "\\begin{itemize}\<CR>\\item <+++>\<CR>\\end{itemize}",
            \'eqn':  "\\begin{equation*}\<CR><+++>\<CR>\\end{equation*}\<CR><++>",
            \'Eqn':  "\\begin{equation}\\label{<+++>}\<CR><++>\<CR>\\end{equation}\<CR><++>",
            \'frm':  "\\begin{frame}\<CR>\\frametitle{<+++>}\<CR><++>\<CR>\\end{frame}",
            \
        \'Section: Other Commands' : 'COMMENT',
            \'itm':     "\item ",
            \'chap':    "\\chapter{<+++>}\<CR><++>",
            \'sec':     "\\section{<+++>}\<CR><++>",
            \'ssec':    "\\subsection{<+++>}\<CR><++>",
            \'sssec':   "\\subsubsection{<+++>}\<CR><++>",
            \'para':    "(<+++>) <++>",
            \'todo':    "\\todo{<+++>}\<CR><++>",
            \'cmd':    "\<ESC>Bi\\\<ESC>Ea{<+++>}<++>",
            \'texroot': "%! TEX root = .",
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
            \';it'     : "\\textit{<+++>} <++>",
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
            \'phi'     : '\phi ',
            \'vphi'    : '\varphi ',
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

" vint: +ProhibitUnnecessaryDoubleQuote

" Vim-Anywhere
augroup vim_anywhere
    autocmd!
    autocmd BufRead,BufNewFile /tmp/vim-anywhere* set filetype=txt
augroup END

" Make calcurse notes markdown compatible:
augroup calcurse
    autocmd!
    autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
    autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
augroup END

" Insert date
inoremap ;dt <C-R>=strftime('%Y-%m-%d')<CR>
" nnoremap ;dt a<C-R>=strftime('%Y-%m-%d')<CR><Esc>

" indent/dedent in visual mode
vnoremap L >gv
vnoremap H <gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call SourceIfExists('~/.config/nvim/local-settings.vim')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Startify
let g:startify_list_order = ['files', 'dir', 'bookmarks', 'commands']
let g:startify_bookmarks = [
            \ { 'c': '~/.config/nvim/init.vim' },
            \ { 'g': '~/.gitconfig' },
            \ { 'p': '~/.oh-my-zsh/custom/p10k.zsh' },
            \ { 't': '~/.tmux.conf' },
            \ { 'z': '~/.zshrc' }
            \ ]
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_fortune_use_unicode = 1
let g:startify_files_number = 4
let g:startify_custom_indices = ['1', '2', '3', '4', '7', '8', '9', '0']
let g:startify_commands = [
            \   { 'up': [ 'Update plugins', ':PackerSync' ] },
            \ ]

"" Spectre
nnoremap <leader>S :lua require('spectre').open()<CR>
" search in current file
nnoremap <leader>ss viw:lua require('spectre').open_file_search()<cr>

"search current word
nnoremap <leader>sw viw:lua require('spectre').open_visual()<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>

"" harpoon
nnoremap <BS>m :lua require("harpoon.mark").add_file()<CR>
nnoremap <BS><BS> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <BS>n :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <BS>e :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <BS>i :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <BS>o :lua require("harpoon.ui").nav_file(4)<CR>

"" Emmet
let g:user_emmet_install_global = 0
augroup emmet_init
    autocmd!
    autocmd FileType html,htmldjango,css,vue EmmetInstall
augroup END

"" fugitive
nnoremap <leader>g<space> :Git<space>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gco :Git checkout<space>
nnoremap <leader>gcc :Git commit -v -q<CR>
nnoremap <leader>gca :Git commit --amend<CR>
nnoremap <leader>gct :Git commit -v -q %:p<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>gL :0Gllog<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gD :Gdiffsplit<space>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gP :Git push<CR>

"" git messenger
hi gitmessengerPopupNormal term=None guifg=#ebdbb2 guibg=#32302f ctermfg=None ctermbg=None

"" gitgutter
let g:gitgutter_preview_win_floating = 0

"" vim-lion
let g:lion_squeeze_spaces = 1
let g:lion_map_right = 'ga'
let g:lion_map_left = 'gA'

"" vim-rooter
let g:rooter_silent_chdir = 1
let g:rooter_cd_cmd = 'lcd'

let g:rooter_patterns = [
    \ '.root-marker',
    \ '.project-root',
    \ 'package.json',
    \ 'requirements.txt',
    \ 'setup.py',
    \ 'manage.py',
    \ 'pyproject.toml',
    \ '.git'
    \]

nnoremap <silent> <leader>os :SymbolsOutline<CR>

"" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <leader>tN :TestNearest<space>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <leader>tL :TestLast<space>
nmap <silent> <leader>tt :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

function! StartStrategy(cmd)
    execute 'Start -wait=always ' . a:cmd
endfunction

let g:test#custom_strategies = {'start': function('StartStrategy')}

let test#strategy = 'start'

let test#filename_modifier = ':p'

let g:test#python#pytest#file_pattern = '\.py'
let g:test#python#runner = 'pytest'
let g:test#python#pytest#options = {
            \ 'nearest':   '--pdb --pdbcls=IPython.terminal.debugger:TerminalPdb --no-cov',
            \ 'file':   '--no-cov',
            \ }
let g:test#javascript#runner = 'jest'

"" dispatch
" send dispatch commands to popup session
let g:tmux_session = 'popup'

"" vim-projectionist
let g:projectionist_heuristics = {
            \ 'setup.py|requirements.txt|pyproject.toml': {
            \   'scripts/*.py': {
            \       'type': 'script',
            \       'start': '-wait=always ipython --pdb {file}'
            \   },
            \   'src/*.py': {
            \       'type': 'source',
            \       'alternate': 'tests/unit/{dirname|basename}/test_{basename}.py',
            \       'start': '-wait=always ipython --pdb -m {dot}'
            \   },
            \   'tests/unit/**/test_*.py': {
            \       'type': 'test',
            \       'start': '{project}',
            \       'alternate': 'src/{project|basename}/{dirname}/{basename}.py'
            \   },
            \   'README.md': {
            \       'type': 'readme'
            \   },
            \   '.env': {
            \       'type': 'env'
            \   },
            \ }
            \ }

" Send certain key combinations to g:tmux_session
nmap <silent> t<CR> :call execute("Tmux send-keys -t " . g:tmux_session . " Enter")<CR>
nmap <silent> t<C-c> :call execute("Tmux send-keys -t " . g:tmux_session . " C-c")<CR>
nmap <silent> t<C-d> :call execute("Tmux send-keys -t " . g:tmux_session . " C-d")<CR>

"" nvim-tree
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ]
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_add_trailing = 1

nnoremap <leader>of :NvimTreeToggle<CR>
nnoremap <leader>oF :NvimTreeFindFile<CR>

"" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map <leader><leader> <Plug>Sneak_,

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

let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \}

"" quick-scope
let g:qs_max_chars=176
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'startify', 'qf']
let g:qs_lazy_highlight = 1

"" endwise
let g:endwise_no_mappings = 1

" Disable extra tmux complete trigger
let g:tmuxcomplete#trigger = ''

"" jedi
let g:jedi#completions_enabled = 0

let g:jedi#goto_command = 'gd'
let g:jedi#goto_assignments_command = ''
let g:jedi#goto_stubs_command = ''
let g:jedi#goto_definitions_command = ''
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<leader>ru'
let g:jedi#completions_command = ''
let g:jedi#rename_command = '<leader>rn'
let g:jedi#smart_auto_mappings = 0
let g:jedi#use_tag_stack = 1

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>
nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope file_browser<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope oldfiles<cr>
nnoremap <leader>fM <cmd>Telescope keymaps<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fS <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fg <cmd>Telescope treesitter<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fC <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
nnoremap <leader>fu <cmd>Telescope ultisnips<cr>
nnoremap <leader>fT <cmd>TodoTelescope<cr>

nnoremap <leader>Q <cmd>TroubleToggle<cr>
nnoremap <leader>qw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>qd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>qt <cmd>TodoTrouble<cr>
nnoremap <leader>ql <cmd>TroubleToggle loclist<cr>
nnoremap <leader>qq <cmd>TroubleToggle quickfix<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>

"" UltiSnips
let g:UltiSnipsExpandTrigger		= '<c-j>'
let g:UltiSnipsJumpForwardTrigger	= '<c-j>'
let g:UltiSnipsJumpBackwardTrigger	= '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit='vertical'
let g:ultisnips_python_style='numpy'

"" switch.vim
let g:switch_mapping = '-'

"" vimwiki
let g:vimwiki_list = [{
            \ 'path': '~/vimwiki/',
            \ 'syntax': 'markdown',
            \ 'ext': '.md',
            \ 'index': 'README'
            \ }]
let g:vimwiki_key_mappings = {
            \ 'all_maps': 1,
            \ 'global': 1,
            \ 'headers': 1,
            \ 'text_objs': 1,
            \ 'table_format': 1,
            \ 'table_mappings': 0,
            \ 'lists': 1,
            \ 'links': 1,
            \ 'html': 1,
            \ 'mouse': 0,
            \ }
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = ''
let g:vimwiki_markdown_link_ext = 1

"" taskwiki
let g:taskwiki_disable_concealcursor = 'yes'

nnoremap <silent> gb :BufferLinePick<CR>

"" airline
let g:airline_theme='gruvbox_material'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

"" vim-markdown
let g:markdown_syntax_conceal = 1
let g:markdown_minlines = 80
let g:markdown_fenced_languages = [
            \ 'js=javascript',
            \ 'typescript=javascript',
            \ 'ts=javascript',
            \ 'vue',
            \ 'python',
            \ 'html',
            \ 'help',
            \ 'c++=cpp',
            \ 'viml=vim',
            \ 'bash=sh',
            \ 'ini=dosini',
            \ 'json',
            \ 'yaml',
            \ ]

"" highlight yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

nnoremap <leader>cli <cmd>LspInfo<cr>
nnoremap <leader>clI :LspInstall<space>
nnoremap <leader>clr <cmd>LspRestart<cr>
nnoremap <leader>cla <cmd>Telescope lsp_code_actions<cr>

"" vim-slime
let g:slime_target = 'tmux'
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{bottom-left}'
            \ }

"" vim-ipython-cell
let g:ipython_cell_delimit_cells_by='tags'
" remaining config in `nvim/.config/nvim/after/ftplugin/python.vim`

"" jupyter-vim
let g:jupyter_mapkeys = 1

" Run current file
nnoremap <buffer> <silent> <localleader>R :JupyterRunFile<CR>
nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>

" Send a selection of lines
nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

"" vim-table-mode
let g:table_mode_map_prefix = '<localleader>t'

"" vim-floaterm
let g:floaterm_keymap_toggle = '<leader>ot'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_new    = '<leader>oT'

let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_opener='edit'

nnoremap <silent> <leader>og :FloatermNew lazygit<CR>
nnoremap <silent> <leader>or :FloatermNew ranger<CR>
nnoremap <silent> <leader>od :FloatermNew lazydocker<CR>
nnoremap <silent> <leader>om :FloatermNew btm -m<CR>
nnoremap <silent> <leader>ou :FloatermNew ncdu<CR>

nnoremap <silent> <leader>oD :DBUI<CR>

hi FloatermBorder ctermfg=0 ctermbg=13 guifg=#ebdbb2 guibg=None

"" vim-matchup
let g:matchup_transmute_enabled = 0 " covered by nvim-ts-autotag
let g:matchup_matchparen_offscreen = { 'method': 'popup' }

"" semshi
let g:semshi#error_sign = v:false

nmap <silent> <localleader>up :Semshi goto parameterUnused prev<CR>
nmap <silent> <localleader>un :Semshi goto parameterUnused next<CR>

"" gutentags
let g:gutentags_exclude_filetypes = ['gitcommit', 'requirements']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn formatted text into a python string
xnoremap <leader>x <esc>:'<,'>!sed -e '0,/^.*"\{3\}\\\?/s///' -e 's/"\{3\}$//' -e 's/\s\{4\}/\\t/g' -e 's/^/"/' -e 's/$/",/' -e '1i "\\n".join((' -e '$a ))'<cr>

" Close all buffer except the current one
command! BufOnly silent! execute "%bd|e#|bd#"

" Press: vai, vii to select outer/inner python blocks by indetation.
" Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
vnoremap <silent>ii <Esc>:call IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
    let curline = line('.')
    let lastline = line('$')
    let i = indent(line('.')) - &shiftwidth * (v:count1 - 1)
    let i = i < 0 ? 0 : i
    if getline('.') =~? "^\\s*$"
        return
    endif
    let p = line('.') - 1
    let nextblank = getline(p) =~? "^\\s*$"
    while p > 0 && (nextblank || indent(p) >= i )
        -
        let p = line('.') - 1
        let nextblank = getline(p) =~? "^\\s*$"
    endwhile
    if (!a:inner)
        -
    endif
    normal! 0V
    call cursor(curline, 0)
    let p = line('.') + 1
    let nextblank = getline(p) =~? '^\\s*$'
    while p <= lastline && (nextblank || indent(p) >= i )
        +
        let p = line('.') + 1
        let nextblank = getline(p) =~? '^\\s*$'
    endwhile
    if (!a:inner)
        +
    endif
    normal! $
endfunction

" Don't close window, when deleting a buffer
command! -bang Bclose call <SID>BufcloseCloseIt(<bang>0)
function! <SID>BufcloseCloseIt(bang)
    let l:currentBufNum = bufnr('%')
    let l:alternateBufNum = bufnr('#')

    if !&mod || a:bang
        if buflisted(l:alternateBufNum)
            buffer #
        else
            bnext
        endif
    endif

    if bufnr('%') == l:currentBufNum && !&mod
        new
    endif

    if buflisted(l:currentBufNum)
        if a:bang
            execute('bdelete! '.l:currentBufNum)
        else
            execute('bdelete '.l:currentBufNum)
        endif
    endif
endfunction
