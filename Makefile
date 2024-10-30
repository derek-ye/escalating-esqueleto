# check your exercises
test:
	cabal test

# one-time setup
db-setup:
	createdb escalatingesqueleto
	psql escalatingesqueleto < setup.sql

# run whenever you want a freshly populated db
db-reset:
	psql escalatingesqueleto < reset.sql

# connect to the database via `psql`
db-connect:
	psql -d escalatingesqueleto

.PHONY: test
