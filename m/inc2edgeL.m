function [edgeL, directed] = inc2edgeL(inc)
%INC2EDGEL Convert arc-node incidence matrix to the edge list.
%   edgeL = INC2EDGEL(inc) coverts the incidence matrix of a graph to its
%   edge list.
%
%   [edgeL, directed] = INC2EDGEL(inc) also returns the directionality of 
%   the graph defined by its incidence matrix 'inc'.
%
%   Algorithm:
%
%   Note:
%   1. The incidence matrix of a graph gives the (0,1)-matrix which has 
%      a row for each vertex and column for each edge, and (v,e)=1 iff 
%      vertex v is incident upon edge e (Skiena 1990, p. 135).
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
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

edgeL = [];

directed = false;

error('Not implemented.');

%--------------------------------------------------------------------------
end