function edgeL = rewire_rand(edgeL, k, components_func, p)
%REWIRE_RAND Randomly rewiring while preserving the degree sequence and 
%connectivity.
%   edgeL = REWIRE_RAND(edgeL, k, components_func, p) returns the randomly
%   rewired graph.
%
%   Algorithm:
%   Iteratively randomly rewire the randomly chosen two edges with 
%   probability p, in k steps.
%
%   Note: 
%   1. Only for unweighted and undirected graph.
%   2. components_func is used to check the connectivity of the graph.
%
%   Example:
%
%   Ref:
%
%   See also: REWIRE_ASSORT, REWIRE_DISASSORT, REWIRE_SA
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/11/19 15:25$
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

    %2. rewire & check
    if rand() > p
        continue;
    end

    id1 = edges_s(1, 1);
    id2 = edges_s(1, 2);
    id3 = edges_s(2, randi(2));
    id4 = setdiff(edges_s(2, :), id3);

    exist13 = sum(edgeL(:, 1) == id1 & edgeL(:, 2) == id3);
    exist31 = sum(edgeL(:, 1) == id3 & edgeL(:, 2) == id1);
    exist24 = sum(edgeL(:, 1) == id2 & edgeL(:, 2) == id4);
    exist42 = sum(edgeL(:, 1) == id4 & edgeL(:, 2) == id2);

    if (exist13 + exist31 + exist24 + exist42) ~= 0
        continue;
    end

    %3. new edges
    edges_n_1 = [id1, id3];
    edges_n_2 = [id2, id4];

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