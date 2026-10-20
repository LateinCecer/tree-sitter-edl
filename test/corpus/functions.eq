==================
Function Signature
==================

/// This is a simple function
comptime fn main() {}

---

(document
  (item
    (doc_comment
      (md_content)))
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
fn foo<T, const N: usize>(val: T) -> T {}

---

(document
  (item
    (infix_comment
      (md_content)))
  (item
    (fn_def
      (fn_signature
        (var_func_name)
        (env
          (type_name)
          (generic_const_def
            (var_name)
            (type
              (type_name
                (builtin_type)))))
        (fn_params
          (fn_param
            (var_name)
            (type
              (type_name))))
        (type
          (type_name)))
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
        (env
          (type_name))
        (fn_params
          (self_param
            (qual_mut))
          (fn_param
            (qual_mut)
            (var_name)
            (type
              (type_name))))
        (type
          (type_name)))
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
                  (type_name
                    (self_type)))))))))))

==========================
Shared and Async Params
==========================

comptime fn explicit(
    shared domain: Domain<T, NSIZE, DIM>,
    scale: ResView<T>,
    async dst: DevicePointer<Field<T, N, DIM>>,
) -> async GradientAction<T, SCHEME, N, NSIZE, DIM> {}

---

(document
  (item
    (fn_def
      signature: (fn_signature
        (qual_comptime)
        name: (var_func_name)
        (fn_params
          (fn_param
            (qual_shared)
            name: (var_name)
            (type
              (type_name)
              (env_def
                (type
                  (type_name))
                (type
                  (type_name))
                (type
                  (type_name)))))
          (fn_param
            name: (var_name)
            (type
              (type_name)
              (env_def
                (type
                  (type_name)))))
          (fn_param
            (qual_async)
            name: (var_name)
            (type
              (type_name)
              (env_def
                (type
                  (type_name)
                  (env_def
                    (type
                      (type_name))
                    (type
                      (type_name))
                    (type
                      (type_name))))))))
        (qual_async)
        (type
          (type_name)
          (env_def
            (type
              (type_name))
            (type
              (type_name))
            (type
              (type_name))
            (type
              (type_name))
            (type
              (type_name)))))
      (block_expr))))

=============
Async Self
=============

async fn dispatch(async &self) {}

---

(document
  (item
    (fn_def
      (fn_signature
        (qual_async)
        (var_func_name)
        (fn_params
          (self_param
            (qual_async)
            (ref_punct))))
      (block_expr))))

===============
Async Param Self
===============

comptime fn source_ptr(async self) -> async DevicePointer<Field<T, DIM, 1>> {
    self.as_device_ptr().source()
}

---

(document
  (item
    (fn_def
      signature: (fn_signature
        (qual_comptime)
        name: (var_func_name)
        (fn_params
          (fn_param
            (qual_async)
            name: (var_name)))
        (qual_async)
        (type
          (type_name)
          (env_def
            (type
              (type_name)
              (env_def
                (type
                  (type_name))
                (type
                  (type_name))
                (num_literal))))))
      (block_expr
        (var_expr
          (type_name))
        (field_expr
          (field_name
            (function_name_segment)))
        (call_params)
        (field_expr
          (field_name
            (function_name_segment)))
        (call_params)))))

=====================
Reference Return Type
=====================

?comptime fn get_mut(&mut self, r: usize, c: usize) -> &mut T {}

---

(document
  (item
    (fn_def
      signature: (fn_signature
        (qual_maybe_comptime)
        name: (var_func_name)
        (fn_params
          (self_param
            (ref_punct)
            (qual_mut))
          (fn_param
            name: (var_name)
            (type
              (type_name
                (builtin_type))))
          (fn_param
            name: (var_name)
            (type
              (type_name
                (builtin_type)))))
        (type
          (reference_type
            (ref_punct)
            (qual_mut)
            (type
              (type_name)))))
      (block_expr))))

====================
Self Path
====================

fn add(self, rhs: Self) -> Self::Output {}

---

(document
  (item
    (fn_def
      signature: (fn_signature
        name: (var_func_name)
        (fn_params
          (self_param)
          (fn_param
            name: (var_name)
            (type
              (type_name
                (self_type)))))
        (type
          (type_name
            (self_type))
          (type_name)))
      (block_expr))))
