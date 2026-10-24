; GitHub Dark: upstream rainbow query, minus template_substitution, with every
; container guarded so brackets inside `${...}` keep the string color.
; inherits: typescript

((jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (identifier) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
               "</" @delimiter
               name: (identifier) @delimiter
               ">" @delimiter)) @container
 (#not-has-ancestor? @container template_substitution))

((jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (member_expression) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
              "</" @delimiter
               name: (member_expression) @delimiter
              ">" @delimiter)) @container
 (#not-has-ancestor? @container template_substitution))

((jsx_self_closing_element
  "<" @delimiter
  name: (identifier) @delimiter
  "/>" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

(
(jsx_self_closing_element
  "<" @delimiter
  name: (member_expression) @delimiter
  "/>" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))

((jsx_expression
  "{" @delimiter
  "}" @delimiter) @container
 (#not-has-ancestor? @container template_substitution))