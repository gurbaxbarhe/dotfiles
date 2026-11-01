;; extends
; GitHub's SQL grammar: the name being created is purple, dotted references are blue,
; and it leaves these words uncolored.
(create_table (object_reference name: (identifier) @function))
(create_view (object_reference name: (identifier) @function))
(create_materialized_view (object_reference name: (identifier) @function))
(create_function (object_reference name: (identifier) @function))
(create_sequence (object_reference name: (identifier) @function))
(create_type (object_reference name: (identifier) @function))
(create_index (object_reference name: (identifier) @function))
(create_trigger (object_reference name: (identifier) @function))
(object_reference schema: (identifier) @constant name: (identifier) @constant)
(field (object_reference name: (identifier) @constant) name: (identifier) @constant)
[(keyword_to) (keyword_owner) (keyword_no) (keyword_increment) (keyword_cache) (keyword_language) (keyword_end) (keyword_if) (keyword_after) (keyword_for) (keyword_each) (keyword_row) (keyword_security) (keyword_definer) (keyword_declare) (keyword_separator) (keyword_cascade) (keyword_restrict)] @variable
