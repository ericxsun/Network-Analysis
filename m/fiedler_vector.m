function [fvalue, fvector] = fiedler_vector(adj)
%FIEDLER_VECTOR Calculate the second smallest eigenvalue and the 
%corresponding eigenvector of a given matrix.
%   fvalue = FIEDLER_VECTOR(adj) returns the second smallest eigenvalue.
%
%   [fvalue, fvector] = FIEDLER_VECTOR(adj) also returns the eigenvector.
%
%   Algorithm:
%
%   Note:
%
%   Example:
%
%   Ref:
%
%   See also: 

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/10/26 20:06 2012$

%--------------------------------------------------------------------------

assert(size(adj, 1) == size(adj, 2), 'Squared adj is required.');

[V, D] = eig(laplacian_matrix(adj));
[~, Y] = sort(diag(D));

fvalue  = Y(2);
fvector = V(:, Y(2));

%--------------------------------------------------------------------------
end