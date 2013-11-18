function [comps, sz_comps] = components(edgeL)
%COMPONENTS Find all the connected subgraphs of a given.
%   comps = COMPONENTS(edgeL) returns all the connected sub-graphs of a
%   given graph described by the edge list.
%
%   [comps, sz_comps] = COMPONENTS(edgeL) also returns the size of each
%   component.
%
%   Algorithm:
%   From the perspective of the edges, the nodes at the ends of an edge
%   should be in same group(component). Iteratively assign the nodes at 
%   the ends of each edge to the suitable group.
%
%   Note: 
%   1. Only for undirected graph.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   3. comps: comp{i} records the i-th connected subgraph.
%
%   Example:
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/07/23 09:30$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

[~, edgeL] = iscontinuous(edgeL, false);
edgeL = edgeL(:, 1:2);

E = size(edgeL, 1);

%index of nodes start at 0
nodes   = unique(edgeL(:));
N = length(nodes);

idx = zeros(N, 1);	%index of group of each node 
grp = cell(N, 1);   %group, grp{i}  records the nodes in same tree
szg = zeros(N, 1);	%size of each group

for i = 1 : N
	idx(i) = i;
	grp{i} = i-1;
end

for i = 1 : E
	ii = edgeL(i, 1);
	ij = edgeL(i, 2);

	idx_ii = idx(ii + 1);
	idx_ij = idx(ij + 1);

	if idx_ii == idx_ij
		continue;
	end

	grp{idx_ii} = [grp{idx_ii}, grp{idx_ij}];
	idx(grp{idx_ij}+1) = idx_ii;
	grp{idx_ij} = [];

	szg(idx_ii) = length(grp{idx_ii});
	szg(idx_ij) = length(grp{idx_ij});
end

gt0   = find(szg > 0);
n_gt0 = length(gt0);

comps    = cell(n_gt0, 1);
sz_comps = zeros(n_gt0, 1);
for i = 1 : n_gt0
	nodes = grp{gt0(i)};
	comps{i} = edgeL(ismember(edgeL(:, 1), nodes) | ...
                     ismember(edgeL(:, 2), nodes), :);
    sz_comps(i) = length(comps{i});
end

%--------------------------------------------------------------------------
end