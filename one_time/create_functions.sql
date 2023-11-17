SET SERV = 'rai_service';

CREATE OR REPLACE FUNCTION INVOKE_COMMAND(CMD STRING)
  RETURNS VARIANT
  endpoint = proxyendpoint
  service = $SERV;

CREATE OR REPLACE FUNCTION INVOKE_CREATE_DATABASE(CMD STRING, DATABASE STRING, OVERWRITE BOOLEAN)
  RETURNS VARIANT
  endpoint = proxyendpoint
  service = $SERV;

CREATE OR REPLACE FUNCTION INVOKE_EXEC(CMD STRING, DATABASE STRING, QUERY STRING, DATA VARIANT, READONLY BOOLEAN)
  RETURNS VARIANT
  endpoint = proxyendpoint
  service = $SERV;

CREATE OR REPLACE FUNCTION INVOKE_EXEC_INTO(CMD STRING, DATABASE STRING, TARGET STRING, QUERY STRING)
  RETURNS VARIANT
  endpoint = proxyendpoint
  service = $SERV;

CREATE OR REPLACE FUNCTION INVOKE_LOAD_DATA(CMD STRING, DATABASE STRING, RELATION STRING, PRIMARYKEY STRING, QUERY STRING)
  RETURNS VARIANT
  endpoint = proxyendpoint
  service = $SERV;

// RelationalAI APIs

// Ping the proxy to make sure its running and reachable.
CREATE OR REPLACE FUNCTION PING() RETURNS VARIANT AS
$$
  SELECT INVOKE_COMMAND('ping')
$$;

// Create a database with the given, optionally overwiting
// an existing database.
CREATE OR REPLACE FUNCTION CREATE_DATABASE(DATABASE STRING, OVERWRITE BOOLEAN)
  RETURNS VARIANT AS
$$
  SELECT INVOKE_CREATE_DATABASE('create_database', DATABASE, OVERWRITE)
$$;

// Execute a Rel transaction on the given database.
CREATE OR REPLACE FUNCTION EXEC(DATABASE STRING, QUERY STRING, DATA VARIANT, READONLY BOOLEAN)
  RETURNS VARIANT AS
$$
  SELECT INVOKE_EXEC('exec', DATABASE, QUERY, DATA, READONLY)
$$;

// Execute a read-only Rel transaction on the given database.
CREATE OR REPLACE FUNCTION RAI_QUERY(DATABASE STRING, QUERY STRING)
  RETURNS VARIANT AS
$$
  SELECT INVOKE_EXEC('exec', DATABASE, QUERY, null, true)
$$;

// Execute a Rel transaction on the given database, and insert results into
// the given target table.
CREATE OR REPLACE FUNCTION EXEC_INTO(DATABASE STRING, TARGET STRING, QUERY STRING)
  RETURNS VARIANT AS
$$
  SELECT INVOKE_EXEC_INTO('exec_into', DATABASE, TARGET, QUERY)
$$;

// Load data into the given database and relation, from the given SQL query
// using the named primary key columns.
// Adds to the RAI relation, if it exists.
CREATE OR REPLACE FUNCTION LOAD_DATA(DATABASE STRING, RELATION STRING, PRIMARYKEY STRING, QUERY STRING)
  RETURNS VARIANT AS
$$
  SELECT INVOKE_LOAD_DATA('load_data', DATABASE, RELATION, PRIMARYKEY, QUERY)
$$;


// deletes any previous RAI model with the same name:
CREATE OR REPLACE FUNCTION LOAD_MODEL_QUERY(NAME STRING, PATH STRING)
  RETURNS STRING LANGUAGE JAVASCRIPT AS
$$
  return `
def delete:rel:catalog:model = name, code: rel:catalog:model(name, code) and name = "${NAME}"
def insert:rel:catalog:model = "${NAME}", load_binary["${PATH}"]`
$$;


// deletes any previous RAI model with the same name:
CREATE OR REPLACE FUNCTION LOAD_MODEL_CODE_QUERY(NAME STRING, CODE STRING)
  RETURNS STRING LANGUAGE JAVASCRIPT AS
$$
  return `
def delete:rel:catalog:model = name, code: rel:catalog:model(name, code) and name = "${NAME}"
def insert:rel:catalog:model = "${NAME}", "${CODE}"`
$$;


// Load a Rel model from the given S3 or Azure Blob Storage path, into the given database.
CREATE OR REPLACE FUNCTION LOAD_MODEL(DATABASE STRING, NAME STRING, PATH STRING)
  RETURNS VARIANT AS
$$
  SELECT EXEC(DATABASE, LOAD_MODEL_QUERY(NAME, PATH), NULL, FALSE)
$$;

// Load a Rel model with the given Rel code, into the given database.
CREATE OR REPLACE FUNCTION LOAD_MODEL_CODE(DATABASE STRING, NAME STRING, code STRING)
  RETURNS VARIANT AS
$$
  SELECT EXEC(DATABASE, LOAD_MODEL_CODE_QUERY(NAME, code), NULL, FALSE)
$$;

-- helper functions to fetch an s3 storage location 
CREATE FILE FORMAT if not exists json type = 'json';
CREATE OR REPLACE FUNCTION get_storage_location(relative_path string)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
    SELECT 's3://'||$1:BucketName||'/'||$1:Prefix||'/'||relative_path
    FROM @rai_yaml_stage/token/s3-creds.json (file_format => 'json')
    LIMIT 1
$$;


// TODO: a DELETE_MODEL, DELETE_RELATION?

/*
// test:

SELECT invoke_create_database('create_database', 'mydb', false);

SELECT EXEC('mydb', 'def output = x, x^2, x^3, x^4 from x in {1; 2; 3; 4; 5}', NULL, TRUE);

select exec_into('mydb', 'foobar', 'def output = x, x^2, x^3, x^4 from x in {1; 2; 3; 4; 5}');

*/
