function C = cluster_coeff_edge(G, mode)
%CLUSTER_COEFF_EDGE Calculate the clustering coefficient of each edge.
%   C = CLUSTER_COEFF_EDGE(adj, 'adj') returns the clustering coefficient 
%   of each edge in a given graph described by the adjacency matrix.
%
%   C = CLUSTER_COEFF_EDGE(edgeL, 'edgeL') returns the clustering coeffient
%   of each edge in a given graph described by the edge list.
%
%   Algorithm:
%
%   Note:
%   1. Only for undirected graph.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   3. The format of C: [src, dst, clustering coefficient].
%
%   Example:
%       A = [0 1 1 0 0 0
%            1 0 1 0 0 0
%            1 1 0 0 1 0
%            0 0 0 0 1 1
%            0 0 1 1 0 1
%            0 0 0 1 1 0
%           ]
%
%       clustering_coeff_edge(A, 'adj')
%   returns:
%
%   Ref:
%
%   See also: CLUSTER_COEFF_EDGE
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

if strcmp('adj', mode) == 1
    assert(size(G, 1) == size(G, 2), 'Squared adj is required.');
    assert(isempty(find(G~=G', 1)), 'Undirected graph is required.');
    
    [~, G] = issimple(G, false, mode);
    
    error('Not implemented');
    
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
    
    [~, G] = iscontinuous(G, false);
    
    G = G(:, 1:2);
    
    error('Not implemented');
end

%--------------------------------------------------------------------------
end