; GitHub Dark: upstream rainbow query, minus template_substitution, with every
; container guarded so brackets inside `${...}` keep the string color.
;;; This query only covers Javascript without any React support.  It exists so
;;; that Typescript query can inherit it.

((object
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((computed_property_name
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((statement_block
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((class_body
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((switch_body
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((arguments
  "(" @delimiter
  ")" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((formal_parameters
  "(" @delimiter
  ")" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((for_statement
  "(" @delimiter
  ")" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((for_in_statement
  "(" @delimiter
  ")" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((subscript_expression
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((named_imports
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((export_clause
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((object_pattern
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((array
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((array_pattern
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))



((catch_clause
  "(" @delimiter
  ")" @delimiter)  @container
 (#not-has-ancestor? @container template_substitution))



