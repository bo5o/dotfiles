; extends

((string_content) @injection.content
  (#match? @injection.content
    "^\\s*(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set)")
  (#set! injection.language "sql"))

(function_definition
  (block
    (expression_statement
      (string
        (string_content) @injection.content
        (#set! injection.language "rst")
        (#set! injection.indent 4)))))
