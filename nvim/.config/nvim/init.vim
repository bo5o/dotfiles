set encoding=utf-8
scriptencoding utf-8

" must be loaded before any plugin
lua require("impatient")

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
set synmaxcol=256

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

"" vim-lion
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

" Send certain key combinations to g:tmux_session
nmap <silent> t<CR> :call execute("Tmux send-keys -t " . g:tmux_session . " Enter")<CR>
nmap <silent> t<C-c> :call execute("Tmux send-keys -t " . g:tmux_session . " C-c")<CR>
nmap <silent> t<C-d> :call execute("Tmux send-keys -t " . g:tmux_session . " C-d")<CR>

"" nvim-tree
nnoremap <leader>of :NvimTreeToggle<CR>
nnoremap <leader>oF :NvimTreeFindFile<CR>

"" sneak
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

" Disable extra tmux complete trigger
let g:tmuxcomplete#trigger = ''

"" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fF <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>
nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope file_browser<cr>
nnoremap <leader>fD <cmd>Telescope file_browser hidden=true<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope oldfiles<cr>
nnoremap <leader>fM <cmd>Telescope keymaps<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fS <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fC <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
nnoremap <leader>fu <cmd>Telescope ultisnips<cr>
nnoremap <leader>fT <cmd>TodoTelescope<cr>

nnoremap <leader>qq <cmd>TroubleToggle<cr>
nnoremap <leader>qf <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>ql <cmd>TroubleToggle loclist<cr>
nnoremap <leader>qt <cmd>TodoTrouble<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>
nnoremap <leader>qd <cmd>TroubleToggle lsp_definitions<cr>

"" bufferline
nnoremap <silent> gb :BufferLinePick<CR>

"" highlight yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

nnoremap <leader>cli <cmd>LspInfo<cr>
nnoremap <leader>clr <cmd>LspRestart<cr>
nnoremap <leader>cla <cmd>Telescope lsp_code_actions<cr>

"" vim-ipython-cell
" remaining config in `nvim/.config/nvim/after/ftplugin/python.vim`

" Run current file
nnoremap <buffer> <silent> <localleader>R :JupyterRunFile<CR>
nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>

" Send a selection of lines
nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

"" vim-floaterm
nnoremap <silent> <leader>og :FloatermNew lazygit<CR>
nnoremap <silent> <leader>or :FloatermNew ranger<CR>
nnoremap <silent> <leader>od :FloatermNew lazydocker<CR>
nnoremap <silent> <leader>om :FloatermNew btm -m<CR>
nnoremap <silent> <leader>ou :FloatermNew ncdu<CR>

nnoremap <silent> <leader>ol :LspInstallInfo<CR>

nnoremap <silent> <leader>oD :DBUI<CR>

hi FloatermBorder ctermfg=0 ctermbg=13 guifg=#ebdbb2 guibg=None

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
