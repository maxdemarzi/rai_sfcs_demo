// Make a copy of edge with an extra row ID column, which makes it faster to copy edges over to RAI in chunks:

CREATE OR REPLACE TABLE EDGEID (
    id int,
    source int,
    destination int);


insert into edgeid(source,destination,id) select source, destination, row_number() over (order by source,destination)  from edge;