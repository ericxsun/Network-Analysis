function C = cluster_coeff_node(G, mode)
%CLUSTER_COEFF_NODE Calculate the clustering coefficient of each node.
%   C = CLUSTER_COEFF_NODE(adj, 'adj') returns the clustering coefficient 
%   of each node in a given graph described by the adjacency matrix.
%
%   C = CLUSTER_COEFF_NODE(edgeL, 'edgeL') returns the clustering coeffient
%   of each node in a given graph described by the edge list.
%
%   Algorithm:
%
%   Note:
%   1. Only for undirected graph.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   3. The format of C: [node index, clustering coefficient].
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
%       clustering_coeff_node(A, 'adj')
%   returns:
%       0   1.0000
%       1   1.0000
%       2   0.3333
%       3   1.0000
%       4   0.3333
%       5   1.0000
%
%   Ref:
%   1. Watts D J, Strogatz S H. Collective dynamics of ‘small-world’ 
%      networks[J]. Nature, 1998, 393(6684): 440-442.
%
%   See also: 
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
    
    N = length(G);
    C = zeros(N, 2);
    
    for i = 1 : N
        C(i, 1) = i - 1;
        
        neigh = G(i, :) == 1;
        neigh_neigh = G(neigh, neigh) == 1;

        edges_max = sum(neigh) * (sum(neigh) - 1) / 2;
        
        if edges_max > 0
            edges_real= sum(sum(neigh_neigh, 1)) / 2;
            C(i, 2) = edges_real / edges_max;
        end
    end
    
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
    
    [~, G] = iscontinuous(G, false);
    
    G = G(:, 1:2);
    
    N = max(max(G)) + 1;
    C = zeros(N, 2);
    adjL = edgeL2adjL(G, false);
    
    for i = 1 : N        
        neigh = adjL{i};
        edges_max = length(neigh) * (length(neigh) - 1) / 2;
        
        if edges_max > 0
            ind1 = ismember(G(:, 1), neigh);
            ind2 = ismember(G(:, 2), neigh);
            
            edges_real = sum(bitand(ind1, ind2));
            
            C(i, 1:2) = [i-1, edges_real / edges_max];
        end
    end
end

%--------------------------------------------------------------------------
end