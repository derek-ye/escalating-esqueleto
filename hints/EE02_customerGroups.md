First, you should figure out how to join all necessary tables together. While we'll only need information from `CustomerGroupParent` and `Customer` in the final result, we need to "join through" the table that links these pieces together---`CustomerLink`.

You may not have collected a bunch of results into a list in esqueleto before. How would you do this in postgres? Check out `import Database.Esqueleto.PostgreSQL` for some options on how to massage the types into what you want.
