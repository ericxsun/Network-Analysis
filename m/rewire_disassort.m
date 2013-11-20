function edgeL = rewire_disassort(edgeL, k, components_func, p)
%REWIRE_DISASSORT Make the degree of connected nodes more dissimilar by 
%rewiring the edge while preserving he degree sequence and connectivity.
%   edgeL = REWIRE_DISASSORT(edgeL, k, components_func, p) returns the much
%   disassortative graph.
%
%   Algorithm:
%   Iteratively rewire the randomly chosen two edges with probability p, 
%   subjects to that: node with higher degree should be linked to the node
%   with lower degree, in k steps.
%
%   Note: 
%   1. Only for unweighted and undirected graph.
%   2. components_func is used to check the connectivity of the graph.
%
%   Example:
%
%   Ref:
%
%   See also: REWIRE_ASSORT, REWIRE_RAND, REWIRE_SA
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

if nargin == 3
    p = 1;
end

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');
assert(k > 0, 'k > 0 is required.');
assert(0 <= p && p <= 1, '0 <= p <= 1 is required.');

[~, edgeL] = iscontinuous(edgeL, false);
E = size(edgeL, 1);
deg = degrees(edgeL, false, 'edgeL');

rew = 0;

percent10 = 1;
fprintf('Rewiring: 0%%');
while rew < k
    rew = rew + 1;
    
    if rew == round(k * percent10 / 10)
        fprintf('==>%2d%%', percent10 * 10);
        percent10 = percent10 + 1;
    end
    
    %1. choose two edges at random
    id_s    = randperm(E, 2);
    edges_s = edgeL(id_s, :);
    nodes_s = unique(edges_s(:));

    if length(nodes_s) ~= 4
        continue;
    end

    %2. order the four nodes with respect to their degrees
    deg_s = deg(ismember(deg(:,1), nodes_s), :);
    deg_s = sortrows(deg_s, 2);
    
    if length(unique(deg_s(:, 2))) == 1
        continue;
    end
    
    %3. rewire & check
    if rand() > p
        continue;
    end

    id4 = deg_s(4, 1);
    id3 = deg_s(3, 1);
    id2 = deg_s(2, 1);
    id1 = deg_s(1, 1);
    exist41 = sum(edgeL(:, 1) == id4 & edgeL(:, 2) == id1);
    exist14 = sum(edgeL(:, 1) == id1 & edgeL(:, 2) == id4);
    exist23 = sum(edgeL(:, 1) == id2 & edgeL(:, 2) == id3);
    exist32 = sum(edgeL(:, 1) == id3 & edgeL(:, 2) == id2);
    
    if(exist41 + exist14 + exist23 + exist32 ~= 0)
        continue;
    end
    
    %4. new edges
    edges_n_1 = [id4, id1];
    edges_n_2 = [id3, id2];
    
    edgeL(id_s, :) = [edges_n_1; edges_n_2];  

    %4. check connectivity
    C = isconnected(edgeL, 'edgeL', components_func);

    %5. discard
    if not(C)
        edgeL(id_s, :) = edges_s;
        continue;
    end
end
fprintf('\n');

[~, edgeL] = iscontinuous(edgeL, false);

%--------------------------------------------------------------------------
end