; extends

(macro_invocation
  macro: [
    (scoped_identifier
      name: (_) @_macro_name)
    (identifier) @_macro_name
  ]
  (token_tree
    (raw_string_literal) @injection.content)
  (#match? @_macro_name "query(_as|_scalar|)")
  (#offset! @injection.content 0 3 0 -2)
  (#set! injection.language "sql")
  (#set! injection.include-children))
