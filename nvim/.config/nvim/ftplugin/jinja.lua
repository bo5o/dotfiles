-- jump between {% block %} ... {% endblock %} pairs with % (matchit)
vim.b.match_words = [[{%[-+]\? *\%(end\)\@!\(\w\+\)\>.\{-}%}:{%[-+]\? *end\1\>.\{-}%}]]
