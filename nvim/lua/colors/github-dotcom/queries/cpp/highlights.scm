;; extends
; Declared classes, base classes and namespaces are purple; _t types and caps constants blue.
(class_specifier name: (type_identifier) @type.definition)
(struct_specifier name: (type_identifier) @type.definition)
(enum_specifier name: (type_identifier) @type.definition)
(base_class_clause (type_identifier) @type.definition)
(namespace_definition name: (namespace_identifier) @type.definition)
((type_identifier) @constant.builtin (#lua-match? @constant.builtin "_t$"))
((primitive_type) @constant.builtin (#lua-match? @constant.builtin "_t$"))
((type_identifier) @constant.builtin (#lua-match? @constant.builtin "^[A-Z][A-Z0-9_]+$"))
"operator" @keyword
(template_function name: (identifier) @keyword
  (#any-of? @keyword "static_cast" "dynamic_cast" "reinterpret_cast" "const_cast"))
(preproc_def name: (identifier) @constant.macro)
((enumerator name: (identifier) @variable.member) (#not-lua-match? @variable.member "^[A-Z][A-Z0-9_]+$"))
