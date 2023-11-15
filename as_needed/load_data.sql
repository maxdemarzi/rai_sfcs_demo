
-- Example of loading a table into RAI using s3 storage


CREATE OR REPLACE PROCEDURE load_table(TABLE_FQ_NAME STRING, RAI_DATABASE STRING,RELATION STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
// rm any previous data
snowflake.execute({sqlText: `REMOVE @rai_yaml_stage/exports/${TABLE_FQ_NAME}`});
const bucketCall = snowflake.execute({sqlText: `select get_storage_location('')`});
bucketCall.next()
bucket = bucketCall.getColumnValue(1)

snowflake.execute({sqlText: `COPY INTO @rai_yaml_stage/exports/${TABLE_FQ_NAME}/data_ FROM ${TABLE_FQ_NAME};`});
var file_list = snowflake.execute({sqlText: `list @rai_yaml_stage PATTERN='exports/${TABLE_FQ_NAME}/data_.*'`}); 
var result_set = [];
while (file_list.next()) {
    const file_path = file_list.getColumnValue(1); // Assuming file name is in the first column
    const file_name = file_path.split("/").slice(1).join("/")
    
    rel = snowflake.execute({sqlText: `select load_rel_code(get_storage_location('${file_name}'),'${RELATION}')`});
    rel.next();
    exec = snowflake.execute({sqlText: `SELECT EXEC('${RAI_DATABASE}', '${rel.getColumnValue(1)}', NULL, false);`});
    exec.next();
    result_set.push(exec.getColumnValue(1));
    
}
snowflake.execute({sqlText: `REMOVE @rai_yaml_stage/exports/${TABLE_FQ_NAME}`});

return result_set;
$$;

CREATE OR REPLACE FUNCTION load_rel_code(storage_path string, relation string)
RETURNS string
LANGUAGE javascript
AS
$$
    return `
def ${RELATION} = {}
@inline
module config
  def path = "${STORAGE_PATH}"
	module integration
        def region = "us-west-2"
		def provider = "s3"
	end
end
def insert[:${RELATION}] = load_csv[config]
def output = top[5,${RELATION}]
`
$$;

-- example of loading edges from cashapp.tpcds5.edgeid into demo.edge relation
SELECT create_database('demo', true);
call load_table('cashapp.tpcds5.edgeid','demo','edge');