# Escalating Esqueleto

Esqueleto is a library that lets us write SQL queries with Haskell syntax and typechecking.

This repo is a collection of esqueleto exercises, ordered by difficulty. They come with explanatory comments, a test suite, and sample answers.

Our goal is to be able to see through any esqueleto query to the SQL underneath. Call it esq-ray vision.

## Getting Started

### Database setup

You'll need `postgres` installed. If you've already run bootstrap-mercury on your machine, you should have it. Check by running `postgres --version`

Set up a local database:

```sh
nix develop
make db-setup
```

You can reset database state (including populating it with fake data) with:

```
make db-reset
```

### Doing the exercises

The first exercise file is `exercises/EE00_StartingOut.hs`

1. Run `nix develop` to enter a nix shell
2. Edit `test/Main.hs` to focus on the relevant tests (see below)
3. Fix up the exercise file by filling in any typed holes or missing pieces
4. In the nix shell, run `make test` to check your work

Then, move on to the next exercise file in `exercises/`

### Focusing on specific tests

`test/Main.hs` is spoiler-free

If you change `describe` to `fdescribe` in `test/Main.hs`, you can focus on a single file. Try it out:

```diff
- describe "EE00_StartingOut" $ do
+ fdescribe "EE00_StartingOut" $ do
```

### Viewing rendered queries

Because this repo's version of `runDB` logs to stdout, your queries can be seen in generated SQL form by looking for the `[Debug#SQL]` tag in the logs. It's often useful to check your intuition against the SQL your code is actually producing.

```
EE00_Test
[Debug#SQL] SELECT "test"."column"
FROM "test"
; []
  testName [✔]
  anotherTest [✘]
```

### Poking around in the database

Once setup is complete, you can check out the current state of the database with `psql`. This might be useful to write or validate raw SQL queries, but I encourage you to start thinking in esqueleto directly rather than always translating.

```
make db-connect
```

### Check your work

:warning: `answers/*.hs` contains spoilers

Once you've completed some exercises, you may want to check against the existing answers. Make sure to complete all the exercises in a file before doing this---the point is that you learn, not that you type out the correct answers as quickly as possible. The corresponding answers file for `exercises/X.hs` is `answers/X.hs`.
