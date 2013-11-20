function edgeL = adjL2edgeL(adjL, directed)
%ADJL2EDGEL Convert the adjacency list to the edge list
%   edgeL = ADJL2EDGEL(adjL, directed) coverts the adjacency list of a
%   graph to its edge list.
%
%   Algorithm:
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N
%      is the number of nodes.
%   2. Each line in edgeL is expressed as [src dst], where 'src', and 'dst'
%      stand for nodes index at the ends of an edge. The node index starts
%      at zero.
%   3. Self-loops and multiple edges will be ignored.
%
%   Example:
%       adjL = {[1 3 4]; [0 2 3]; [1 4]; [0 1]; [0 2]};
%       direction = false;
%
%       ADJL2EDGEL(adjL, direction)
%   returns:
%       edgeL = [0 1; 0 3; 0 4; 1 2; 1 3; 2 4]
%
%   Ref:
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2INC, EDGEL2ADJ, 
%             EDGEL2ADJL, EDGEL2INC, EDGEL2PAJEK, INC2ADJ, INC2ADJL, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

edgeL = [];

for i = 1 : length(adjL)
    for j = 1 : length(adjL{i})
        edgeL = [edgeL; i-1, adjL{i}(j)];
    end
end

[~, edgeL] = issimple(edgeL, directed, 'edgeL');

%--------------------------------------------------------------------------
end