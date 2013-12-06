function edgeL = model_STAR(N)
%MODEL_STAR Generate an undirected star-graph 
%   edgeL = MODEL_STAR(N) generates an undirected star-like graph.
%
%   Algorithm:
%   Every other nodes connect to the center node.
%
%   Note:
%   1. N > 1.
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
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

assert(N > 1,  'N > 1 is required.');

edgeL = [zeros(N-1, 1), (1:N-1)'];
edgeL = sortrows(edgeL);

%--------------------------------------------------------------------------
end