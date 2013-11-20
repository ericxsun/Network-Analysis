function [S, G] = issimple(G, directed, mode)
%ISSIMPLE Check whether there exists self-loops/multiple edges in a given
%graph.
%   S = ISSIMPLE(adj, directed, 'adj') checks whether a given graph, which 
%   is described by the adjacency matrix, is simple or not. The
%   directionality is defined by the value of 'directed'.
%   
%   [S, adj] = ISSIMPLE(adj, directed, 'adj') also returns the simplified
%   adjacency matrix.
%
%   S = ISSIMPLE(edgeL, directed, 'edgeL') checks whether a given graph, 
%   which is described by the edge list, is simple or not.
%
%   [S, edgeL]  = ISSIMPLE(edgeL, directed, 'edgeL') also returns the
%   simplified edge list.
%
%   Algorithm:
%
%   Note:
%   1. All multiple edges in adjacency matrx are supposed to be the weight.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%
%   Example:
%       edgeL = [0 0; 0 1; 0 2; 1 2; 2 0];
%
%       issimple(edgeL, false, 'edgeL')
%   returns:
%       S = false;
%       G = [0 1; 0 2; 1 2];
%
%   Ref:
%
%   See also: ISCONNECTED, ISCONTINUOUS
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 17:00$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

S = true;

if strcmp('adj', mode) == 1
    msg = 'Squared adjacency matrix is required.';
    assert(size(G, 1) == size(G, 2), msg);
    
    %self-loops
    sl = sum(diag(G));   
    
    if sl > 0
        S = false;
        
        G = G - diag(diag(G));
    end
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
            
    mE_flag = zeros(1, size(G, 2));
    
    %undirected graph
    if not(directed)
        gt_idx = G(:, 1) > G(:, 2);
        G(gt_idx, 1:2) = [G(gt_idx, 2), G(gt_idx, 1)];
    end
    
    %self-loops
    sl = sum(G(:, 1) == G(:, 2));
    if sl ~= 0
        S = false;
        
        G(G(:, 1) == G(:, 2), :) = [];
    end
    
    %multiple edges
    G  = sortrows(G);
    mE = diff(G, 1, 1);
    
    if ismember(mE_flag, mE, 'rows')
        S = false;
        
        G = unique(G, 'rows');
    end
end

%--------------------------------------------------------------------------
end