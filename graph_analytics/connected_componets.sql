CREATE OR REPLACE FUNCTION CC_QUERY() RETURNS STRING LANGUAGE JAVASCRIPT AS
$$
  return `
def myedge(x,y) = edge:source(i, x) and edge:destination(i,y) from i
def my_graph = directed_graph[myedge]
@inline def my_graphlib = rel:graphlib[my_graph]
def output = count[last[my_graphlib:weakly_connected_component]]
`;
$$;

select RAI_QUERY('demo', CC_QUERY());