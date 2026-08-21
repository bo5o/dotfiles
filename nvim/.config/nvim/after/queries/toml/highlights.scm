; extends

; Conceal age-encrypted values, keeping the first few characters, e.g.
; `value = "YWdlLWVu…"`. Every age file starts with the fixed header
; `age-encryption.org/v1\n`, whose first 21 bytes align to a base64 group boundary,
; so its base64 always begins with `YWdlLWVuY3J5cHRpb24ub3JnL3Yx`. This only shows
; where `conceallevel` is set, which after/ftplugin/toml.lua does for fnox files
((pair
  (bare_key) @_key
  (string) @_secret)
  (#eq? @_key "value")
  (#lua-match? @_secret "^\"YWdlLWVuY3J5cHRpb24ub3JnL3Yx")
  ; keep the quote and 8 chars, drop the closing quote
  (#offset! @_secret 0 9 0 -1)
  (#set! @_secret conceal "…"))
