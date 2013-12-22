function edgeL = model_NW(p, K, N)
%MODEL_NW Generate an undirected connected small-world graph according to the 
%Newman-Watts model(short average path length and high clustering 
%coefficient).
%   edgeL = MODEL_NW(p, mk, N) returns a small-world graph.
%
%   Algorithm:
%   Step 1. Start with a ring lattice with N nodes in which every node is 
%           connected to its first K neighbors(K/2, on either side). In 
%           order to have a sparse but connected network at all times, 
%           consider N>>K>>ln(N)>>1.
%   Step 2. Randomly add edges with probability p such that self-connections and
%           duplicate edges are excluded.
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst], where 'src', 'dst'
%      stand for nodes index at the ends of an edge. The node index starts 
%      at zero.
%  
%   Example:
%
%   Ref:
%   1. Newman Watts...
%
%   See also: MODEL_BA_GROWING, MODEL_BA_STATIC, MODEL_ER, 
%             MODEL_REGULAR1DLATTICE_PBC, MODEL_REGULAR2DLATTICE_PBC, MODEL_STAR
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/11/06 17:29$
%

%--------------------------------------------------------------------------

assert(0 <= p && p <= 1, '0 <= p <= 1 is required.');
assert(N > 0, 'N > 0 is required.');

msg = sprintf('0 < K < %d and K = 2m is required.', N);
assert(0 < K && K < N && mod(K, 2) == 0, msg);

%contruct a regular ring lattic
K = K / 2;
old_adjL = cell(N, 1);
    
nodes = 0 : N-1;
for i = 1 : N
    id = nodes(i);
    right = mod((id+1 :  1 : id+K), N);
    left  = mod((id-1 : -1 : id-K), N);

    old_adjL{i} = unique([right, left]);
end

%adding
error('Not Implemented');

%--------------------------------------------------------------------------
end