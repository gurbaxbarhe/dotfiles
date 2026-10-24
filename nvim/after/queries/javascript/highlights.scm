;; extends
; GitHub Dark parity rules. Every pattern below was validated against this
; language's grammar; rules that do not apply to it are omitted.

(formal_parameters (identifier) @variable.parameter)
(formal_parameters (rest_pattern (identifier) @variable.parameter))
(formal_parameters (assignment_pattern left: (identifier) @variable.parameter))
(formal_parameters (array_pattern (identifier) @variable.parameter))
(formal_parameters (object_pattern (shorthand_property_identifier_pattern) @variable.parameter))
(arrow_function parameter: (identifier) @variable.parameter)
(regex "/" @string.regexp.delimiter)
(spread_element "..." @operator)
(rest_pattern "..." @operator)
((member_expression property: (property_identifier) @constant) (#any-of? @constant "length" "prototype" "constructor" "__proto__"))
(((["${" "}" "(" ")" "," "." "[" "]"]) @string) (#has-ancestor? @string template_substitution))
((property_identifier) @constant (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))
(object_pattern (pair_pattern key: (property_identifier) @ghkey))
(lexical_declaration "const" (variable_declarator name: (identifier) @constant))
((member_expression object: (identifier) @_mod property: (property_identifier) @constant) (#eq? @_mod "module") (#eq? @constant "exports"))
