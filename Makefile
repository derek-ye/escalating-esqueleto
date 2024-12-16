# check your exercises
test:
	cabal test

# one-time setup
db-create:
	createdb escalatingesqueleto
	make db-reset
	cabal update

# run whenever you want a freshly populated db
db-reset:
	psql escalatingesqueleto < reset.sql

# connect to the database via `psql`
psql:
	psql -d escalatingesqueleto

# simple filewatcher that reruns `cabal test` on changes
watch:
	fswatch -o exercises/* test/* | (while read -r event; do cabal test; done)

	# you could instead use a more advanced watcher like `ghciwatch`
	# ghciwatch --watch exercises --watch test --enable-eval --clear --test-ghci Main.main

.PHONY: test watch
