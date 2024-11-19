This one has a lot going on, so let's break it down.

The difference between these three joins is which parts (left or right) are nullable.

Look at all the places where the types of `fullOuterJoin` and `innerJoin` don't match up exactly. We have:

- `ToMaybe a', ToMaybe b'` vs. no extra constraints
- `(ToMaybeT a' :& ToMaybeT b')` vs. `(a' :& b')` in multiple places

The most important part to think about then is which side of the `leftJoin` will have the extra `ToMaybe`s attached. Is it `a` or `b`?
