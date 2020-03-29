set encoding=utf-8
scriptencoding utf-8

""Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'            " nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'    " nerd tree git integration
Plug 'prabirshrestha/async.vim'       " lsp async support
Plug 'prabirshrestha/vim-lsp'         " lsp client
Plug 'mattn/vim-lsp-settings'         " lsp settings
Plug 'thomasfaingnaert/' .
            \ 'vim-lsp-snippets'      " lsp snippet support
Plug 'ncm2/ncm2'                      " auto completion
Plug 'roxma/nvim-yarp'                " yet another remote plugin
Plug 'ncm2/ncm2-bufword'              " complete words from current buffer
Plug 'fgrsnau/ncm2-otherbuf'          " complete words from other buffers
Plug 'ncm2/ncm2-tmux'                 " complete words from tmux panes
Plug 'ncm2/ncm2-path'                 " complete file paths
Plug 'ncm2/ncm2-jedi'                 " python completion source
Plug 'ncm2/ncm2-ultisnips'            " snippet completion source
Plug 'ncm2/ncm2-markdown-subscope'    " fenced code block detection in markdown
Plug 'ncm2/float-preview.nvim'        " nvim 0.4 floating window support
Plug 'ncm2/ncm2-vim-lsp'              " lsp integration
Plug 'machakann/vim-swap'             " swap items in comma separated lists
Plug 'yggdroot/indentline'            " indentation guides
Plug 'yggdroot/LeaderF', {
            \ 'do': './install.sh'
            \ }                       " fuzzy finder
Plug 'davidhalter/jedi-vim'           " python jedi
Plug 'vimwiki/vimwiki'                " wiki
Plug 'dense-analysis/ale'             " asynchronous linting engine
Plug 'cespare/vim-toml'               " toml
Plug 'tpope/vim-surround'             " simple quoting/parenthesizing
Plug 'tpope/vim-repeat'               " repeat almost anything
Plug 'tpope/vim-fugitive'             " git
Plug 'tpope/vim-rhubarb'              " fugitive github integration
Plug 'tpope/vim-dispatch'             " asynchronously run jobs
Plug 'tpope/vim-tbone'                " tmux basics
Plug 'tpope/vim-projectionist'        " project-specific configurations
Plug 'tpope/vim-eunuch'               " unix helpers
Plug 'tpope/vim-unimpaired'           " some useful keybindings
Plug 'tpope/vim-obsession'            " session management
Plug 'tpope/vim-jdaddy'               " json manipulation
Plug 'tpope/vim-endwise'              " wisely add end/endfunction/endif...
Plug 'tomtom/tcomment_vim'            " comment stuff out
Plug 'junegunn/gv.vim'                " git commit browser
Plug 'junegunn/goyo.vim'              " distraction free mode
Plug 'junegunn/fzf', {
            \ 'dir': '~/.fzf',
            \ 'do': './install --bin'
            \ }                       " fuzzy finder
Plug 'junegunn/fzf.vim'               " fzf integration
Plug 'rhysd/git-messenger.vim'        " show git commit under cursor
Plug 'airblade/vim-gitgutter'         " git diff in gutter
Plug 'lervag/vimtex'                  " LaTeX
Plug 'SirVer/UltiSnips'               " Snippets
Plug 'honza/vim-snippets'             " default snippets
Plug 'ludovicchabant/vim-gutentags'   " automate ctags
Plug 'vim-airline/vim-airline'        " nice status line
Plug 'RRethy/vim-hexokinase', {
            \ 'do': 'make hexokinase'
            \ }                       " highlight color literals
