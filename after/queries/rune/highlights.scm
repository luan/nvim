; Basic Rune highlights for zhuhaow/tree-sitter-rune.

(comment) @comment

[
  "async"
  "break"
  "const"
  "continue"
  "else"
  "enum"
  "fn"
  "for"
  "if"
  "impl"
  "in"
  "let"
  "loop"
  "match"
  "mod"
  "pub"
  "return"
  "struct"
  "use"
  "while"
] @keyword

[
  "crate"
  "self"
  "super"
] @variable.builtin

(boolean) @boolean
(integer) @number
(float) @number.float
(char) @character
(byte) @character.special
(static_string) @string
(template_literal) @string
(template_chars) @string
(unit) @constant.builtin

(fn_declaration
  name: (identifier) @function)

(call_expression
  function: (_) @function.call)

(macro_invocation
  macro: (path) @function.macro)

(struct_declaration
  name: (identifier) @type)

(enum_declaration
  name: (identifier) @type)

(enum_variant
  name: (identifier) @constructor)

(impl_declaration
  name: (path) @type)

(module_declaration
  name: (identifier) @module)

(parameter
  name: (identifier) @variable.parameter)

(let_statement
  name: (identifier) @variable)

(const_statement
  name: (identifier) @constant)

(loop_label
  name: (identifier) @label)

(identifier) @variable

[
  "!"
  "!="
  "%"
  "%="
  "&"
  "&&"
  "&="
  "*"
  "*="
  "+"
  "+="
  "-"
  "-="
  ".."
  "..="
  "/"
  "/="
  "<"
  "<<"
  "<<="
  "<="
  "="
  "=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  "?"
  "^"
  "^="
  "|"
  "|="
  "||"
] @operator

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  ","
  "."
  ":"
  "::"
  ";"
] @punctuation.delimiter
