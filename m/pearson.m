function rho = pearson(X, Y)
%PEARSON Calculate the pearson correlation coefficient between two random
%variables.
%   rho = PEARSON(X, Y) returns the pearson correlation coefficient between
%   X and Y.
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
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

X = X(:);
Y = Y(:);

assert(length(X) == length(Y), 'DIM(X) == DIM(Y) is required.');

N = length(X);

numerator = sum(X.*Y) - sum(X)*sum(Y)/N;
denomiator= sqrt((sum(X.^2) - sum(X)^2/N)*(sum(Y.^2) - sum(Y)^2/N));

rho = numerator / denomiator;

%--------------------------------------------------------------------------
end