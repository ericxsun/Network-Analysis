function [shlidx, shells_idx, shells] = shell_index(edgeL)
%SHELL_INDEX Find the k-shell index of each node.
%   [shlidx, shells_idx, shells] = SHELL_INDEX(edgeL) returns the shell 
%   index of each node, all index of existing shells and nodes for each
%   shell of a given graph described by the edge list.
%
%   Algorithm:
%
%   Note: 
%   1. Only for undirected graph.
%   2. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%
%   Example:
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

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.')

[~, edgeL] = iscontinuous(edgeL, false);
edgeL = edgeL(:, 1:2);

deg = degrees(edgeL, false, 'edgeL');
sdeg= sum(deg(:, 2));

shlidx = deg(:, 1);  %1-id
shlidx(:, 2) = 0;    %shell index

kidx    = 1;
visited = [];

while sdeg > 0
    lt_k = deg(deg(:, 2) < kidx, 1);
    if isempty(lt_k)
        kidx = kidx + 1;
    else
        not_visited = setdiff(lt_k, visited);
        
        shlidx(ismember(shlidx(:, 1), not_visited), 2) = kidx - 1;
        deg(ismember(deg(:, 1), not_visited), :) = [];
        
        %neighbors degree decreased
        neigh = [edgeL(ismember(edgeL(:, 1), not_visited), 2);
                 edgeL(ismember(edgeL(:, 2), not_visited), 1)];
        neigh(ismember(neigh, [not_visited; visited])) = [];
        
        if ~isempty(neigh)
            d   = sort(neigh);
            d   = diff([d; max(d) + 1]);
            cnt = diff(find([1; d]));
            
            neigh = unique(neigh);
            
            deg(ismember(deg(:, 1), neigh), 2) = ...
                deg(ismember(deg(:, 1), neigh), 2) - cnt;
        end
        
        visited = [visited; not_visited];
        sdeg = sum(deg(:, 2));
    end
end

shells_idx = unique(shlidx(:, 2));
n_shells   = size(shells_idx, 1);

shells = cell(1, n_shells);

for i = 1 : n_shells
    shells{i} = shlidx(shlidx(:, 2) >= shells_idx(i), 1);
end

%--------------------------------------------------------------------------
end