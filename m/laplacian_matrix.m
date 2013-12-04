function L = laplacian_matrix(adj)
%LAPLACIAN_MATRIX Calculate the laplacian matrix of a graph.
%   L = LAPLACIAN_MATRIX(adj) returns the laplacian matrix of the given
%   graph described by the adjacency matrix.
%
%   Algorithm:
%
%   Note:
%
%   Example:
%
%   Ref:
%   http://en.wikipedia.org/wiki/Laplacian_matrix
%
%   See also: 

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/10/06 17:06 2012$
%   

%--------------------------------------------------------------------------

assert(size(adj, 1) == size(adj, 2), 'Squared adj is required.');

[~, adj] = issimple(adj, false, 'adj');

L = diag(sum(adj)) - adj;

%--------------------------------------------------------------------------
end