Plug 'Vimjas/vim-python-pep8-indent'  " pep8 indenting
Plug 'thaerkh/vim-workspace'          " workspace management
Plug 'mhinz/vim-startify'             " fancy start screen
Plug 'Valloric/ListToggle'            " toggle quickfix and location list
Plug 'brennier/quicktex'              " very quick latex writing
Plug 'justinmk/vim-sneak'             " sneak motion
Plug 'jpalardy/vim-slime'             " tmux repl
Plug 'MattesGroeger/vim-bookmarks'    " bookmarks
Plug 'jeetsukumaran/vim-pythonsense'  " python text objects
Plug 'tmsvg/pear-tree'                " auto-close (, {, [, etc.
Plug 'AndrewRadev/switch.vim'         " toggle special words (true/false etc.)
Plug 'ekalinin/Dockerfile.vim'        " Dockerfile syntax highlighting
Plug 'ryanoasis/vim-devicons'         " fancy glyphs
Plug 'lifepillar/vim-gruvbox8'        " colorscheme
Plug 'tmux-plugins/vim-tmux'          " syntax hightlighting etc for .tmux.conf
Plug 'raimon49/requirements.txt.vim'  " requirements.txt syntax highlighting
Plug 'AndrewRadev/splitjoin.vim'      " easily switch between single- and multi-line statements
Plug 'kovetskiy/sxhkd-vim'            " indent, highlight syntax and detect sxhkd config files
Plug 'mattn/emmet-vim'                " expanding html abbreviations
Plug 'mhinz/vim-grepper'              " integration of my favorite grepper
Plug 'liuchengxu/vista.vim'           " browse lsp symbols and tags
Plug 'janko/vim-test'                 " convenient test invocation
Plug 'cbows/pytest-vim-compiler'      " pytest output compiler
Plug 'machakann/vim-highlightedyank'  " Highlight yanked region
Plug 'numirias/semshi', {
            \ 'do': ':UpdateRemotePlugins'
            \ }                       " semantic syntax highlighting for python
Plug 'wellle/targets.vim'             " enhanced text objects
Plug 'tommcdo/vim-lion'               " align text by some character
Plug 'airblade/vim-rooter'            " automatically change to project root when opening files
Plug 'pangloss/vim-javascript'        " javascript syntax support
Plug 'HerringtonDarkholme/yats.vim'   " typescript syntax support
Plug 'posva/vim-vue'                  " vue file support
Plug 'Konfekt/FastFold'               " fast folding
Plug 'tmhedberg/SimpylFold'           " better python folding
Plug 'zhimsel/vim-stay'               " restore buffer views automaticaly
Plug 'unblevable/quick-scope'         " fast left-right movement (using f, F, t, T)

" Initialize plugin system
call plug#end()

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

let g:python_host_prog = $PYENV_ROOT . '/versions/py2nvim/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/py3nvim/bin/python'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 3 lines to the cursor - when moving vertically using j/k
set scrolloff=3
set sidescrolloff=1

" Turn on the WiLd menu
set wildmode=longest,list,full
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

