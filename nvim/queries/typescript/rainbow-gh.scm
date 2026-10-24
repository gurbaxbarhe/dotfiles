; GitHub Dark: upstream rainbow query, minus template_substitution, with every
; container guarded so brackets inside `${...}` keep the string color.
; inherits: javascript

((interface_body
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((enum_body
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((type_arguments
  "<" @delimiter
  ">" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((type_parameters
  "<" @delimiter
  ">" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((array_type
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((lookup_type
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((object_type
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((tuple_type
  "[" @delimiter
  "]" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))