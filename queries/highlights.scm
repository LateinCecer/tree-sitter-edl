; highlights.scm

; keywords
"fn" @keyword
"ret" @keyword
"const" @keyword
"let" @keyword
"if" @keyword
"else" @keyword
"loop" @keyword
"break" @keyword
; "continue" @keyword
(continue_expr) @keyword
"extern" @keyword
"self" @keyword
; "Self" @keyword
(self_type) @keyword
; "struct" @keyword
; "enum" @keyword
; "union" @keyword
; "match" @keyword
; "for" @keyword
; "comptime" @keyword
(qual_comptime) @keyword
(qual_maybe_comptime) @keyword
"mod" @keyword
"use" @keyword
; "mut" @keyword
(qual_mut) @keyword
; "pub" @keyword

; special operators
; "?" @operator

; decorations
"(" @decoration
")" @decoration
"{" @decoration
"}" @decoration
"[" @decoration
"]" @decoration
"->" @decoration
"," @decoration
";" @decoration
":" @decoration

; names
(type) @type
(var_name) @var_name
(var_expr) @var_expr
(function_name) @function
(var_func_name) @function

; comments
(line_comment) @comment
(doc_comment) @comment
(infix_comment) @comment

; operators
(binop_mul) @operator
(binop_div) @operator
(binop_rem) @operator
(binop_add) @operator
(binop_sub) @operator
(binop_shl) @operator
(binop_shr) @operator
(binop_and) @operator
(binop_xor) @operator
(binop_or) @operator
(binop_lt) @operator
(binop_gt) @operator
(binop_leq) @operator
(binop_geq) @operator
(binop_eq) @operator
(binop_land) @operator
(binop_lxor) @operator
(binop_lor) @operator

(binop_assign) @operator
(binop_add_assign) @operator
(binop_sub_assign) @operator
(binop_mul_assign) @operator
(binop_div_assign) @operator
(binop_shl_assign) @operator
(binop_shr_assign) @operator
(binop_and_assign) @operator
(binop_or_assign) @operator
(binop_xor_assign) @operator
(binop_rem_assign) @operator

(binop_set) @operator
(binop_set_add) @operator
(binop_set_sub) @operator
(binop_set_mul) @operator
(binop_set_div) @operator
(binop_set_shl) @operator
(binop_set_shr) @operator
(binop_set_and) @operator
(binop_set_or) @operator
(binop_set_xor) @operator
(binop_set_rem) @operator

; control flow stuff
; (return_expr) @return
; (break_expr) @break
; (continue_expr) @continue

; literals
(num_literal) @number
(string) @string
(string_block) @string
(char) @string.special
(bool_literal) @bool.literal

; plane types
"i8" @plane_type
"i16" @plane_type
"i32" @plane_type
"i64" @plane_type
"i128" @plane_type
"isize" @plane_type
"u8" @plane_type
"u16" @plane_type
"u32" @plane_type
"u64" @plane_type
"u128" @plane_type
"usize" @plane_type
"f32" @plane_type
"f64" @plane_type
; "bool" @plane_type
; "str" @plane_type
; "char" @plane_type