set wildignore+=*.mat,*.pdfpc,*/tmp/*,*.so,*.swp,*.zip,*.aux,*.gz,*.fdb_latexmk,*.fls,
            \*.log,*.pdf,*.glg,*.glo,*.ist,*.bcf,*.bbl,*.blg,*.gls,*.run.xml,*.toc,
            \*.acn,*.acr,*.alg,*.ntn,*.slo,*.not,*.nlg,*.slg,*.sls,*.lof,*.lot,*.lol,
            \*.xdv,**/.venv/**,**/.tools/**,tags

"Always show current position
set ruler

" Highlight current line
set cursorline

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

" Disable automatic folding
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

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

set signcolumn=yes

" view options for saving/restoring views
set viewoptions=folds,cursor

" don't open folds when moving through paragraphs
set foldopen-=block

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Syntax highlighting is very slow for long lines
set synmaxcol=176

" colorscheme specific settings
let g:gruvbox_italics = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1

" Custom highlighting
function! MyHighlights() abort
    " Try to use more subdued colors in vimdiff mode
    highlight DiffAdd cterm=bold ctermfg=142 ctermbg=235 gui=NONE guifg=#b8bb26 guibg=#3c3c25
    highlight DiffChange cterm=bold ctermfg=108 ctermbg=235 gui=NONE guifg=#8ec07c guibg=#383228
    highlight DiffText cterm=NONE ctermfg=214 ctermbg=235 gui=NONE guifg=#fabd2f guibg=#483D28
    highlight DiffDelete cterm=bold ctermfg=167 ctermbg=235 gui=NONE guifg=#fb4934 guibg=#372827

    highlight PopupWindow guifg=#ebdbb2 guibg=#3c3836
    highlight CursorLine guibg=#32302f
    highlight CursorLineNr ctermfg=11 guifg=#fabd2f guibg=#32302f

    " Use Gruvbox colors for python semshi semantic highlighter
    hi semshiGlobal          ctermfg=167 guifg=#fb4934
    hi semshiImported        ctermfg=214 guifg=#fabd2f cterm=bold gui=bold
    hi semshiParameter       ctermfg=142 guifg=#98971a
    hi semshiParameterUnused ctermfg=106 guifg=#a89984
    hi semshiBuiltin         ctermfg=208 guifg=#fe8019
    hi semshiAttribute       ctermfg=108 guifg=fg
    hi semshiSelf            ctermfg=109 guifg=#83a598
    hi semshiSelected        ctermfg=231 guifg=#fbf1c7 ctermbg=161 guibg=#cc241d

    hi GitGutterAdd          ctermbg=NONE guibg=NONE
    hi GitGutterChange       ctermbg=NONE guibg=NONE
    hi GitGutterDelete       ctermbg=NONE guibg=NONE
    hi GitGutterChangeDelete ctermbg=NONE guibg=NONE

    hi ALEErrorSign          ctermbg=NONE guibg=NONE
    hi ALEWarningSign        ctermbg=NONE guibg=NONE
    hi ALEInfoSign           ctermbg=NONE guibg=NONE

    hi link LspErrorText            ALEErrorSign
    hi link LspWarningText          ALEWarningSign
    hi link LspInformationText      ALEInfoSign
    hi link LspHintText             ALEInfoSign

    hi link LspErrorHighlight       ALEError
    hi link LspWarningHighlight     ALEWarning
    hi link LspInformationHighlight ALEInfo
    hi link LspHintHighlight        ALEInfo

    hi link LspErrorLine            ALEErrorLine
    hi link LspWarningLine          ALEWarningLine
    hi link LspInformationLine      ALEInfoLine
    hi link LspHintLine             ALEInfoLine

    hi lspReference guibg=#3c3836 gui=bold

    hi QuickScopePrimary guifg=#fe8019 gui=bold ctermfg=155 cterm=underline
    hi QuickScopeSecondary guifg=#d65d0e gui=bold ctermfg=81 cterm=underline

    hi Sneak guifg=#ebdbb2 guibg=#b16286 ctermfg=15 ctermbg=201
    hi SneakScope guifg=#3c3836 guibg=#fbf1c7 ctermfg=0 ctermbg=255

endfunction

augroup my_colors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

set termguicolors
set background=dark
colorscheme gruvbox8

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
    autocmd FileType yaml,html,css,javascript,typescript,son,vue,tex,bib setlocal tabstop=2
    autocmd FileType yaml,html,css,javascript,typescript,json,vue,tex,bib setlocal shiftwidth=2
    autocmd FileType javascript setlocal foldmethod=syntax
    autocmd FileType vue setlocal foldmethod=indent
    autocmd FileType markdown setlocal textwidth=80
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType requirements setlocal commentstring=#\ %s
    autocmd BufRead,BufNewFile *COMMIT_EDITMSG setlocal tw=72
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

" Re-open last closed buffer
map <leader>X :e#<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

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

" search and replace
nnoremap <leader>S :%s//g<Left><Left>

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
        \'Section: general' : 'COMMENT',
            \';pd'    : "import pandas as pd",
            \';plt'    : "import matplotlib.pyplot as plt",
            \';np'    : "import numpy as np",
            \';#'    : " # ",
            \}

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
            \ { 't': '~/.tmux.conf' },
            \ { 'z': '~/.zshrc' }
            \ ]
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_fortune_use_unicode = 1
let g:startify_files_number = 4
let g:startify_custom_indices = ['1', '2', '3', '4', '7', '8', '9', '0']
let g:startify_commands = [
            \   { 'up': [ 'Update plugins', ':PlugUpdate' ] },
            \   { 'ug': [ 'Upgrade plugin manager', ':PlugUpgrade' ] },
            \ ]

"" Emmet
let g:user_emmet_install_global = 0
augroup emmet_init
    autocmd!
    autocmd FileType html,htmldjango,css,vue EmmetInstall
augroup END

"" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gcc :Gcommit<CR>
nnoremap <leader>gca :Gcommit --amend<CR>
nnoremap <leader>gw :Gwrite<CR>

"" git messenger
hi gitmessengerPopupNormal term=None guifg=#ebdbb2 guibg=#32302f ctermfg=None ctermbg=None

"" vim-lion
let g:lion_squeeze_spaces = 1
let g:lion_map_right = 'ga'
let g:lion_map_left = 'gA'

"" vista.vim
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
            \ 'vue': 'vim_lsp',
            \ 'javascript': 'vim_lsp',
            \ 'typescript': 'vim_lsp',
            \ 'json': 'vim_lsp',
            \ 'vimwiki': 'markdown',
            \ 'markdown': 'toc',
            \ }
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_stay_on_open = 0
let g:vista#renderer#enable_icon = 1

nnoremap <silent> <leader>fa :Vista!!<CR>
nnoremap <silent> <leader>fA :Vista show<CR>
nnoremap <silent> <leader>fs :Vista finder<CR>

"" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
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
            \ 'nearest':   '--pdb',
            \}

"" dispatch
" send all command to this tmux session
let g:tmux_session = 'aux'

" Send certain key combinations to g:tmux_session
nmap <silent> t<CR> :call execute("Tmux send-keys -t " . g:tmux_session . " Enter")<CR>
nmap <silent> t<C-c> :call execute("Tmux send-keys -t " . g:tmux_session . " C-c")<CR>
nmap <silent> t<C-d> :call execute("Tmux send-keys -t " . g:tmux_session . " C-d")<CR>

"" nerd tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <leader>fT :NERDTreeFind<CR>
nnoremap <leader>ft :NERDTreeToggle<CR>

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
            \ '\.synctex\(busy\)$', '^py.typed$[[file]]'
            \]

"" grepper
nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>gr :Grepper -tool rg<cr>

let g:grepper = {}
let g:grepper.tools = ['git', 'rg']
let g:grepper.open = 1
let g:grepper.jump = 0
let g:grepper.dir = 'repo,file'
let g:grepper.quickfix = 0
let g:grepper.prompt_text = 'grepper $t> '

let g:grepper.rg = {
            \ 'escape': '\^$.*+?()[]{}|',
            \ 'grepformat': '%f:%l:%c:%m,%f',
            \ 'grepprg': 'rg -H --no-heading --hidden --glob=!.git -M=150 --max-columns-preview -S --vimgrep'
            \}
let g:grepper.git = {
            \ 'escape': '\^$.*[]',
            \ 'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
            \ 'grepprg': 'git grep -nGIi'
            \}

command! Todo silent Grepper
      \ -noprompt
      \ -tool rg
      \ -query '\b(todo|fixme)\b'
command! BufTodo silent Grepper
      \ -buffer
      \ -noprompt
      \ -tool rg
      \ -query '\b(todo|fixme)\b'

nnoremap <leader>gt :BufTodo<cr>
nnoremap <leader>gT :Todo<cr>

"" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map <leader><leader> <Plug>Sneak_,

"" pear-tree
" TODO: Find a way to keep dot repeatability without breaking
" insmode-completion and snippet expansion.
" If it can't be done with tmsvg/pear-tree, cohama/lexima.vim might be an
" alternative.
" To workaround this issue, disable special mappings for now.
let g:pear_tree_map_special_keys = 0
imap <BS> <Plug>(PearTreeBackspace)

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

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

"" mundo
nnoremap <leader>u :MundoToggle<CR>

"" quick-scope
let g:qs_max_chars=176
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'startify']
let g:qs_lazy_highlight = 1

"" endwise
let g:endwise_no_mappings = 1

"" nvim completion manager / ncm2
augroup nvim_completion_manager
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" Press enter to trigger snippet expansion or accept completed item
imap <expr> <CR> pumvisible()
                    \ ? ncm2_ultisnips#completed_is_snippet()
                        \ ? "\<Plug>(ncm2_ultisnips_expand_completed)"
                        \ : "\<C-y>\<CR>\<Plug>DiscretionaryEnd"
                    \ : "\<CR>\<Plug>DiscretionaryEnd"

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ncm vimtex
augroup ncm_vimtex_setup
    autocmd!
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

let g:jedi#goto_command = 'gd'
let g:jedi#goto_assignments_command = ''
let g:jedi#goto_stubs_command = ''
let g:jedi#goto_definitions_command = ''
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = 'gr'
let g:jedi#completions_command = ''
let g:jedi#rename_command = '<leader>rn'

"" fzf.vim
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg
                \ --column
                \ --line-number
                \ --no-heading
                \ --color=always
                \ --max-columns=150
                \ --max-columns-preview
                \ --smart-case
                \ --hidden
                \ --glob=!.git '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <C-Space> <plug>(fzf-complete-line)

noremap <leader>fr :Rg<CR>
noremap <leader>fl :BLines<CR>
noremap <leader>fg :BTags<CR>
noremap <leader>fG :Tags<CR>
noremap <leader>fc :BCommits<CR>
noremap <leader>fC :Commits<CR>

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
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = ''

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
let g:airline_theme='gruvbox8'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffer_min_count = 2

"" hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_refreshEvents = ['InsertLeave', 'BufEnter', 'BufWrite']
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'vim']

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

"" indentline
let g:indentLine_fileTypeExclude = ['vimwiki', 'markdown']
let g:indentLine_setConceal = 0
let g:indentLine_char = '┊'

"" leaderF
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_IgnoreCurrentBufferName = 0
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_RootMarkers = ['.root', '.projections.json', '.git', '.hg', '.svn', '.venv']
let g:Lf_MruFileExclude = ['COMMIT_EDITMSG']

let g:Lf_ShortcutF = '<leader>ff'
let g:Lf_ShortcutB = '<leader>fb'
nnoremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>

let g:Lf_RgConfig = [
            \ '--max-columns=150',
            \ '--max-columns-preview',
            \ '--ignore-case',
            \ '--hidden',
            \ '--glob=!.git'
            \ ]

noremap <leader>8 :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>* :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>

let g:Lf_CommandMap = {
            \ '<C-K>': ['<Up>'],
            \ '<C-J>': ['<Down>'],
            \ '<C-]>': ['<C-\>']
            \}

let g:Lf_PreviewResult = {
            \ 'File': 0,
            \ 'Buffer': 0,
            \ 'Mru': 0,
            \ 'Tag': 0,
            \ 'BufTag': 1,
            \ 'Function': 1,
            \ 'Line': 0,
            \ 'Colorscheme': 0,
            \ 'Rg': 0,
            \ 'Gtags': 0
            \}

" gruvbox colors for leaderF
let g:Lf_PopupPalette = {
            \  'dark': {
            \      'Lf_hl_popup_window': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#ebdbb2',
            \                'guibg': '#32302f',
            \                'cterm': 'NONE',
            \                'ctermfg': '255',
            \                'ctermbg': '237'
            \              },
            \      'Lf_hl_cursorline': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': 'NONE',
            \                'guibg': '#3c3836',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_match': {
            \                'gui': 'bold',
            \                'font': 'NONE',
            \                'guifg': '#83a598',
            \                'guibg': 'NONE',
            \                'cterm': 'bold',
            \                'ctermfg': '14',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_inputText': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#ebdbb2',
            \                'guibg': '#32302f',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_blank': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': 'NONE',
            \                'guibg': '#3c3836',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': '239'
            \              },
            \      'Lf_hl_popup_cwd': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#3c3836',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_total': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_lineInfo': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#3c3836',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_normalMode': {
            \                'gui': 'bold',
            \                'font': 'NONE',
            \                'guifg': '#282828',
            \                'guibg': '#a89984',
            \                'cterm': 'bold',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_inputMode': {
            \                'gui': 'bold',
            \                'font': 'NONE',
            \                'guifg': '#282828',
            \                'guibg': '#83a598',
            \                'cterm': 'bold',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_fullPathMode': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_category': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_fuzzyMode': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_regexMode': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      'Lf_hl_popup_nameOnlyMode': {
            \                'gui': 'NONE',
            \                'font': 'NONE',
            \                'guifg': '#a89984',
            \                'guibg': '#504945',
            \                'cterm': 'NONE',
            \                'ctermfg': 'NONE',
            \                'ctermbg': 'NONE'
            \              },
            \      }
            \  }
highlight def link Lf_hl_selection Search

"" highglightyank
let g:highlightedyank_highlight_duration = 300

"" semshi
let g:semshi#mark_selected_nodes=0
let g:semshi#error_sign=v:false

"" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_info = ""

let g:ale_pattern_options = {
            \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
            \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
            \ '\.git\/.*$': {'ale_linters': [], 'ale_fixers': []},
            \ 'crontab$': {'ale_linters': [], 'ale_fixers': ['trim_whitespace']},
            \}

nmap <leader>ad <Plug>(ale_detail)
nmap <leader>aa <Plug>(ale_toggle)

let g:ale_linters = {
            \   'python': ['flake8', 'mypy', 'pylint'],
            \   'tex': ['chktex'],
            \   'sql': ['sqlint'],
            \   'Dockerfile': ['hadolint', 'dockerfile_lint'],
            \   'yaml': ['yamllint'],
            \   'javascript': ['eslint'],
            \   'typescript': ['eslint', 'tsserver'],
            \   'vue': ['eslint'],
            \   'json': ['jsonlint'],
            \   'sh': ['shellcheck'],
            \   'zsh': ['shellcheck'],
            \   'vim': ['vint'],
            \}

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['black', 'isort'],
            \   'yaml': ['prettier'],
            \   'html': ['prettier'],
            \   'htmldjango': ['html-beautify'],
            \   'css': ['prettier'],
            \   'javascript': ['eslint'],
            \   'typescript': ['eslint'],
            \   'vue': ['eslint'],
            \   'json': ['prettier'],
            \   'tex': ['latexindent'],
            \   'sql': ['pgformatter'],
            \}

"" vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gD <Plug>(lsp-peek-definition)
    nmap <buffer> gy <Plug>(lsp-declaration)
    nmap <buffer> gY <Plug>(lsp-peek-declaration)
    nmap <buffer> gp <Plug>(lsp-type-definition)
    nmap <buffer> gP <Plug>(lsp-peek-type-definition)
    nmap <buffer> gr <Plug>(lsp-references)
    nmap <buffer> gi <Plug>(lsp-implementation)
    nmap <buffer> gI <Plug>(lsp-peek-implementation)
    nmap <buffer> K <Plug>(lsp-hover)
    nmap <buffer> <leader>rn <Plug>(lsp-rename)
    nmap <buffer> <leader>ra <Plug>(lsp-code-action)

    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>L <plug>(lsp-document-diagnostics)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that have a server registered
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_signature_help_enabled = 1
let g:lsp_preview_float = 1

let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 0

let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': g:ale_sign_error}
let g:lsp_signs_warning = {'text': g:ale_sign_warning}
let g:lsp_signs_hint = {'text': ale_sign_info}

augroup lsp_float_colours
    autocmd!
    if has('nvim')
        autocmd User lsp_float_opened
                    \ call nvim_win_set_option(
                    \   lsp#ui#vim#output#getpreviewwinid(),
                    \   'winhighlight', 'Normal:PopupWindow')
    endif
augroup end

"" vim-slime
let g:slime_target = 'tmux'
let g:slime_python_ipython = 1

augroup slime_keys
    autocmd!
    autocmd FileType python nmap <buffer> <F5> :w<cr>:exec "SlimeSend1 " . "run -m " . substitute(expand("%:r"), "\/", "\.", "g")<cr>
    autocmd FileType python imap <buffer> <F5> <C-o>:w<cr><C-o>:exec "SlimeSend1 " . "run -m " . substitute(expand("%:r"), "\/", "\.", "g")<cr>
augroup END

"" vim javascript
let g:javascript_plugin_jsdoc = 1

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
