function C = isconnected(G, mode, varargin)
%ISCONNECTED Check whether a graph is connected.
%   C = ISCONNECTED(G, 'adj') returns the connectivity of the graph 
%   described by the adjacency matrix.
%   
%   C = ISCONNECTED(G, 'edgeL', components_func) returns the connectivity 
%   of the graph described by the edge list, using method 'components_func'.
%
%   Algorithm:
%   1. For adjacency matrix: Deterministic random walk.
%   2. For edge list: Please see the algorithm in compontents_func.       
%
%   Note:
%   1. Only for undirected graph.
%   2. components_func: function handle for components operation provided
%      by varargin{1}. Valid only when mode is 'edgeL'. 
%
%   Example:
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/12/08 11:13$
%

%--------------------------------------------------------------------------

msg = 'mode: ''edgeL'' or ''adj''';
assert(strcmp('edgeL', mode) == 1 || strcmp('adj', mode) == 1, msg);

C = true;

if strcmp('adj', mode) == 1
    msg = 'Squared adjacency matrix is required.';
    assert(size(G, 1) == size(G, 2), msg);
    assert(isempty(find(G~=G', 1)), 'Undirected graph is required.');
    
    G(G>1) = 1;
    
    %isolated nodes
    if not(isempty(find(sum(G) == 0, 1)))
        C = false;
        return;
    end
    
    %deterministic random walk, starting from node 1
    N = length(G);
    x = [1; zeros(N-1, 1)]; %visited nodes
    
    while true
        y = x;
        x = G * x + x;
        x = x > 0;
        
        if x == y
            break;
        end
    end
    
    if sum(x) < N
        C = false;
    end
elseif strcmp('edgeL', mode) == 1
    assert(size(G, 2) >= 2, 'The edgeL must contain 2 columns at least.');
    assert(nargin > 2, 'The components_func handle is required.');    
    
    components_func = varargin{1};
    comp = components_func(G);
    if max(size(comp)) > 1
        C = false;
    else
        C = true;
    end
end
%--------------------------------------------------------------------------
end