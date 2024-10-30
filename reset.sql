CREATE OR REPLACE FUNCTION create_timestamps()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_at = now();
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE FUNCTION update_timestamps()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = now();
    RETURN NEW;
  END;
  $$ language 'plpgsql';

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS citext;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'email') THEN
    CREATE DOMAIN email AS citext
      CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::citext);
  END IF;
END $$;

DROP TABLE IF EXISTS flavors;

CREATE TABLE flavors
  ( id UUID PRIMARY KEY UNIQUE
  , name TEXT NOT NULL
  , created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
  , updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
  );

CREATE TRIGGER flavors_insert BEFORE INSERT ON flavors FOR EACH ROW EXECUTE PROCEDURE create_timestamps();
CREATE TRIGGER flavors_update BEFORE UPDATE ON flavors FOR EACH ROW EXECUTE PROCEDURE update_timestamps();

INSERT INTO flavors VALUES (uuid_generate_v1mc(), 'Chunky Chocolate');
INSERT INTO flavors VALUES (uuid_generate_v1mc(), 'Smooth Strawberry');
INSERT INTO flavors VALUES (uuid_generate_v1mc(), 'Variegated Vanilla');

GRANT SELECT, UPDATE, INSERT, DELETE ON flavors to escalatingesqueleto;
