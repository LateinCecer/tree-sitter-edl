; highlights.scm

; keywords
"fn" @keyword.function
"ret" @keyword.control.return
"const" @keyword.storage.type
"let" @keyword.storage.type
"if" @keyword.control.conditional
"else" @keyword.control.conditional
"loop" @keyword.control.repeat
"break" @keyword.control.repeat
(continue_expr) @keyword.control.repeat
"extern" @keyword.control.function
"self" @variable.builtin
(self_type) @type.builtin
; "struct" @keyword
; "enum" @keyword
; "union" @keyword
; "match" @keyword
"for" @keyword.control.repeat
(qual_comptime) @keyword.storage.modifier
(qual_maybe_comptime) @keyword.storage.modifier
"mod" @keyword.control.import
"use" @keyword.control.import
(qual_mut) @keyword.storage.modifier
; "pub" @keyword
"impl" @keyword.function
"trait" @keyword.function
"as" @keyword.operator

; special operators
; "?" @operator
[
    "*"
    "/"
    "%"

    "+"
    "-"

    "<<"
    ">>"

    "&"

    "^"

    "|"

    "<"
    ">"
    "<="
    ">="
    "=="

    "&&"

    "^^"

    "||"

    "="
    "+="
    "-="
    "*="
    "/="
    "<<="
    ">>="
    "&="
    "|="
    "^="
    "%="

    "<-"
    "+<-"
    "-<-"
    "*<-"
    "/<-"
    "<<<-"
    ">><-"
    "&<-"
    "|<-"
    "^<-"
    "%<-"
] @operator

; decorations
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"->" @punctuation.special
"," @punctuation.delimiter
";" @punctuation.delimiter
":" @punctuation.delimiter
"::" @punctuation.delimiter

; names
(type_name) @type
(type_name
    (builtin_type) @type.builtin)
(env
    (type_name) @type.parameter)

(var_name) @variable
(var_expr) @variable
(fn_signature
    (fn_params
        (fn_param) @variable.parameter))
(function_name_segment) @function
; (method_expr
;     (function_name_segment) @function.method)
(var_func_name) @function

; comments
(line_comment) @comment.line
(doc_comment) @comment.block.documentation
(infix_comment) @comment.block.documentation

; literals
(num_literal) @constant.numeric
(string) @string
(string_block) @string
(char) @string
(bool_literal) @constant.builtin.boolean

; other
(macro) @special

