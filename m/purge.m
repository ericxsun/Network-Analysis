function C = purge(A, B)
%PURGE Remove a subset from a set, similar to setdiff but order of elements
%is preserved.
%   C = PURGE(A, B) returns the subset of A, excluding the nodes belong to
%   B.
%   
%   Algorithm:
%
%   Note:
%   1. Behavior of PURGE is similar to SETDIFF, except the order of
%   elements is preserved.
%
%   Example:
%
%   Ref:
%
%   See also: SETDIFF
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/11/06 17:29$
%

%--------------------------------------------------------------------------

C = [];
for a = 1 : numel(A)
    if isempty(find(B == A(a), 1))
        C = [C, A(a)];
    end
end

%--------------------------------------------------------------------------
end