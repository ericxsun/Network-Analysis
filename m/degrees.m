function [degout, degin] = degrees(G, directed, mode)
%DEGREES Calculate the degree of all nodes in a graph.
%   deg = DEGREES(adj, directed, 'adj') returns the degree/out-degree of
%   all nodes in a given graph described by the adjacency matrix.
%
%   [degout, degin] = DEGREES(adj, directed, 'adj') also resturns the
%   in-degree. If the graph is undirected, the in-degree will be same as
%   the out-degree.
%
%   deg = DEGREES(edgeL, directed, 'edgeL') returns the degree/out-degree
%   of all nodes in a given graph described by the edge list.
%
%   [degout, degin] = DEGREES(edgeL, directed, 'edgeL') also resturns the
%   in-degree. If the graph is undirected, the in-degree will be same as
%   the out-degree.
%
%   Algorithm:
%
%   Note:
%   1. The format for deg/degout/degin: 
%       [node_index node_degree]
%
%   Example:
%       edgeL = [0 1; 0 3; 0 4; 1 2; 1 3; 2 4];
%       
%       degrees(edgeL, false, 'edgeL')
%   returns:
%       0     3
%       1     3
%       2     2
%       3     2
%       4     2
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

[~, G] = issimple(G, directed, mode);

if strcmp('adj', mode) == 1
    msg = 'Squared adjacency matrix is required.';
    assert(size(G, 1) == size(G, 2), msg);
    
    degin = full(sum(G, 2));
    degout= full(sum(G, 1));
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
    
    G = G(:, 1:2);
    
    degin = unique(G(:));
    degout= degin;
    
    if not(directed)
        x = G(:);
        x = sort(x);
        
        d   = diff([x; max(x)+1]);
        
        degin(ismember(degin(:, 1), x(d~=0)), 2) = diff(find([1; d]));
        degout= degin;        
    else
        %out-deg
        x = G(:, 1);
        x = sort(x);
        
        d = diff([x; max(x)+1]);
        
        degout(ismember(degout(:, 1), x(d~=0)), 2) = diff(find([1; d]));
        
        %in-deg
        x = G(:, 2);
        x = sort(x);
        
        d = diff([x; max(x)+1]);
        
        degin(ismember(degin(:, 1), x(d~=0)), 2) = diff(find([1; d]));
    end
end

%--------------------------------------------------------------------------
end