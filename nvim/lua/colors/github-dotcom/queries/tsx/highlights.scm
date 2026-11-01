;; extends
; Priority 130 beats LSP semantic tokens (125).
(shorthand_property_identifier) @variable
(optional_chain) @punctuation.delimiter
(spread_element "..." @punctuation.delimiter)
(rest_pattern "..." @punctuation.delimiter)
(regex "/" @operator)
((identifier) @constructor (#lua-match? @constructor "^[A-Z].*[a-z]") (#set! priority 130))
((private_property_identifier) @variable (#set! priority 130))
((method_definition name: (property_identifier) @function.method)
  (#eq? @function.method "constructor") (#set! priority 130))
((property_signature name: (property_identifier) @property) (#set! priority 130))
((method_signature name: (property_identifier) @property) (#set! priority 130))
(type_arguments ["<" ">"] @operator)
(type_parameters ["<" ">"] @operator)
(union_type "|" @operator)
(intersection_type "&" @operator)
(infer_type "infer" @variable)
((predefined_type) @keyword (#eq? @keyword "void") (#set! priority 130))
((as_expression "const" @keyword) (#set! priority 130))
(jsx_closing_element "</" @punctuation.bracket)
(jsx_self_closing_element "/>" @punctuation.bracket)
