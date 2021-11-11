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
