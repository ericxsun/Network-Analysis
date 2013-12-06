function adjL = model_Regular1Dlattice_pbc(N, pdist)
%MODEL_REGULAR1DLATTICE_PBC Generate an undirected connected 1-D lattice 
%with the Periodic Boundary Conditions.
%   adjL = MODEL_REGULAR1DLATTICE_PBC(N, pdist) returns the ajdacency list
%   of a 1-D lattice with N nodes and the neighborhood of each node 
%   contains all the nodes within pdist lattice step.
%
%   Algorithm:
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N 
%      is the number of nodes.
%   
%   Example:
%
%   Ref:
%
%   See also: MODEL_BA_GROWING, MODEL_BA_STATIC, MODEL_ER, 
%             MODEL_REGULAR2DLATTICE_PBC, MODEL_WS, MODEL_STAR
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/11/06 17:29$
%

%--------------------------------------------------------------------------

assert(N > 0, 'N > 0 is required.');
msg = sprintf('0 < pdist < %d', floor(N/2));
assert(0 < pdist && pdist < floor(N/2), msg);

adjL = cell(N, 1);
nodes= 0 : N-1;

for i = 1 : N
    id = nodes(i);
    
    right = mod((id+1 :  1 : id+pdist), N);
    left  = mod((id-1 : -1 : id-pdist), N);
    
    adjL{i} = unique([right, left]);
end

%--------------------------------------------------------------------------
end