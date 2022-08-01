" Must be loaded before any plugin
lua require("impatient")

"" Plugins
lua require("plugins")

"" Settings
lua require("settings")

"" Keybinds
lua require("keybinds")

"" Snippets
lua require("snippets")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
