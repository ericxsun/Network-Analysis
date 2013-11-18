function C = cover(G, directed, mode)
%COVER Find the cover nodes. 
%   C = COVER(adj, directed, 'adj') returns the cover nodes of a given
%   graph described by the adjacency matrix. The directionality of the
%   graph is defined by the value of 'directed'.
%
%   C = COVER(edgeL, directed, 'edgeL') returns the cover nodes of a given
%   graph described by the edge list. The directionality of the graph is
%   defined by the value of 'directed'.
%
%   Algorithm:
%   Iteratively choose the node with the maximal degree.
%
%   Note:
%   1. Once nodes with same maximal degree emerged, one in such nodes will
%      be chosen at random.
%   2. For the directed graph, cover nodes will be found according to the
%      out-degree.
%   3. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   4. Node in C will be in range [0 N-1], where N is the size of the
%      graph.
%
%   Example:
%       edgeL = [0 1; 0 2; 1 2; 2 4; 3 4; 3 5; 4 5];
%
%       C = COVER(edgeL, false, 'edgeL')
%   returns:
%       C = [4; 0] or C = [2; 5] or C = [4; 1] or C = [2; 3]
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/06/13  11:03$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

C = [];

if strcmp('adj', mode) == 1
    assert(size(G, 1) == size(G, 2), 'Squared adj is required.');
    
    [~, G] = issimple(G, false, mode);
    
    error('Not implemented');
    
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
    
    [~, G] = iscontinuous(G, false);
    
    G = G(:, 1:2) + 1;
    
    deg  = degrees(G, directed, mode);
    nodes= deg(:, 1);
    deg  = deg(:, 2);
    adjL = edgeL2adjL(G, directed);
    
    while sum(deg) ~= 0
        deg_max = max(deg);
        
        candidates = find(deg == deg_max);
    
        u = candidates(randi(length(candidates)));

        deg(u) = 0;
        deg(adjL{u}+1) = 0;

        nodes(u) = 1;
        nodes(adjL{u}+1) = 0;
        
        C = [C; u];
    end
    
    C = C - 1;
    
end

%--------------------------------------------------------------------------
end