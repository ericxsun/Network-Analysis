function adj = edgeL2adj(edgeL, directed)
%EDGEL2ADJ Convert the edge list to the adjacency matrix.
%   adj = EDGEL2ADJ(edgeL, directed) converts the edge list of a graph to
%   its adjacency matrix. The directionality of the given graph is defined
%   by the value of 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   2. The adjacency matrix will be in sparse format.
%
%   Example:
%       edgeL = [0 1; 0 3; 0 4; 1 2; 1 3; 2 4];
%       directed = false;
%
%       EDGEL2ADJ(edgeL, directed)
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
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC, 
%             EDGEL2ADJL, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, INC2ADJL, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

if size(edgeL, 2) == 2
    edgeL(:, 3) = 1;
end

[~, edgeL] = iscontinuous(edgeL, directed);

id_min = min(min(edgeL(:, 1:2)));
if id_min == 0
    edgeL(:, 1:2) = edgeL(:, 1:2) + 1;
end

N = max(max(edgeL(:, 1:2)));

adj = sparse(N, N);

for i = 1 : size(edgeL, 1)
    ii = edgeL(i, 1);
    ij = edgeL(i, 2);
    iv = edgeL(i, 3);
    
    adj = sparse(adj + sparse(ii, ij, iv, N, N));
end

if not(directed)
    adj = sparse(triu(adj) + triu(adj)');
end

%--------------------------------------------------------------------------
end