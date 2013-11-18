function edgeL = adj2edgeL(adj, directed)
%ADJ2EDGEL Convert the adjacency matrix to the edge list.
%   edgeL = ADJ2EDGEL(adj, directed) converts the adjacency matrix of a 
%   graph(weighted or unweighted) to its edge list. The directionality of 
%   the graph is defined the value of parameter 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight], where 'src',
%      'dst' and 'weight' stand for nodes index at the ends of an edge and
%      its weight respectively. The node index starts at zero.
%
%   Example:
%       adj = [0 1 0 1 1; 1 0 1 1 0; 0 1 0 0 1; 1 1 0 0 0; 1 0 1 0 0];
%       directed = false;
%
%       ADJ2EDGEL(adj, directed)
%   returns:
%       edgeL = [0 1 1; 0 3 1; 0 4 1; 1 2 1; 1 3 1; 2 4 1]
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

[m, n] = size(adj);
assert(m == n, 'Squared adjacency matrix is required.');

if not(directed)
    adj = sparse(triu(adj));
end

[row, col, val] = find(adj);

edgeL = [row, col, val];
edgeL = sortrows(edgeL);

edgeL(:, 1:2) = edgeL(:, 1:2) - 1;

%--------------------------------------------------------------------------
end