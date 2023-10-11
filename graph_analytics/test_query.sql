select RAI_QUERY('demo', 'def output= 1 + 1');

select TO_NUMBER(value[0]) as num 
from table(FLATTEN(RAI_QUERY('demo', 'def output= 1 + 1')));