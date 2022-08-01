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
