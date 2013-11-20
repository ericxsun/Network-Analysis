function tree = binary_tree_generate(depth_max, binary_operator, ...
                                     unary_operator, variables, constants)
%BINARY_TREE_GENERATE Generate a binary tree randomly.
%   tree = BINARY_TREE_GENERATE(depth_max, binary_operator, unary_operator, 
%   variables, constants) generates a binary tree with given maximal depth, 
%   operator candidates(binary operator(e.g. +, -, *, /), unary 
%   operator(e.g. log, exp)), the variables(e.g. x1, x2) and the
%   constants(e.g. 5, c). All operators, variables and constants are in
%   cell format. E.g. binary_operator = {'+', './'}
%
%   Algorithm
%   1. Randomly choose a operator as the root of the tree.
%   2. Judge the type(binary or unary) of the root.
%   3. Randomly choose children for the root.
%   4. Repeat until the root are in variables or constants.
%
%   Note:
%   1. the two children of a node cannot both be constant.
%   2. the child of the node with only one child cannot be constant.
%   3. the leaves cannot be operators.
%   4. the format of tree:
%       depth_max        : maximal depth
%       n_nodes_max      : number of nodes in full tree
%       depth_real       : real depth
%       n_nodes_real     : number of nodes in real tree
%       nodes            : nodes in real tree(symbols)
%       nodes_idx        : index of nodes of the real tree in full tree 
%                           sequence
%       nodes_bin        : binary nodes(with two children)
%       nodes_bin_idx    : index of binary nodes
%       nodes_un         : unary nodes(with one child)b
%       nodes_un_idx     : index
%       nodes_leaves     : leaves
%       nodes_veaves_idx : index
%       n_variables      : number of variables used in the tree
%       n_constants      : number of constants used in the tree
%
%   Example:
%       depth_max       = 3;
%       binary_operator = {'+', '-', '.*', './'};
%       unary_operator  = {'exp', 'log'};
%       variables       = {'x1', 'x2', 'x3', 'x11', 'x21', 'x31'};
%       constants       = {'5', '8', '9'};
%       
%       BINARY_TREE_GENERATE(depth_max, binary_operator, unary_operator,...
%                            variables, constants)
%   returns:
%       depth_max        : 3
%       n_nodes_max      : 15
%       depth_real       : 3
%       n_nodes_real     : 5
%       nodes            : ['-', 'x11', 'exp', 'exp', 'x3']'
%       nodes_idx        : [1, 2, 3, 6, 12]'
%       nodes_bin        : '-'
%       nodes_bin_idx    : 1
%       nodes_un         : ['exp', 'exp']'
%       nodes_un_idx     : [3, 6]'
%       nodes_leaves     : ['x11', 'x3']'
%       nodes_veaves_idx : [2, 12]'
%       n_variables      : 2
%       n_constants      : 0
%
%   Ref:
%
%   See also: BINARY_TREE_DECODE, BINARY_TREE_ENCODE, BINARY_TREE_PLOT
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/10 09:30:00$
%

%--------------------------------------------------------------------------

%for convenience
depth_max = floor(depth_max);

binary_operator = binary_operator(:);
unary_operator  = unary_operator(:);
variables       = variables(:);
constants       = constants(:);

operator     = union(binary_operator, unary_operator);
op_var       = union(operator, variables);
const_var    = union(variables, constants);
op_const_var = union(operator, const_var);

operator     = operator(:);
op_var       = op_var(:);
const_var    = const_var(:);
op_const_var = op_const_var(:);

n_variables    = size(variables, 1);
n_operator     = size(operator, 1);
n_op_var       = size(op_var, 1);
n_const_var    = size(const_var, 1);
n_op_const_var = size(op_const_var, 1);

