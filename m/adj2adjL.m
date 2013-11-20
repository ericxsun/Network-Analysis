function adjL = adj2adjL(adj)
%ADJ2ADJL Convert the adjacency matrix to the adjacency list. 
%   adjL = ADJ2ADJL(adj) converts the adjacency matrix of a graph to its
%   adjacency list.
%
%   Algorithm:
%
%   Note:
%   1. During the conversion, the weights of edges will be lost.
%   2. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N 
%      is the number of nodes.
%
%   Example:
%       adj = [0 1 0 1 1; 1 0 1 1 0; 0 1 0 0 1; 1 1 0 0 0; 1 0 1 0 0];
%
%       ADJ2ADJL(adj)
%   returns:
%       adjL = {[1 3 4]; [0 2 3]; [1 4]; [0 1]; [0 2]};
%
%   Ref:
%
%   See also: ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC, 
%             EDGEL2ADJ, EDGEL2ADJL, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, 
%             INC2ADJL, INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

[m, n] = size(adj);
assert(m == n, 'Squared adjacency matrix is required.');

adjL = cell(n, 1);

for i = 1 : n
    adjL{i} = find(adj(i, :) > 0) - 1;
end

%--------------------------------------------------------------------------
end