function [adjL, directed] = inc2adjL(inc)
%INC2ADJL Convert arc-node incidence matrix to the adjacency list.
%   adjL = INC2ADJL(inc) coverts the incidence matrix of a graph to its
%   adjacency list.
%
%   [adjL, directed] = INC2ADJL(inc) also returns the directionality of the
%   graph defined by its incidence matrix 'inc'.
%
%   Algorithm:
%
%   Note:
%   1. The incidence matrix of a graph gives the (0,1)-matrix which has 
%      a row for each vertex and column for each edge, and (v,e)=1 iff 
%      vertex v is incident upon edge e (Skiena 1990, p. 135).
%   2. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N 
%      is the number of nodes.
%
%   Example:
%
%   returns:
%
%   Ref:
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC,
%             EDGEL2ADJ, EDGEL2ADJL, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

[N, E] = size(inc);

adjL = cell(N, 1);

directed = false;

error('Not implemented.');

%--------------------------------------------------------------------------
end