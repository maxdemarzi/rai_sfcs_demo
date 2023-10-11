SELECT create_database('demo', true);

SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 0');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 1');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 2');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 3');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 4');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 5');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 6');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 7');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 8');
SELECT load_data('demo', 'edge', 'id', 'select * from edgeid where mod(id,10) = 9');
