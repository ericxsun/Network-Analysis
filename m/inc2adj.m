function [adj, directed] = inc2adj(inc)
%INC2ADJ Convert arc-node incidence matrix to the adjacency matrix.
%   adj = INC2ADJ(inc) coverts the incidence matrix of a graph to its
%   adjacency matrix.
%
%   [adj, directed] = INC2ADJ(inc) also returns the directionality of the
%   graph defined by its incidence matrix 'inc'.
%
%   Algorithm:
%
%   Note:
%   1. The incidence matrix of a graph gives the (0,1)-matrix which has 
%   a row for each vertex and column for each edge, and (v,e)=1 iff vertex 
%     v is incident upon edge e (Skiena 1990, p. 135).
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

[N, E] = size(inc);

adj = sparse(N, N);

directed = false;

error('Not implemented.');

%--------------------------------------------------------------------------
end