
========
Mod item
========

mod foo;

---

(document
    (item
        (mod)))

=====================
Mod item double ended
=====================

mod foo;;

---

(document
    (item
        (mod)))

========
Use item
========

use foo::bar;

---

(document
    (item
        (use)))

============
Use item big
============

use path::to::Item;

---

(document
    (item
        (use)))
