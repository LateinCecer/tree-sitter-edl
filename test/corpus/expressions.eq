
==============
Function Calls
==============

let _ = std::field::BoundaryField::<f64, 2, DIM>::zeros::<NSIZE>(domain);

---

(document
    (item
        (let
            (var_name)
            (function_call
                (function_name
                    (env_def
                        (var_expr)
                        (num_literal)
                        (var_expr))
                    (env_def
                        (var_expr)))
                (call_params
                    (var_expr))))))

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

let _ = 1.;

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

let _ = 9.f64;

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

let _ = 1.e3_f64;

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
            (var_expr)
            (field_expr))))

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
            (field_expr))))

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
            (field_expr))))

=========================
Field on number with hint
=========================

let _ = 5_usize.field;
let _ = 5.e-3.field;

---

(document
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr)))
    (item
        (let
            (var_name)
            (num_literal)
            (field_expr))))

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
            (var_expr)
            (method_expr
                (call_params
                    (var_expr)
                    (num_literal)))))
    (item
        (let
            (var_name)
            (var_expr)
            (method_expr
                (env_def
                    (var_expr)
                    (num_literal))
                (call_params
                    (var_expr)
                    (num_literal))))))


