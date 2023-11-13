create stage if not exists rai_yaml_stage 
ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

put file:///Users/max/demo/rai_service_spec.yaml 
@rai_yaml_stage auto_compress=false overwrite=true;

put file:///Users/max/demo/one_time/engineconfig.yaml 
@rai_yaml_stage/config auto_compress=false overwrite=true;