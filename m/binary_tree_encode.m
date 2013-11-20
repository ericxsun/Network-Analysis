function [nodes, nodes_index] = binary_tree_encode(epr)
%BINARY_TREE_ENCODE Generate a binary tree from the expression.
%   [nodes, nodes_index] = BINARY_TREE_ENCODE(epr) generates a binary tree
%   from the expression.
%
%   Algorithm:
%   Inorder traverse.
%
%   Note:
%   1. nodes_index(i) records the nodes(i) ordered in the full binary tree.
%
%   Example:
%       epr = (x31)+(((x11)/(log(x41)))-(x21))
%
%       [nodes, nodes_index] = BINARY_TREE_ENCODE(epr)
%   returns:
%       nodes       = {'+', 'x31', '-', '/', 'x21', 'x11', 'log', 'x41'};
%       nodes_index = [1, 2, 3, 6, 7, 12, 13, 26];
%
%   Ref:
%
%   See also: BINARY_TREE_DECODE, BINARY_TREE_GENERATE, BINARY_TREE_PLOT
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/13 09:30:00$
%

%--------------------------------------------------------------------------

error('Not Implemented.');

%--------------------------------------------------------------------------
end