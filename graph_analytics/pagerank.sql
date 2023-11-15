// Computes PageRank for every node in the graph, outputs the highest 100 scores and node ids

CREATE OR REPLACE FUNCTION HIGHEST_PAGERANK_QUERY(export_path varchar) RETURNS STRING LANGUAGE JAVASCRIPT AS
$$
  return `
def my_edge(x,y) = edge:source(i, x) and edge:destination(i,y) from i 
def my_graph = undirected_graph[my_edge]
@inline def my_graphlib = rel:graphlib[my_graph]

def results = bottom[100,{score, node : my_graphlib:pagerank(node, score)}]
def output = "ok"

def csv_results(colname, row, val) {
    ( colname = :SCORE, results(row, val, _) )
    or
    ( colname = :NODEID, results(row, _, val) )
    or
    ( colname = :ROWID,  results(row, _, _) and row = val )
   
}

@inline
module config
  def data = csv_results
  def partition_size = 200, exists(data)

  def path = "${EXPORT_PATH}/results.csv"
	module integration
        def region = "us-west-2"
		def provider = "s3"
	end
end
def export = export_csv[config]
`;
$$;


// Execute a Rel transaction on the given database, and insert results into the given target table.
// uses sql inserts and updates to insert the results into the target table
-- select EXEC_INTO('demo', 'highest_pagerank_results', highest_pagerank_query(get_storage_location()));



//execute the rel transaction which exports the results to the given path
-- create the target table
create or replace TABLE highest_pagerank_results (
	nodeid NUMBER(38,0),
    rowid NUMBER(38,0),
	score NUMBER(38,12)
);
--  run the algorithm, and export results to the given path
select EXEC( 'demo', highest_pagerank_query(get_storage_location('max/page-rank')));

-- load the results into the target table
COPY INTO highest_pagerank_results FROM '@rai_yaml_stage/max/page-rank/' FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER=0)