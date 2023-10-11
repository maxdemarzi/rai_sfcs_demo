// Computes PageRank for every node in the graph, outputs the highest 100 scores and node ids

CREATE OR REPLACE FUNCTION HIGHEST_PAGERANK_QUERY() RETURNS STRING LANGUAGE JAVASCRIPT AS
$$
  return `
def my_edge(x,y) = edge:source(i, x) and edge:destination(i,y) from i 
def my_graph = undirected_graph[my_edge]
@inline def my_graphlib = rel:graphlib[my_graph]

def output = bottom[100,{score, node : my_graphlib:pagerank(node, score)}]
`;
$$;


// Execute a Rel transaction on the given database, and insert results into the given target table.
select EXEC_INTO('demo', 'highest_pagerank_results', highest_pagerank_query());