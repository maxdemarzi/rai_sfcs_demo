create compute pool compute_pool_standard_2
    min_nodes = 1
    max_nodes = 1
    Instance_family = standard_2;
grant all on compute pool compute_pool_standard_2 to role demo_role;

create compute pool compute_pool_standard_5
    min_nodes = 1
    max_nodes = 1
    Instance_family = standard_5;
grant all on compute pool compute_pool_standard_5 to role demo_role;

create compute pool compute_pool_high_2
    min_nodes = 1
    max_nodes = 1
    Instance_family = high_memory_2;
grant all on compute pool compute_pool_high_2 to role demo_role;

create compute pool compute_pool_high_5
    min_nodes = 1
    max_nodes = 1
    Instance_family = high_memory_5;
grant all on compute pool compute_pool_high_5 to role demo_role;

show compute pools;