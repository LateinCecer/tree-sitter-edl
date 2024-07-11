module.exports = grammar({
    name: 'edl',
    extras: (_) => ["\r", " ", "\t"],

    rules: {
        // TODO: add the actual grammar rules
        // resources: https://tree-sitter.github.io/tree-sitter/creating-parsers
        document: ($) => seq(repeat("\n"), repeat($.item)),

        item: ($) => seq(choice(
            $.mod,
            $.use,
            $.let,
        ), repeat("\n")),

        mod: ($) => seq("mod", $._ident, $._close),
        use: ($) => seq("use", $._qual, $._close),
        env: ($) => choice(
            "<>",
            seq("<", seq($._ident, repeat(seq(",", $._ident))), optional(","), ">"),
            seq("<", seq($._ident, repeat(seq(",", $._ident))), ",", seq($._generic_const_def, repeat(seq(",", $._generic_const_def))), optional(","), ">"),
            seq("<", seq($._generic_const_def, repeat(seq(",", $._generic_const_def))), optional(","), ">"),
        ),
        env_def: ($) => seq(
            "<",
            optional(seq($._primary_expr, repeat(seq(",", $._primary_expr)), optional(","))),
            ">",
        ),

        let: ($) => seq(
            "let",
            optional("mut"),
            $.var_name,
            optional(seq(":", $.type)),
            "=",
            $._expr,
            repeat1(";"),
        ),

        var_name: ($) => $._ident,
        var_expr: ($) => $._ident,


        _expr: ($) => choice(
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

        type: ($) => seq(
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