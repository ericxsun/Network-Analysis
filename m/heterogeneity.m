function H = heterogeneity(X)
%HETEROGENEITY Calculate the normalized heterogeneity coefficient.
%   H = HETEROGENEITY(X) returns the normalized heterogeneity coeffiient of
%   sequence X.
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

N  = length(X);
ED = mean(X);

S = zeros(1, N);

for i = 1 : N
    S(i) = sum(abs(X(i) - X(:)));
end

H = sum(S) / (2 * N^2 * ED);

%--------------------------------------------------------------------------
end
