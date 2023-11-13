show services;

create or replace secret dd_api_key
TYPE = PASSWORD
PASSWORD = "xxx"
USERNAME = "DD-AGENT";
grant read on secret dd_api_key to role demo_role;


-- create service rai_service
--     min_instances=1
--     max_instances=1
--     compute_pool=COMPUTE_POOL_STANDARD_2
--     spec=@rai_yaml_stage/rai_service_spec.yaml;
    
create service rai_service
    min_instances=1
    max_instances=1
    compute_pool=COMPUTE_POOL_STANDARD_5
    spec=@rai_yaml_stage/rai_service_spec.yaml;
    
-- create service rai_service
--     min_instances=1
--     max_instances=1
--     compute_pool=COMPUTE_POOL_HIGH_2
--     spec=@rai_yaml_stage/rai_service_spec.yaml;

-- create service rai_service
--     min_instances=1
--     max_instances=1
--     compute_pool=COMPUTE_POOL_HIGH_5
--     spec=@rai_yaml_stage/rai_service_spec.yaml;

show services;