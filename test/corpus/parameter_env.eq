
===============
Parameter Env 0
===============

let a: Some<A, B, C> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 1
===============

let a: Some<D, E> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 2
===============

let a: Some<A, B, C, D, E> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)
                    (var_expr)
                    (var_expr)
                    (var_expr)))
            (var_expr))))

====================
Simple let statement
====================

let a = some;

---

(document
    (item
        (let
            (var_name)
            (var_expr))))

=============
let with type
=============

let a: usize = some;

---

(document
    (item
        (let
            (var_name)
            (type)
            (var_expr))))

===============
Parameter Env 3
===============

let a: Some<D, E,> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 4
===============

let a: foo::Some<D> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 5
===============

let a: Some<> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def))
            (var_expr))))

===============
Parameter Env 6
===============

let a: Some::<A, B> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 7
===============

let a: foo::Some::<A, B>::Output = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 8
===============

let a: foo::Some::<A, B>::Output::test::<A> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (env_def
                    (var_expr)
                    (var_expr))
                (env_def
                    (var_expr)))
            (var_expr))))

===============
Parameter Env 9
:fail-fast
:error
===============

let a: Some::<A, B>::Output<B> = some;

---

