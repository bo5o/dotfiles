; extends

((string_content) @injection.content
  (#match? @injection.content
    "^\\s*(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set)")
  (#set! injection.language "sql"))
