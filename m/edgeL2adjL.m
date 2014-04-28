function adjL = edgeL2adjL(edgeL, directed)
%EDGEL2ADJL Convert the edge list to the adjacency list.
%   adjL = EDGEl2ADJL(edgeL, directed) coverts the edge list of a graph to
%   its adjacency list. The directionality of the given graph is defined by
%   the value of 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   2. The node in the adjacency list starts at zero, i.e., adjL{i} has two
%      column data, 1 for the neighbors of node i-1, 2 for the weight from node 
%      i-1 to its neighbors, i ranges from 1 to N, where N is the number of nodes.
%
%   Example:
%       edgeL = [0 1; 0 3; 0 4; 1 2; 1 3; 2 4];
%       directed = false;
%
%       EDGEL2ADJL(edgeL, directed)
%   returns:
%       adjL = {[1 1; 3 1; 4 1]; [0 1; 2 1; 3 1]; [1 1; 4 1]; 
%               [0 1; 1 1]; [0 1; 2 1]}
%
%   Ref:
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC,
%             EDGEL2ADJ, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, INC2ADJL, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

[~, n_edgeL] = size(edgeL);
assert(n_edgeL >= 2, 'The edgeL must contain 2 columns at least.');

if n_edgeL == 2
    edgeL(:, 3) = 1;
end

[~, edgeL] = iscontinuous(edgeL, directed); %ids in edgeL start at 0.

N    = edgeL(:, 1:2);
N    = length(unique(N(:))); 
adjL = cell(N, 1);

if not(directed)
    for e = 1 : size(edgeL, 1)
        adjL{edgeL(e, 1)+1} = [adjL{edgeL(e, 1)+1}; edgeL(e, [2,3])];
        adjL{edgeL(e, 2)+1} = [adjL{edgeL(e, 2)+1}; edgeL(e, [1,3])];
    end
else
    for e = 1 : size(edgeL, 1)
        adjL{edgeL(e, 1)+1} = [adjL{edgeL(e, 1)+1}; edgeL(e, [2,3])];
    end
end

%--------------------------------------------------------------------------
end