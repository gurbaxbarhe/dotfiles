;; extends
; Match github.com: shorthand properties are plain, capitalised imports are orange
; and constructor is a method name. Priority beats LSP semantic tokens (125).
(shorthand_property_identifier) @variable
((import_specifier name: (identifier) @constructor)
  (#lua-match? @constructor "^[A-Z]") (#set! priority 130))
((method_definition name: (property_identifier) @function.method)
  (#eq? @function.method "constructor") (#set! priority 130))
