function inc = adj2inc(adj, directed)
%ADJ2INC Convert adjacency matrix to arc-node incidence matrix.
%   inc = ADJ2INC(adj, directed) coverts the adjacency matrix of a graph to
%   its incidence matrix. The directionality of the graph is defined the 
%   value of parameter 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. The incidence matrix of a graph gives the (0,1)-matrix which has 
%      a row for each vertex and column for each edge, and (v,e)=1 iff 
%      vertex v is incident upon edge e (Skiena 1990, p. 135).
%
%   Example:
%
%   returns:
%
%   Ref:
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJL2ADJ, ADJL2EDGEL, ADJL2INC, 
%             EDGEL2ADJ, EDGEL2ADJL, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, 
%             INC2ADJL, INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

[m, N] = size(adj);
assert(m == N, 'Squared adjacency matrix is required.');

E = sum(adj(:));
if not(directed)
    E = E / 2;
end

inc = sparse(N, E);

error('Not implemented.');

%--------------------------------------------------------------------------
end