%init tree
tree.depth_max        = depth_max;
tree.n_nodes_max      = 2^(depth_max+1) - 1;
tree.depth_real       = 0;
tree.n_nodes_real     = 0;
tree.nodes            = [];
tree.nodes_idx        = [];
tree.nodes_bin        = [];
tree.nodes_bin_idx    = [];
tree.nodes_un         = [];
tree.nodes_un_idx     = [];
tree.nodes_leaves     = [];
tree.nodes_leaves_idx = [];
tree.n_variables      = 0;
tree.n_constants      = 0;

%construct
depth = 0;

chosed_idx = floor(n_operator * rand()) + 1;
chosed_idx = chosed_idx(:);
root       = operator(chosed_idx);
tree.nodes = [tree.nodes; root];

if not(isempty(tree.nodes))
    tree.nodes_idx    = [tree.nodes_idx; 1];
    tree.n_nodes_real = 1;
end

while 1
    is_bin = ismember(root, binary_operator);
    is_un  = ismember(root, unary_operator);
    
    if sum(is_bin) == 0 && sum(is_un) == 0
        tree.nodes_leaves = [tree.nodes_leaves; root];
        
        n_nodes = 0 : size(root, 1) - 1;
        n_nodes = tree.n_nodes_real + n_nodes;
        idx = tree.nodes_idx(n_nodes);
        tree.nodes_leaves_idx = [tree.nodes_leaves_idx; idx];
        
        tree.n_nodes_real = tree.n_nodes_real + size(root, 1) - 1;
        
        break;
    end
    
    n_children = zeros(size(is_bin));
    n_children(is_bin > 0, :) = 2;
    n_children(is_un  > 0, :) = 1;
    
    n_root = size(root, 1);
    for i = 1 : n_root
        cur_root     = root(1);
        cur_root_idx = tree.nodes_idx(tree.n_nodes_real);
        
        root(1) = [];
        
        tree.n_nodes_real = tree.n_nodes_real + 1;
        
        if n_children(i) == 0
            children = [];
            idx      = [];
            
            tree.nodes_leaves     = [tree.nodes_leaves; cur_root];
            tree.nodes_leaves_idx = [tree.nodes_leaves_idx; cur_root_idx];
        elseif n_children(i) == 1
            if depth < depth_max - 1
                chosed_idx = floor(n_op_var * rand()) + 1;
                children   = op_var(chosed_idx);
            else
                chosed_idx = floor(n_const_var * rand()) + 1;
                children   = const_var(chosed_idx);
            end
            
            idx = cur_root_idx * 2;
            
            tree.nodes_un     = [tree.nodes_un; cur_root];
            tree.nodes_un_idx = [tree.nodes_un_idx; cur_root_idx];  
        elseif n_children(i) == 2
            children = cell(2, 1);
            
            if depth < depth_max - 1
                chosed_idx = floor(n_op_var * rand()) + 1;
                children(1)= op_var(chosed_idx);
                
                chosed_idx = floor(n_op_const_var * rand()) + 1;
                children(2)= op_const_var(chosed_idx);
            else
                chosed_idx = floor(n_variables * rand()) + 1;
                children(1)= variables(chosed_idx);
                
                chosed_idx = floor(n_const_var * rand()) + 1;
                children(2)= const_var(chosed_idx);
            end
            
            idx = cur_root_idx * 2 + (0 : 1)';
            
            tree.nodes_bin = [tree.nodes_bin; cur_root];
            tree.nodes_bin_idx = [tree.nodes_bin_idx; cur_root_idx];
        end
        
        tree.nodes     = [tree.nodes; children];
        tree.nodes_idx = [tree.nodes_idx; idx];
        
        root = [root; children];        
    end
    
    depth = depth + 1;
end

tree.depth_real   = depth;
tree.n_nodes_real = size(tree.nodes, 1);

eq_const = ismember(tree.nodes, constants);
tree.n_constants = sum(eq_const);
tree.n_variables = size(tree.nodes_leaves, 1) - tree.n_constants;

%--------------------------------------------------------------------------
end
