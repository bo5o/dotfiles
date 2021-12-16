function! MyHighlights() abort
    hi PopupWindow guifg=#ebdbb2 guibg=#3c3836

    hi QuickScopePrimary guifg=#fe8019 gui=bold ctermfg=155 cterm=underline
    hi QuickScopeSecondary guifg=#d65d0e gui=bold ctermfg=81 cterm=underline
    hi NormalFloat guibg=#32302f
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END
