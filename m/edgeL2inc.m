function inc = edgeL2inc(edgeL, directed)
%EDGEL2INC Convert edge list to arc-node incidence matrix.
%   inc = EDGEL2INC(adjL, directed) coverts the adjacency list of a graph 
%   to its incidence matrix. The directionality of the graph is defined the 
%   value of parameter 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   2. The incidence matrix of a graph gives the (0,1)-matrix which has 
%      a row for each vertex and column for each edge, and (v,e)=1 iff 
%      vertex v is incident upon edge e (Skiena 1990, p. 135).
%
%   Example:
%
%   returns:
%
%   Ref:
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC, 
%             EDGEL2ADJ, EDGEL2ADJL, EDGEL2PAJEK, INC2ADJ, INC2ADJL, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

[~, edgeL] = iscontinuous(edgeL, directed);

id_min = min(min(edgeL(:, 1:2)));
if id_min == 0
    edgeL(:, 1:2) = edgeL(:, 1:2) + 1;
end

N = max(max(edgeL(:, 1:2)));
E = size(edgeL, 1);

inc = sparse(N, E);

error('Not implemented.');

%--------------------------------------------------------------------------
end