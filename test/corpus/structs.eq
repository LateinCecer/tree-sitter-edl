==================
Empty Function Call
==================

let a = Foo::new();

---

(document
  (item
    (let
      (var_name)
      (var_expr
        (type_name)
        (type_name))
      (call_params))))

=========================
Empty Call with Trailing
=========================

fn f() { g(); }

---

(document
  (item
    (fn_def
      (fn_signature
        (var_func_name)
        (fn_params))
      (block_expr
        (var_expr
          (type_name))
        (call_params)))))

=================
Struct Literal
=================

let id = MtId { id: 0, ctx };

---

(document
  (item
    (let
      name: (var_name)
      (struct_literal
        (type_name)
        (struct_literal_field
          name: (struct_field_name)
          (num_literal))
        (struct_literal_field
          name: (struct_field_name))))))

==========================
Struct Literal Empty Body
==========================

let id = MtId { };

---

(document
  (item
    (let
      (var_name)
      (struct_literal
        (type_name)))))

=================================
Struct Literal with Turbofish Path
=================================

let f = Action::<f64> { n, lo: -1.0, };

---

(document
  (item
    (let
      name: (var_name)
      (struct_literal
        (type_name)
        (env_def
          (type
            (type_name
              (builtin_type))))
        (struct_literal_field
          name: (struct_field_name))
        (struct_literal_field
          name: (struct_field_name)
          (unary_op
            (num_literal)))))))

=================
Struct Definition
=================

type Foo<T, const N: usize> = struct {
    async avg: Field<f64, N, 1>,
    index: Res<usize>,
};

---

(document
  (item
    (type_def
      (struct_def
        (env
          (type_name)
          (generic_const_def
            (var_name)
            (type
              (type_name
                (builtin_type)))))
        (struct_field
          (qual_async)
          name: (struct_field_name)
          (type
            (type_name)
            (env_def
              (type
                (type_name
                  (builtin_type)))
              (type
                (type_name))
              (num_literal))))
        (struct_field
          name: (struct_field_name)
          (type
            (type_name)
            (env_def
              (type
                (type_name
                  (builtin_type))))))))))

==============================
Function Param without Type
==============================

fn reset(comptime self) {}

---

(document
  (item
    (fn_def
      (fn_signature
        (var_func_name)
        (fn_params
          (fn_param
            (qual_comptime)
            (var_name))))
      (block_expr))))

=============
Unit Struct
=============

type FieldAdd = struct;

---

(document
  (item
    (type_def
      (struct_def))))
