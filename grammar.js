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
            optional(seq($._expr, repeat(seq(",", $._expr)), optional(","))),
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
            seq($._primary_expr)
        ),

        _primary_expr: ($) => seq(
            /* leading operators go here */
            repeat(choice(
                $.unary_op,
                $.inv_op,
            )),
            /* the main part of the expression goes here */
            choice(
                $.var_expr,
                $.function_call,
                $.num_literal,
                seq("(", $._expr, ")"),
            ),
            /* we can put trailing expressions here, like fields, method calls or index operators */
            repeat(choice(
                $.field_expr,
                $.method_expr,
                $.index_expr,
            )),
        ),

        field_expr: ($) => seq(".", $._ident),
        method_expr: ($) => seq(".", $._ident, optional(seq("::", $.env_def)), $.call_params),
        index_expr: ($) => seq("[", $._expr, "]"),
        unary_op: ($) => seq("-"),
        inv_op: ($) => seq("!"),


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

        num_literal: ($) => prec.right(seq(
            $._int,
            optional(seq(".", optional($._int))),
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