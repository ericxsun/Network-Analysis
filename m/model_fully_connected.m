function edgeL = model_fully_connected(N, directed)
%MODEL_FULLY_CONNECTED Generate a fully connected graph.
%   edgeL = MODEL_FULLY_CONNECTED(N) generates a fully connected graph. The
%   directionality of the graph is defined by 'directed'. 
%
%   Algorithm:
%
%   Note:
%   1. N > 1.
%   2. directed: false for undirected graph, true for directed graph.
%
%   Example:
%
%   Ref:
%   
%   See also: MODEL_BA_GROWING, MODEL_BA_STATIC, MODEL_ER, 
%             MODEL_REGULAR1DLATTICE_PBC, MODEL_REGULAR2DLATTICE_PBC,
%             MODEL_WS
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/09/26 20:26$
%

%--------------------------------------------------------------------------

assert(N > 1,  'N > 1 is required.');

if nargin == 1
    directed = false;
end

edgeL = [];
for i = 0 : N-1
    src    = zeros(N-1, 1);
    src(:) = i;
    
    dst = setdiff(0:N-1, src);
    dst = dst(:);
    
    edgeL = [edgeL; src dst];
end

[~, edgeL] = issimple(edgeL, directed, 'edgeL');

%--------------------------------------------------------------------------
end