
==================
Function Signature
==================

/// This is a simple function
comptime fn main() {}

---

(document
    (item
        (doc_comment))
    (item
        (fn_def
            (fn_signature
                (qual_comptime)
                (var_func_name)
                (fn_params))
            (block_expr))))

==========================
Generic Function Signature
==========================

//! This is a simple function
fn foo<T>(val: T) -> T {}

---

(document
    (item
        (infix_comment))
    (item
        (fn_def
            (fn_signature
                (var_func_name)
                (env_def
                    (var_expr))
                (fn_params
                    (fn_param
                        (var_name)
                        (type)))
                (type))
            (block_expr))))

=======================================
Generic Function Signature with mut arg
=======================================

fn foo<T>(mut self, mut val: T,) -> T {}

---

(document
    (item
        (fn_def
            (fn_signature
                (var_func_name)
                (env_def
                    (var_expr))
                (fn_params
                    (self_param
                        (qual_mut))
                    (fn_param
                        (qual_mut)
                        (var_name)
                        (type)))
                (type))
            (block_expr))))


============================
References in parameter list
============================

extern fn foo(&mut self, other: &Self);

---

(document
    (item
        (fn_extern
            (qual_external)
            (fn_signature
                (var_func_name)
                (fn_params
                    (self_param
                        (ref_punct)
                        (qual_mut))
                    (fn_param
                        (var_name)
                        (type
                            (reference_type
                                (ref_punct)
                                (type
                                    (self_type))))))))))
