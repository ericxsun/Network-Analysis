function D = diameter(G, directed, mode)
%DIAMETER Calculate the diameter of a graph.
%   D = DIAMETER(adj, directed, 'adj') returns the diameter of a given
%   graph described by the adjacency matrix. The directionality of the
%   graph is defined by the value of 'directed'.
%
%   D = DIAMETER(edgeL, directed, 'edgeL') returns the diameter of a given
%   graph described by the edge list. The directionality of the graph is
%   defined by the value of 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. The weight of the edges will be ignored.
%   
%   Example:
%
%   Ref:
%
%   See also: 
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/11/06 17:29$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

if strcmp('adj', mode) == 1
    assert(size(G, 1) == size(G, 2), 'Squared adj is required.');
    
    error('Not implemented');    
elseif strcmp('edgeL', mode) == 1
    error('Not implemented');
end

%--------------------------------------------------------------------------
end