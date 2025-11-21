; extends

; Match sh("command"), sh "command" or sh """command"""
(juxt_function_call
  function: (identifier) @func_name
  args: (argument_list
    (string
      (string_content) @injection.content))
  (#eq? @func_name "sh")
  (#set! injection.language "sh"))

; Match sh(script: "command", ...)
(function_call
  function: (identifier) @func_name
  args: (argument_list
    (map_item
      key: (identifier) @arg_key
      value: (string
        [
          (string_content)
          (interpolation)
        ] @injection.content)))
  (#eq? @func_name "sh")
  (#eq? @arg_key "script")
  (#set! injection.language "sh"))
