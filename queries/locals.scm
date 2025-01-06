
[
    (fn_def)
    (fn_extern)
    (block_expr)
    (impl)
    (trait)
]

; Definitions
; -----------

(let
    name: (var_name) @local.definition)
(const
    name: (var_name) @local.definition)
(fn_param
    name: (var_name) @local.definition)

; References
; ----------

(var_expr) @local.reference
