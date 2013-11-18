function inc = adjL2inc(adjL, directed)
%ADJL2INC Convert adjacency list to arc-node incidence matrix.
%   inc = ADJL2INC(adjL, directed) coverts the adjacency list of a graph to
%   its incidence matrix. The directionality of the graph is defined the 
%   value of parameter 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N 
%      is the number of nodes.
%   2. The incidence matrix of a graph gives the (0,1)-matrix which has a 
%      row for each vertex and column for each edge, and (v,e)=1 iff vertex 
%      v is incident upon edge e (Skiena 1990, p. 135).
%
%   Example:
%
%   returns:
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

N = length(adjL);
E = length(cell2mat(adjL));

if not(directed)
    E = E / 2;
end

inc = sparse(N, E);

error('Not implemented.');

%--------------------------------------------------------------------------
end