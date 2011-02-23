BEGIN;

CREATE TABLE run (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    start text DEFAULT CURRENT_TIMESTAMP NOT NULL,
    finish text DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE patch (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    run_id integer REFERENCES run(id) DEFERRABLE,
    created text DEFAULT CURRENT_TIMESTAMP NOT NULL,
    filename text NOT NULL,
    basename text NOT NULL,
    success boolean DEFAULT false,
    b64digest TEXT,
    output text
);

COMMIT;
