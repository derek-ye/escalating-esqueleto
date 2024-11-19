The exercise says:

>runDB is a function that takes a DB action and actually runs it on the database

What is the type of a "DB action"?

Think about what "actually runs it" means. This requires interaction with the real world, and so must bottom out in `IO`.

Finally, note that it's nice to have the result of our DB action match the result of actually running it. If we have a database action to get the number of flavors, we want actually running that action to return the number of flavors.
