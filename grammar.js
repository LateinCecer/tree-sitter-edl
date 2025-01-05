module.exports = grammar({
    name: 'edl',
    extras: $ => [
        $.line_comment,
        /[\s\p{Zs}\uFEFF\u2028\u2029\u2060\u200B]/,
    ],

    rules: {
        // TODO: add the actual grammar rules
        // resources: https://tree-sitter.github.io/tree-sitter/creating-parsers
        // https://tree-sitter.github.io/tree-sitter/3-syntax-highlighting.html
        document: ($) => seq(repeat("\n"), repeat($.item)),

        item: ($) => seq(
            choice(
                $.doc_comment,
                $.infix_comment,
                $.mod,
                $.use,
                seq($.let, ";"),
                seq($.const, ";"),
                $.fn_def,
                $.fn_extern,
            ),
            repeat("\n")
        ),

        mod: ($) => seq("mod", $._ident, $._close),
        use: ($) => seq("use", $._qual, $._close),
        env: ($) => choice(
            "<>",
            seq(
                "<",
                seq(
                    $._ident,
                    repeat(seq(",", $._ident))
                ),
                optional(","), ">"
            ),
            seq(
                "<",
                seq(
                    $._ident,
                    repeat(seq(",", $._ident))
                ),
                ",",
                seq(
                    $._generic_const_def,
                    repeat(seq(",", $._generic_const_def))
                ),
                optional(","),
                ">"
            ),
            seq(
                "<",
                seq(
                    $._generic_const_def,
                    repeat(seq(",", $._generic_const_def))
                ),
                optional(","),
                ">"
            ),
        ),
        env_def: ($) => seq(
            "<",
            optional(seq(
                $._primary_expr,
                repeat(seq(
                    ",",
                    $._primary_expr
                )),
                optional(",")
            )),
            ">",
        ),

        let: ($) => seq(
            "let",
            optional($.qual_mut),
            $.var_name,
            optional(seq(":", $.type)),
            "=",
            $._expr,
        ),

        const: ($) => seq(
            "const",
            $.var_name,
            ":",
            $.type,
            "=",
            $._expr,
        ),

        var_name: ($) => $._ident,
        var_expr: ($) => $._ident,

        fn_def: ($) => seq($.fn_signature, $.block_expr),
        fn_extern: ($) => seq($.qual_external, $.fn_signature, ";"),

        /* function signature */
        fn_signature: ($) => seq(
            repeat(choice(
                $.qual_comptime,
                $.qual_maybe_comptime
            )),
            "fn",
            $.var_func_name,
            optional($.env_def),
            $.fn_params,
            optional(seq("->", $.type)),
            optional(seq("where"))
        ),

        var_func_name: ($) => $._ident,
        
        /* function parameter list (for function signature definitions) */
        fn_params: ($) => seq(
            "(",
            optional(
                choice(
                    seq($.self_param, repeat(seq(",", $.fn_param)), optional(",")),
                    seq($.fn_param, repeat(seq(",", $.fn_param)), optional(",")),    
                )
            ),
            ")",
        ),

        /* function parameter */
        fn_param: ($) => seq(
            repeat(choice(
                $.qual_mut,
                $.qual_comptime
            )),
            $.var_name,
            ":",
            $.type,
        ),

        /* `self`-parameter (with optional mutability qualifier) */
        self_param: ($) => seq(
            optional($.ref_punct),
            optional($.qual_mut),
            "self"
        ),

    
        /* binary expressions */
        _expr: ($) => choice(
            $._non_closing_expr,
            $._self_closing_expr,
        ),

        _self_closing_expr: ($) => choice(
            $.if_expr,
            $.loop_expr,
            $.block_expr,
            $.comptime_block,
        ),

        _non_closing_expr: ($) => choice(
            $.binop_mul,
            $.binop_div,
            $.binop_rem,
            
            $.binop_add,
            $.binop_sub,

            $.binop_shl,
            $.binop_shr,

            $.binop_and,
            $.binop_xor,
            $.binop_or,

            $.binop_lt,
            $.binop_gt,
            $.binop_leq,
            $.binop_geq,
            $.binop_eq,

            $.binop_land,
            $.binop_lxor,
            $.binop_lor,

            $.binop_assign,
            $.binop_add_assign,
            $.binop_sub_assign,
            $.binop_mul_assign,
            $.binop_div_assign,
            $.binop_shl_assign,
            $.binop_shr_assign,
            $.binop_and_assign,
            $.binop_or_assign,
            $.binop_xor_assign,
            $.binop_rem_assign,

            $.binop_set,
            $.binop_set_add,
            $.binop_set_sub,
            $.binop_set_mul,
            $.binop_set_div,
            $.binop_set_shl,
            $.binop_set_shr,
            $.binop_set_and,
            $.binop_set_or,
            $.binop_set_xor,
            $.binop_set_rem,

            $.return_expr,
            $.break_expr,
            $.continue_expr,
            $.let,

            $.__prim,
        ),

        __prim: ($) => prec(12, $._primary_expr),


        /*
        ----------------------------------------
            Binary operators with precedence
        ----------------------------------------
        */
        binop_mul: ($) => prec.left(11, seq($._expr, "*", $._expr)),
        binop_div: ($) => prec.left(11, seq($._expr, "/", $._expr)),
        binop_rem: ($) => prec.left(11, seq($._expr, "%", $._expr)),

        binop_add: ($) => prec.left(10, seq($._expr, "+", $._expr)),
        binop_sub: ($) => prec.left(10, seq($._expr, "-", $._expr)),

        binop_shl: ($) => prec.left(9, seq($._expr, "<<", $._expr)),
        binop_shr: ($) => prec.left(9, seq($._expr, ">>", $._expr)),

        binop_and: ($) => prec.left(8, seq($._expr, "&", $._expr)),

        binop_xor: ($) => prec.left(7, seq($._expr, "^", $._expr)),

        binop_or: ($) => prec.left(6, seq($._expr, "|", $._expr)),

        binop_lt: ($) => prec.left(5, seq($._expr, "<", $._expr)),
        binop_gt: ($) => prec.left(5, seq($._expr, ">", $._expr)),
        binop_leq: ($) => prec.left(5, seq($._expr, "<=", $._expr)),
        binop_geq: ($) => prec.left(5, seq($._expr, ">=", $._expr)),
        binop_eq: ($) => prec.left(5, seq($._expr, "==", $._expr)),

        binop_land: ($) => prec.left(4, seq($._expr, "&&", $._expr)),

        binop_lxor: ($) => prec.left(3, seq($._expr, "^^", $._expr)),

        binop_lor: ($) => prec.left(2, seq($._expr, "||", $._expr)),
        
        binop_assign: ($) => prec.left(1, seq($._expr, "=", $._expr)),
        binop_add_assign: ($) => prec.left(1, seq($._expr, "+=", $._expr)),
        binop_sub_assign: ($) => prec.left(1, seq($._expr, "-=", $._expr)),
        binop_mul_assign: ($) => prec.left(1, seq($._expr, "*=", $._expr)),
        binop_div_assign: ($) => prec.left(1, seq($._expr, "/=", $._expr)),
        binop_shl_assign: ($) => prec.left(1, seq($._expr, "<<=", $._expr)),
        binop_shr_assign: ($) => prec.left(1, seq($._expr, ">>=", $._expr)),
        binop_and_assign: ($) => prec.left(1, seq($._expr, "&=", $._expr)),
        binop_or_assign: ($) => prec.left(1, seq($._expr, "|=", $._expr)),
        binop_xor_assign: ($) => prec.left(1, seq($._expr, "^=", $._expr)),
        binop_rem_assign: ($) => prec.left(1, seq($._expr, "%=", $._expr)),
        // -
        binop_set: ($) => prec.left(1, seq($._expr, "<-", $._expr)),
        binop_set_add: ($) => prec.left(1, seq($._expr, "+<-", $._expr)),
        binop_set_sub: ($) => prec.left(1, seq($._expr, "-<-", $._expr)),
        binop_set_mul: ($) => prec.left(1, seq($._expr, "*<-", $._expr)),
        binop_set_div: ($) => prec.left(1, seq($._expr, "/<-", $._expr)),
        binop_set_shl: ($) => prec.left(1, seq($._expr, "<<<-", $._expr)),
        binop_set_shr: ($) => prec.left(1, seq($._expr, ">><-", $._expr)),
        binop_set_and: ($) => prec.left(1, seq($._expr, "&<-", $._expr)),
        binop_set_or: ($) => prec.left(1, seq($._expr, "|<-", $._expr)),
        binop_set_xor: ($) => prec.left(1, seq($._expr, "^<-", $._expr)),
        binop_set_rem: ($) => prec.left(1, seq($._expr, "%<-", $._expr)),



        _primary_expr: ($) => (
            /* leading operators go here */
            choice(
                $.unary_op,
                $.inv_op,
                $._base_expr,
            )
        ),

        _base_expr: ($) => prec.left(seq(
            /* the main part of the expression goes here */
            prec(2, choice(
                $.var_expr,
                $.function_call,
                $.num_literal,
                $._array_init,
                seq("(", $._expr, ")"),
            )),
            prec(3, optional(choice($.range_op, $.range_incl_op))),
            /* we can put trailing expressions here, like fields, method calls or index operators */
            prec(1, repeat(choice(
                $.field_expr,
                $.method_expr,
                $.index_expr,
            ))),
        )),

        block_expr: ($) => prec.left(4, seq(
            "{",
            repeat(choice(
                /* ifs, loops and blocks do not need a closing `;` */
                prec.left(11, $.if_statement),
                prec.left(10, $._self_closing_expr),
                /* normal expressions need a closing `;` if they are used as a statement */
                prec.left(9, seq($._non_closing_expr, ";")),
                prec.left(8, ";"),
            )),
            /* blocks can, but do not have to, close with either a clean expression (without closing `;`),
               or by an early-return expression (using the `ret` keyword) */
            //optional($._inline_comment),
            optional(
                $._non_closing_expr,
            ),
            "}",
        )),

        loop_expr: ($) => seq(
            "loop",
            $.block_expr,
        ),

        comptime_block: ($) => seq(
            $.qual_comptime,
            $.block_expr,
        ),

        if_statement: ($) => seq(
            "if",
            $._expr,
            $.block_expr,
            repeat(seq(
                "else",
                "if",
                $._expr,
                $.block_expr,
            )),
        ),

        if_expr: ($) => seq(
            "if",
            $._expr,
            $.block_expr,
            repeat(seq(
                "else",
                "if",
                $._expr,
                $.block_expr,
            )),
            "else",
            $.block_expr,
        ),

        return_expr: ($) => prec.left(seq(
            "ret",
            optional($._expr),
        )),

        break_expr: ($) => prec.left(seq(
            "break",
            optional($._expr),
        )),

        continue_expr: ($) => "continue",

        _array_init: ($) => choice($.array_list_init, $.array_copy_init),

        array_list_init: ($) => seq(
            "[",
            optional(seq(
                $._expr,
                repeat(seq(",", $._expr)),
                optional(","),
            )),
            "]",
        ),

        array_copy_init: ($) => seq(
            "[",
            $._expr,
            ";",
            $._expr,
            "]",
        ),

        field_expr: ($) => seq(".", $._ident),
        method_expr: ($) => seq(".", $._ident, optional(seq("::", $.env_def)), $.call_params),
        index_expr: ($) => seq("[", $._expr, "]"),
        unary_op: ($) => seq("-", $._primary_expr),
        inv_op: ($) => seq("!", $._primary_expr),
        range_op: ($) => seq("..", $._primary_expr),
        range_incl_op: ($) => seq("..=", $._primary_expr),

        function_call: ($) => seq(
            $.function_name,
            $.call_params,
        ),

        call_params: ($) => seq(
            "(",
            seq($._expr, repeat(seq(
                ",",
                $._expr,
            ))),
            optional(","),
            ")",
        ),

        type: ($) => choice(
            $._base_type,
            $.array_type,
            $.slice_type,
            $.reference_type,
            seq("(", $._base_type, ")"),
            $.tuple_type,
            $.empty_type,
            $.self_type,
            $.never_type,
        ),

        never_type: ($) => "!",

        self_type: ($) => "Self",

        empty_type: ($) => seq("(", ")"),

        tuple_type: ($) => seq(
            "(",
            choice(
                seq($.type, repeat1(seq(
                    ",",
                    $.type,
                )), optional(",")),
                seq($.type, ","),
            ),
            ")",
        ),

        reference_type: ($) => seq(
            $.ref_punct,
            optional($.qual_mut),
            $.type,
        ),

        slice_type: ($) => seq(
            "[",
            $.type,
            "]",
        ),

        array_type: ($) => seq(
            "[",
            $.type,
            ";",
            $._expr,
            "]",
        ),

        _base_type: ($) => seq(
            $._ident,
            repeat(seq("::", $._ident)),
            optional(choice(
                $.env_def,
                seq(
                    "::",
                    $.env_def,
                    repeat(seq("::", choice($._ident, $.env_def)))
                ),
            ))
        ),

        function_name: ($) => seq(
            $._ident,
            repeat(seq("::", $._ident)),
            optional(
                seq(
                    "::",
                    $.env_def,
                    repeat(seq("::", choice($._ident, $.env_def)))
                ),
            )
        ),

        num_literal: ($) => prec.right(100, seq(
            $._int,
            optional(seq(".", $._int)),
            optional($._scientific_exponent),
            repeat("_"),
            optional($._number_type_hint),
        )),

        qual_mut: ($) => "mut",
        qual_const: ($) => "const",
        qual_comptime: ($) => "comptime",
        qual_maybe_comptime: ($) => "?comptime",
        qual_external: ($) => seq("extern"),
        ref_punct: ($) => "&",

        string: ($) => /"(\\"|[^"\n])*"/,
        string_block: ($) => /r#"[^("#)\n]*"#/,

        line_comment: ($) => seq("//", $._till_line_end),
        doc_comment: ($) => seq("///", $._till_line_end),
        infix_comment: ($) => seq("//!", $._till_line_end),

        _till_line_end: ($) => /([^\n])*/,

        _number_type_hint: ($) => choice(
            "i8",
            "i16",
            "i32",
            "i64",
            "i128",
            "isize",
            "u8",
            "u16",
            "u32",
            "u64",
            "u128",
            "usize",
            "f32",
            "f64",
        ),

        _scientific_exponent: ($) => seq(
            "e",
            optional(choice("-", "+")),
            $._int,
        ),

        _generic_const_def: ($) => seq("const", $._ident, ":", $.type),

        _qual: ($) => seq($._ident, repeat(seq("::", $._ident))),

        _ident: ($) => /[a-zA-Z_][a-zA-Z0-9_]*/,

        _int: ($) => /[0-9][0-9_]*/,

        _close: ($) => seq(";", repeat(";"))
    }
})