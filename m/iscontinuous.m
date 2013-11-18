function [C, edgeL] = iscontinuous(edgeL, directed)
%ISCONTINUOUS Check whether the id of nodes is continuous and the start 
%point is 0 or not. 
%   C = ISCONTINUOUS(edgeL, directed) checks whether the id of nodes in a 
%   given graph described by its edge list is continuous or not. The 
%   directionality of the given is defined by the value of 'directed'.
%
%   [C, edgeL] = ISCONTINUOUS(edgeL, directed) also returns the
%   continuation based graph.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. 
%
%   Example:
%       edgeL = [1 2; 1 7; 1 5; 2 3; 2 4; 3 5];
%       directed = false;
%
%      	ISCONTINUOUS(edgeL, directed)
%   returns:
%       C = 0
%       edgeL = [0 1; 0 4; 0 5; 1 2; 1 3; 2 4]
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/06/07 10:06$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

C = true;

[~, edgeL] = issimple(edgeL, directed, 'edgeL');

id_min = min(min(edgeL(:, 1:2)));
if id_min ~= 0
    edgeL(:, 1:2) = edgeL(:, 1:2) - id_min;
end

nodes = edgeL(:, 1:2);
nodes = sort(unique(nodes(:)));

N = length(nodes);

if sum(diff(nodes)) ~= N-1
    k = 1;
    fprintf('Re-labeling: 0%%');
    for i = 2 : N
        if i == N * k / 10
            fprintf('==>%2d%%', k*10);
            k = k + 1;
        end
    
        last_id = nodes(i-1);
        curr_id = nodes(i);
        
        if curr_id ~= last_id + 1
            nodes(i) = last_id + 1;
            
            C = false;
            
            edgeL(edgeL(:, 1) == curr_id, 1) = nodes(i);
            edgeL(edgeL(:, 2) == curr_id, 2) = nodes(i);
        end
    end
    
    fprintf('\n')
end

%--------------------------------------------------------------------------
end