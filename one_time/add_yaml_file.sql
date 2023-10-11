create stage if not exists rai_yaml_stage;

put file:///Users/max/demo/rai_service_spec.yaml 
@rai_yaml_stage auto_compress=false overwrite=true;