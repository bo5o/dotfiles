; Replaces (not extends) nvim-treesitter's just injections to add support for
; `[script("lang")]` recipe attributes, which need an exclusion in the default
; bash rule below (queries cannot negate a sibling pattern structurally, hence
; the text-based #not-lua-match? on the whole recipe)

((comment) @injection.content
  (#set! injection.language "comment"))

; The right side of =~ literals
(regex_literal
  (_) @injection.content
  (#set! injection.language "regex"))

; Default to bash highlighting for non-shebang recipes and commands, unless
; the recipe language is set with a `[script(...)]` attribute
((recipe
  (recipe_body
    !shebang) @injection.content) @_recipe
  (#not-lua-match? @_recipe "%[[^%]\n]*script")
  (#set! injection.include-children)
  (#set! injection.language "bash"))

(external_command
  (command_body) @injection.content
  (#set! injection.language "bash"))

; Recipes with a `[script("lang")]` attribute are written in that language;
; the #offset! strips the quotes from the attribute argument
(recipe
  (attribute
    (identifier) @_attr
    .
    argument: (string) @injection.language)
  (recipe_body) @injection.content
  (#eq? @_attr "script")
  (#offset! @injection.language 0 1 0 -1)
  (#set! injection.include-children))

; For shebang recipes, use the shebang executable name as the language by default
(recipe
  (recipe_body
    (shebang
      (language) @injection.language)) @injection.content
  (#not-any-of? @injection.language "python3" "nodejs" "node")
  (#set! injection.include-children))

; python3 -> python
(recipe
  (recipe_body
    (shebang
      (language) @_lang)) @injection.content
  (#eq? @_lang "python3")
  (#set! injection.language "python")
  (#set! injection.include-children))

; node/nodejs -> javascript
(recipe
  (recipe_body
    (shebang
      (language) @_lang)) @injection.content
  (#any-of? @_lang "node" "nodejs")
  (#set! injection.language "javascript")
  (#set! injection.include-children))
