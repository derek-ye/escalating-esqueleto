For the argument, let's think about what happens in a `JOIN` where one of the tables doesn't have a corresponding row. What is the corresponding Esqueleto type that is nullable, and should be wrapped in a `Maybe`? Is it the `SqlExpr`? Is it the `Entity`? Is it the `val`?

For the return type, think again about which piece makes the most sense to be nullable. Is it the `SqlExpr`? Is it the `Value`? Is it the `typ`?
