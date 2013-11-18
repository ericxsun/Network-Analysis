function H = entropy(X)
%ENTROPY Calculate the entropy of X.
%   H = ENTROPY(X) returns the entropy of X in bits.
%
%   Algorithm:
%
%   Note:
%
%   Example:
%       x = [2, 3, 4, 5, 6, 7, 7, 8, 9, 9, 10];
%
%       ENTROPY(x)
%   returns:
%
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/09/12 16:00$
%

%--------------------------------------------------------------------------

X = double(X(:));
T = tabulate(X);
T = T(:, 3);

H = - T' * log2(T);

%--------------------------------------------------------------------------
end
