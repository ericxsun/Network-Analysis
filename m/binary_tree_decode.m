function epr = binary_tree_decode(nodes, nodes_index, root, root_index)
%BINARY_TREE_DECODE Traversal binary tree defined by nodes and nodes_index
%to generate the expression.
%   epr = BINARY_TREE_DECODE(nodes, nodes_index, root, root_index) inorder
%   traverse the binary tree from the start node(i.e. root) and its index
%   in nodes(i.e. root_index). For saving memory, the tree stored in memory
%   is sparse, i.e., only records the valid nodes and their index in full
%   tree.
%
%   Algorithm:
%   Inorder traverse.
%
%   Note:
%   1. nodes_index(i) records the nodes(i) ordered in the full binary tree.
%
%   Example:
%       nodes       = {'+', 'x31', '-', '/', 'x21', 'x11', 'log', 'x41'};
%       nodes_index = [1, 2, 3, 6, 7, 12, 13, 26];
%       root        = nodes(1);
%       root_index  = root_index(1);
%
%       BINARY_TREE_DECODE(nodes, nodes_index, root, root_index)
%   returns:
%       (x31)+(((x11)/(log(x41)))-(x21))
%
%   Ref:
%
%   See also: binary_tree_encode, binary_tree_generate, binary_tree_plot
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/13 09:30:00$
%

%--------------------------------------------------------------------------

%the index of children of root in nodes_index, not in the full tree
%sequence.
left  = find(nodes_index == root_index*2);
right = find(nodes_index == root_index*2+1);   

if ~isempty(left)
    epr_left = decode_binary_tree(nodes, nodes_index, nodes(left), ...
                                  root_index*2);
end

epr_mid  = root;

if ~isempty(right)
    epr_right= decode_binary_tree(nodes, nodes_index, nodes(right), ...
                                  root_index*2+1);
end

if isempty(left) && isempty(right)
    epr = epr_mid;
elseif ~isempty(left) && isempty(right)
    epr = strcat(epr_mid, '(', epr_left, ')');
elseif isempty(left) && ~isempty(right)
    epr = strcat(epr_mid, '(', epr_right, ')');
else
    epr = strcat('(', epr_left, ')', epr_mid, '(', epr_right, ')');
end

%--------------------------------------------------------------------------
end