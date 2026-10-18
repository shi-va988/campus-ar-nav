-- DB schema for Campus AR Navigation (starter)

CREATE TABLE campuses (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE buildings (
  id SERIAL PRIMARY KEY,
  campus_id INTEGER REFERENCES campuses(id),
  name TEXT NOT NULL,
  geojson JSONB
);

CREATE TABLE floors (
  id SERIAL PRIMARY KEY,
  building_id INTEGER REFERENCES buildings(id),
  level INTEGER NOT NULL,
  floor_plan_url TEXT
);

CREATE TABLE nodes (
  id SERIAL PRIMARY KEY,
  floor_id INTEGER REFERENCES floors(id),
  x FLOAT NOT NULL,
  y FLOAT NOT NULL,
  name TEXT,
  accessibility_flags JSONB
);

CREATE TABLE edges (
  id SERIAL PRIMARY KEY,
  node_a INTEGER REFERENCES nodes(id),
  node_b INTEGER REFERENCES nodes(id),
  distance FLOAT NOT NULL,
  stair BOOLEAN DEFAULT FALSE,
  elevator BOOLEAN DEFAULT FALSE,
  ramp BOOLEAN DEFAULT FALSE,
  width FLOAT DEFAULT 1.0,
  accessible BOOLEAN DEFAULT TRUE,
  metadata JSONB
);

CREATE TABLE beacons (
  id SERIAL PRIMARY KEY,
  uuid TEXT,
  major INTEGER,
  minor INTEGER,
  floor_id INTEGER REFERENCES floors(id),
  node_id INTEGER REFERENCES nodes(id),
  x FLOAT,
  y FLOAT,
  last_seen TIMESTAMP
);

CREATE TABLE pois (
  id SERIAL PRIMARY KEY,
  floor_id INTEGER REFERENCES floors(id),
  node_id INTEGER REFERENCES nodes(id),
  title TEXT,
  description TEXT,
  type TEXT
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  accessibility_profile JSONB
);

CREATE TABLE routes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  from_node INTEGER REFERENCES nodes(id),
  to_node INTEGER REFERENCES nodes(id),
  created_at TIMESTAMP DEFAULT now(),
  route_json JSONB
);
