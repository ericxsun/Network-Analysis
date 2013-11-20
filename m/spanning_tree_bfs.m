function tree_nodes = spanning_tree_bfs(adjL, src)
%SPANNING_TREE_BFS Find the spanning tree using breadth-first-search.
%   tree_nodes = SPANNING_TREE_BFS(adjL, src) returns nodes of the spanning
%   tree starting at 'src' in a given graph described by the adjacency list.
%
%   Algorithm:
%   1. breadth-first-search.
%
%   Note:
%   1. The adjacency list. Id starts at 0, i.e., adjL{i} represents the 
%   neighbors of node i-1, i ranges from 1 to N.
%
%   Example:
%
%   Ref:
%
%   See also: SHORTEST_PATH_AVERAGE_LENGTH, SHORTEST_PATH_DIJKSTRA, 
%             SHORTEST_PATH_DIJKSTRA_SIMPLE, SHORTEST_PATH_SPFA
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

N = length(adjL);

assert(0 <= src && src < N, sprintf('0 <= src < %d is required.', N));

to_visit   = src;
tree_nodes = src;
visited    = src;

while not(isempty(to_visit))
    cur = to_visit(1);
    to_visit(1) = [];
    
    neigh = adjL{cur+1};
    for nn = 1 : length(neigh)
        if isempty(find(visited == neigh(nn), 1))
            tree_nodes = [tree_nodes; neigh(nn)];
            visited    = [visited, neigh(nn)];
            to_visit   = [to_visit, neigh(nn)];
        end
    end
end

%--------------------------------------------------------------------------
end