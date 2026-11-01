;; extends
; Attributes are always blue; plain annotated classes are white, generics (Iterable[...]) stay
; orange; class-level fields are plain; builtin exceptions are orange unless called.
(attribute attribute: (identifier) @variable.member)
(type (identifier) @type.builtin)
(class_definition body: (block (expression_statement (assignment left: (identifier) @variable))))
((identifier) @type (#lua-match? @type "Error$"))
(call function: (identifier) @constructor (#lua-match? @constructor "^[A-Z]"))
