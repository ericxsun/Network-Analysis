function [x, y] = binary_tree_plot(height, remain_nodes, c, d, cl, cf1, cf2)
%BINARY_TREE_PLOT Plot picture of a tree given the height of the tree and 
%the nodes to be plotted(remain_nodes). If remain_nodes is not given or 
%empty, the full binary tree will be plotted.
%   BINARY_TREE_PLOT(height) plots the full binary tree.
%
%   BINARY_TREE_PLOT(height, remain_nodes) plots the full tree but only the
%   nodes in remain_nodes will be plotted.
%
%   BINARY_TREE_PLOT(height, remain_nodes, nodeSpec, edgeSpec, leafSpec, 
%   father1Spec, father2Spec) allows optional parameters nodeSpec, edgeSpec, leafSpec
%   father1Spec and father2Spec to set the node or edge color, marker, and 
%   linestyle. Use '' to omit one or both.
%
%   [x, y] = BINARY_TREE_PLOT(height, ...) also returns the coordinates of 
%   each node in the full binary tree.
%
%   Algorithm:
%
%   Note:
%   1. If remain_nodes is empty, the full tree will be plotted.
%   2. The root is always be plotted.
%   3. Value of c/cl/cf1/cf2 should not contain any line type(e.g. -).
%   4. Value of d should not contain any marker symbol(e.g. o).
%   5. All the value should in order: color+marker/line. E.g. for c/cl/cf1
%      /cf2: rs, for d: r-
%   6. No check in the process, please keep in mind.
%
%   Example:
%       BINARY_TREE_PLOT(3) 
%   returns a full binary tree, looks like:
%                 1
%               /   \
%              2     3
%             / \   / \
%            4   5 6   7
%
%       BINARY_TREE_PLOT(3, [2 3 4  6 7]) 
%   returns a binary tree like full except the node 5, looks like:
%                 1
%               /   \
%              2     3
%             /     / \
%            4     6   7
%
%   Ref:
%
%   See also: BINARY_TREE_DECODE, BINARY_TREE_ENCODE, BINARY_TREE_GENERATE
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/12 09:00$
%

%--------------------------------------------------------------------------

p = generate_fulltree_parent(height);
[x, y] = treelayout(p);

if nargin == 1
    %full binary tree(s)
    f = find(p ~= 0);
    pp= p(f);
else
    remain_nodes = remain_nodes(:);
    remain_nodes(remain_nodes <= 1) = [];
    remain_nodes = remain_nodes';
    
    if isempty(remain_nodes)
        f = 2 : 2^height-1;
    else
        f = remain_nodes;
    end
    pp = p(f);
end

if isempty(f)
    xx = x(1);
    yy = y(1);
else
    xx = x([1 f]);
    yy = y([1 f]);
end

XX = [x(f); x(pp); NaN(size(f))];
YY = [y(f); y(pp); NaN(size(f))];
XX = XX(:);
YY = YY(:);

if nargin < 3
    plot(XX, YY, 'r-', xx, yy, 'ro', 'markerface', 'r');
else
    [~, clen] = size(c);
    if nargin < 4        
        if clen > 1
            d = [c(1:clen-1) '-'];
        else
            d = 'r-';
        end
    end
    
    if clen == 0
        c = 'ro';
        [~, clen] = size(c);
    end
    
    [~, dclen] = size(d);
    if dclen == 0
        d = 'r-';
        [~, dclen] = size(d);
    end
    
    if clen > 0 && dclen > 0
        plot(XX, YY, d, xx, yy, c, 'markerface', c(1));
    elseif clen > 0
        plot(xx, yy, c, 'markerface', c(1));
    elseif dclen > 0
        plot(XX, YY, d, xx, yy, 'ro', 'markerface', c(1));
    else
        
    end
    
    if nargin > 4   %for leaf nodes
        PR = p(remain_nodes);   %the parents of nodes in remain_nodes
        PR(PR == 0) = [];
        PR = PR(:);
        leaf = setdiff(remain_nodes, PR);
        
        %frequency
        X   = diff([PR; max(PR)+1]);
        Xu  = PR(X ~= 0);
        cnt = diff(find([1; X]));
        father = [Xu, cnt];
        
        father1 = father(father(:, 2) == 1, 1); %with one child
        father2 = father(father(:, 2) == 2, 1); %with two children
        
        %re-plot the leaves
        ff = [1 f];
        leaf_id = ismember(ff, leaf);
        
        [~, cllen] = size(cl);
        if cllen <= 1
            cl = [cl, c(2:clen)];
        end
        
        hold on;
        plot(xx(leaf_id), yy(leaf_id), cl);
        
        %re-plot the father with one child
        ff = [1 f];
        father_id = ismember(ff, father1);
        
        [~, cf1len] = size(cf1);
        if cf1len <= 1
            cf1 = [cf1, c(2:clen)];
        end
        
        hold on;
        plot(xx(father_id), yy(father_id), cf1);
        
        %re-plot the father with two children
        ff = [1 f];
        father_id = ismember(ff, father2);
        
        [~, cf2len] = size(cf2);
        if cf2len <= 1
            cf2 = [cf2, c(2:clen)];
        end
        
        hold on;
        plot(xx(father_id), yy(father_id), cf2);        
    end
end

x = x(:);
y = y(:);

axis([0 1 0 1]);
axis off;

%--------------------------------------------------------------------------
end

function p = generate_fulltree_parent(h)
%h: the tree depth, if root of tree is placed on the 0 layer, then the
%layer number equals h-1

h = floor(h);   %avoid float
p = zeros(1, 2^h-1);

for i = 1 : h-1
    for j = 1 : 2 : 2^i
       p(2^i-1 + (j:j+1)) = floor((2^i-1 + j)/2);
    end
end

end