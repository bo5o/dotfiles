" map <Leader>s to start IPython
nnoremap <c-c><c-s> :SlimeSend1 ipython<CR>
nnoremap <c-c><c-f> :IPythonCellRun<CR>
nnoremap <c-c><c-t> :IPythonCellRunTime<CR>
nnoremap <c-c><c-x> :IPythonCellExecuteCellVerbose<CR>
nnoremap <c-c><c-j> :IPythonCellExecuteCellVerboseJump<CR>

" map <Leader>l to clear IPython screen
nnoremap <c-c><c-l> :IPythonCellClear<CR>

nnoremap [C :IPythonCellPrevCell<CR>
nnoremap ]C :IPythonCellNextCell<CR>

" vim-doge custom numpy style
" (mainly just putting summary on first line)
let b:doge_patterns['numpy'] = [
            \   {
            \     'template': [
            \       '"""!summary',
            \       '',
            \       '!description',
            \       '%(parameters|)%',
            \       '%(parameters|Parameters)%',
            \       '%(parameters|----------)%',
            \       '%(parameters|{parameters})%',
            \       '%(returnType|)%',
            \       '%(returnType|Returns)%',
            \       '%(returnType|-------)%',
            \       '%(returnType|{returnType}:)%',
            \       '%(returnType|\t!description)%',
            \       '%(exceptions|)%',
            \       '%(exceptions|Raises)%',
            \       '%(exceptions|------)%',
            \       '%(exceptions|{exceptions})%',
            \       '"""'
            \   ],
            \     'nodeTypes': [ 'function_definition' ],
            \     'parameters': { 'format': [ '{name} : {type|!type}', '\t!description' ] },
            \     'exceptions': { 'format': [ '{name|!name}:', '\t!description' ] }
            \   }
            \ ]
