; extends

(value_argument
  name: [
         (value_argument_label
           (simple_identifier) @_argument_name
           )
         ]
  value: [
          (multi_line_string_literal
            text: [(multi_line_str_text) @injection.content]
            )
          ]
  (#match? @_argument_name "sql")
  ; (#offset! @injection.content 0 3 0 -2)
  (#set! injection.language "sql")
  (#set! injection.include-children))
