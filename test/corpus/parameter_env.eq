
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
                (type_name)
                (env_def
                    (type
                        (type_name))
                    (type
                        (type_name))
                    (type
                        (type_name))))
            (var_expr
                (type_name)))))

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
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name))))
            (var_expr
                (type_name)))))

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
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name))
                    (type (type_name))
                    (type (type_name))
                    (type (type_name))))
            (var_expr
                (type_name)))))

====================
Simple let statement
====================

let a = some;

---

(document
    (item
        (let
            (var_name)
            (var_expr
                (type_name)))))

=============
let with type
=============

let a: usize = some;

---

(document
    (item
        (let
            (var_name)
            (type (type_name (builtin_type)))
            (var_expr
                (type_name)))))

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
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name))))
            (var_expr
                (type_name)))))

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
                (type_name)
                (type_name)
                (env_def
                    (type (type_name))))
            (var_expr
                (type_name)))))

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
                (type_name)
                (env_def))
            (var_expr
                (type_name)))))

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
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name))))
            (var_expr
                (type_name)))))

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
                (type_name)
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name)))
                (type_name))
            (var_expr
                (type_name)))))

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
                (type_name)
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name)))
                (type_name)
                (type_name)
                (env_def
                    (type (type_name))))
            (var_expr
                (type_name)))))

===============
Parameter Env 9
:fail-fast
:error
===============

let a: Some::<A, B>::Output<B> = some;

---

(document
    (item
        (let
            (var_name)
            (type
                (type_name)
                (env_def
                    (type (type_name))
                    (type (type_name)))
                (type_name)
                (env_def
                    (type (type_name))))
            (var_expr))))
