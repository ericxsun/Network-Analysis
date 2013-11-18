function adj = adjL2adj(adjL)
%ADJL2ADJ Convert the adjacency list to the adjacency matrix.
%   adj = ADJL2ADJ(ajdL) converts the adjacency list of a graph to its
%   adjacency matrix.
%
%   Algorithm:
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N
%      is the number of nodes.
%   2. The adjacency matrix will be in sparse format.
%
%   Example:
%       adjL = {[1 3 4]; [0 2 3]; [1 4]; [0 1]; [0 2]};
%
%       ADJL2ADJ(adjL)
%   returns:
%       adj = 
%			(2,1)	1
%			(4,1)	1
%			(5,1)	1
%			(1,2)	1
%			(3,2)	1
%			(4,2)	1
%			(2,3)	1
%			(5,3)	1
%			(1,4)	1
%			(2,4)	1
%			(1,5)	1
%			(3,5)	1
%
%   Ref:
%
%   See also:

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

N = length(adjL);

adj = sparse(N, N);

for i = 1 : N
    for j = 1 : length(adjL{i})
        adj = sparse(adj + sparse(i, adjL{i}(j)+1, 1, N, N));
    end
end

%--------------------------------------------------------------------------
end