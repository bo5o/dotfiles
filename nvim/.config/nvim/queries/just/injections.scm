; Replaces (not extends) nvim-treesitter's just injections to add support for
; `[script("lang")]` recipe attributes, which need an exclusion in the default bash rule
; below (queries cannot negate a sibling pattern structurally, hence the text-based
; #not-lua-match? on the whole recipe)
;
; NOTE: since this file fully shadows the upstream queries, diff it against
; https://github.com/nvim-treesitter/nvim-treesitter/blob/main/runtime/queries/just/injections.scm
; every once in a while and port over any changes (based on upstream as of 2026-08; only
; the bash-default exclusion and the script attribute rule are local additions).
; Upstream may eventually gain `[script(...)]` support itself, at which point this file
; can likely be deleted. Watch https://github.com/casey/tree-sitter-just/pull/211, which
; adds injections for the bare `[script]` attribute (via `set script-interpreter`) but
; not the inline `[script("lang")]` form handled here; it also exposes string_content
; nodes, which would make the #offset! quote-stripping below unnecessary once
; nvim-treesitter bumps its pinned just revision.
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
