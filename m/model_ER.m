function edgeL = model_ER(p, N)
%MODEL_ER Generate an undirected connected random graph according to the 
%Erdos-Renyi model.
%   edgeL = MODEL_ER(p, N) returns an undirected connected random graph
%   using Erdos-Renyi model with rewire probability p and size N.
%
%   Algorithm:
%   All possible pairs of nodes are connected with probability p.
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst], where 'src', and 'dst'
%      stand for nodes index at the ends of an edge. The node index starts
%      at zero.
%   
%   Example:
%
%   Ref:
%   1. Erdős, Paul; A. Rényi (1960). "On the evolution of random graphs". 
%      Publications of the Mathematical Institute of the Hungarian Academy
%      of Sciences 5: 17–61.
%
%   See also: MODEL_BA_GROWING, MODEL_BA_STATIC, 
%             MODEL_REGULAR1DLATTICE_PBC, MODEL_REGULAR2DLATTICE_PBC, 
%             MODEL_WS
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/12/06 17:29$
%

%--------------------------------------------------------------------------

assert(0 <= p && p <= 1, '0 <= p <= 1 is required.');
assert(N > 0, 'N > 0 is required.');

k = 1;
while 1
    fprintf('I am trying: %d-', k);
    k = k+1;
    
    adjL = cell(N, 1);

    for i = 1 : N
        i_neighbors = (rand(1, N - i) <= p);
        i_neighbors = find(i_neighbors > 0) + i - 1;

        adjL{i} = unique([adjL{i}, i_neighbors]);

        for j = 1 : length(i_neighbors)
            adjL{i_neighbors(j)+1} = unique([adjL{i_neighbors(j)+1}, i-1]);
        end  
    end

	%connectivity check
	edgeL = adjL2edgeL(adjL, false);
        
    if isconnected(edgeL, 'edgeL', @components)
        break;
    end
    
    [~, edgeL] = issimple(edgeL, false, 'edgeL');
end
fprintf('\n');

%--------------------------------------------------------------------------
end