
==============
Function Calls
==============

let _ = std::field::BoundaryField::<f64, 2, DIM>::zeros::<NSIZE>(domain);

---

(document
    (item
        (let
            (var_name)
            (var_expr
                (type_name)
                (type_name)
                (type_name)
                (env_def
                    (type
                        (type_name
                            (builtin_type)))
                    (num_literal)
                    (type
                        (type_name)))
                (type_name)
                (env_def
                    (type
                        (type_name))))
            (call_params
                (var_expr
                    (type_name))))))

====================
Simple Function Call
====================

let _ = println(hello);

---

(document
    (item
        (let
            (var_name)
            (var_expr
                (type_name))
            (call_params
                (var_expr
                    (type_name))))))

================
Number Literal 1
================

let _ = 1;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 2
================

let _ = 1.0;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 3
================

let _ = 1.0;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 4
================

let _ = 1__.0__;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 5
================

let _ = 1usize;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 6
================

let _ = 9.12345678f64;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 7
================

let _ = 1e3;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))


================
Number Literal 8
================

let _ = 1e-3;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Number Literal 9
================

let _ = 1e+3;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

=================
Number Literal 10
=================

let _ = 1e3_f64;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

=================
Number Literal 11
=================

let _ = 1.0e3_f64;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

=================
Number Literal 12
=================

let _ = 1.1e3_f64;

---

(document
    (item
        (let
            (var_name)
            (num_literal))))

================
Field expression
================

let _ = a.field;

---

(document
    (item
        (let
            (var_name)
            (var_expr
                (type_name))
            (field_expr
                (field_name
                    (function_name_segment))))))

================
Field on integer
================

let _ = (5).field;

---

(document
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr
                (field_name
                    (function_name_segment))))))

==============
Field on float
==============

let _ = 5.0.field;

---

(document
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr
                (field_name
                    (function_name_segment))))))

=========================
Field on number with hint
=========================

let _ = 5_usize.field;
let _ = 5.2e-3.field;

---

(document
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr
                (field_name
                    (function_name_segment)))))
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr
                (field_name
                    (function_name_segment))))))

============
Method calls
============

let _ = var.method(a, 2.3);
let _ = var.method::<f32, 2>(a, 2.3);

---

(document
    (item
        (let
            (var_name)
            (var_expr
                (type_name))
            (field_expr
                (field_name
                    (function_name_segment)))
            (call_params
                (var_expr
                    (type_name))
                (num_literal))))
    (item
        (let
            (var_name)
            (var_expr
                (type_name))
            (field_expr
                (field_name
                    (function_name_segment)
                    (env_def
                        (type
                            (type_name
                                (builtin_type)))
                        (num_literal))))
            (call_params
                (var_expr
                    (type_name))
                (num_literal)))))

===============
Prefix Operator
===============

let _ = !0;
let _ = -3.14159265;

---

(document
    (item
        (let
            (var_name)
            (inv_op
                (num_literal))))
    (item
        (let
            (var_name)
            (unary_op
                (num_literal)))))


==============
Range operator
==============

let _ = 0..2;
let _ = 0..=1;

---

(document
    (item
        (let
            (var_name)
            (num_literal)
            (range_op
                (num_literal))))
    (item
        (let
            (var_name)
            (num_literal)
            (range_incl_op
                (num_literal)))))


==========
Test Binop
==========

let _ = a + 2.0 * b;

---

(document
    (item
        (let
            (var_name)
            (binop_add
                (var_expr
                    (type_name))
                (binop_mul
                    (num_literal)
                    (var_expr
                        (type_name)))))))

====================
Test Const Statement
====================

const DIM: usize = 0;

---

(document
    (item
        (const
            (var_name)
            (type
                (type_name
                    (builtin_type)))
            (num_literal))))


======================
Test Block Expressions
======================

let some_block = {
    let a = 0;
    let b = 1;
    a + b
};

---

(document
    (item
        (let
            (var_name)
            (block_expr
                (let
                    (var_name)
                    (num_literal))
                (let
                    (var_name)
                    (num_literal))
                (binop_add
                    (var_expr
                        (type_name))
                    (var_expr
                        (type_name)))))))

=============================
Test Self-Closing Expressions
=============================

let some_block = {
    if 10 > 9 {
        std::println(hello);
    }
    let a = 0;
};

---

(document
    (item
        (let
            (var_name)
            (block_expr
                (if_statement
                    (binop_gt
                        (num_literal)
                        (num_literal))
                    (block_expr
                        (var_expr
                            (type_name)
                            (type_name))
                        (call_params
                            (var_expr
                                (type_name)))))
                (let
                    (var_name)
                    (num_literal))))))


====================
Test Array List Init
====================

let array: [u32; 4] = [1, 2, 3, 4];

---

(document
    (item
        (let
            (var_name)
            (type
                (array_type
                    (type
                        (type_name
                            (builtin_type)))
                    (num_literal)))
            (array_list_init
                (num_literal)
                (num_literal)
                (num_literal)
                (num_literal)))))

====================
Test Array Copy Init
====================

let array: [u32; 4] = [1; 4];

---

(document
    (item
        (let
            (var_name)
            (type
                (array_type
                    (type
                        (type_name
                            (builtin_type)))
                    (num_literal)))
            (array_copy_init
                (num_literal)
                (num_literal)))))
