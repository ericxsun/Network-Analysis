function C = cluster_coeff_edge(edgeL, adjL, directed)
%CLUSTER_COEFF_EDGE Calculate the clustering coefficient of each edge.
%   C = CLUSTER_COEFF_EDGE(edgeL, adjL, directed) returns the clustering 
%   coeffient of each edge in a given graph described by the edge list.
%
%   Algorithm:
%
%   Note:
%   1. For directed graph, only the outgoing edges will be considered.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], where 
%      'src', 'dst' and 'weight' stand for nodes index at the ends of an edge 
%      and its weight respectively. The node index starts at zero.
%   3. The format of C: [src, dst, clustering coefficient].
%
%   Example:
%       edgeL = [0 1; 0 2; 1 2; 1 4; 2 3; 3 4; 5 6];
%       adjL  = {[1; 2]; [0; 2; 4]; [0; 1; 3]; [2; 4]; [1; 3]; [6]; [5]};
%
%       CLUSTER_COEFF_EDGE(edgeL, adjL, false)
%   returns:
%       C = [0 1 0.33; 0 2 0.33; 1 4 0.25; 2 3 0; 3 4 0; 5 6 0]
%
%   Ref:
%   1. Granovetter M S. The strength of weak ties[J]. American journal of 
%      sociology, 1973: 1360-1380.
%   2. Pajevic S, Plenz D. The organization of strong links in complex networks
%      [J]. Nature Physics, 2012, 8(5): 429-436.
%
%   See also: CLUSTER_COEFF_EDGE
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

[~, edgeL] = iscontinuous(edgeL, directed); %nodes start at 0

C = edgeL(:, 1:2);
C(:, 3) = 0;

m_edges = size(C, 1);
for i = 1 : m_edges
    ii = C(i, 1);
    ij = C(i, 2);
        
    nC = length(intersect(adjL{ii+1}, adjL{ij+1}));
    nT = length(adjL{ii+1}) + length(adjL{ij+1}) - 2;
    C(i, 3) = nC / nT;
end
C(isnan(C(:, 3)), 3) = 0;

%--------------------------------------------------------------------------
end