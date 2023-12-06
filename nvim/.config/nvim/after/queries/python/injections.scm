; extends

(assignment
    right: (string) @sql
 (#match? @sql "[sS][eE][lL][eE][cC][tT].\{-}[fF][rR][oO][mM]")
)

(function_definition
 (block
  (expression_statement
   (string
    (string_content) @injection.content (#set! injection.language "rst")
   )
  )
 )
)
