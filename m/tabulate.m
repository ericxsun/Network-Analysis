function TABLE = tabulate(X)
%TABULATE Frequency table.
%   TABLE = TABULATE(X) takes a vector X and returns a matrix, TABLE. The
%   first column of TABLE contains the unqiue values of X. The second is
%   the number of instances of each value. The last column contains the
%   percentage of each value.
%
%   Algorithm:
%   1. First difference.
%
%   Note:
%   1. New version of the MATLAB lib.
%
%   Example:
%       x = [1, 1, 3];
%
%       TABULATE(x)
%
%   returns:
%       1 2 66.67%
%       3 1 33.33%
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$

%--------------------------------------------------------------------------

if isnumeric(X)
    assert(min(size(X)) ==1, 'Vector is required.');
    
    X   = X(:); 
    X   = X(~isnan(X)); 
    Xid = []; 
else
    [X, Xid] = grp2idx(X); 
end 

X = sort(X(:));    
m = length(X); 

X1  = diff([X; max(X) + 1]);

X_u = X(X1 ~= 0);
cnt = diff(find([1; X1]));

if isempty(Xid)
    TABLE = [X_u, cnt, cnt/m];
else
    TABLE = [Xid, num2cell([cnt, cnt/m])];
end

%--------------------------------------------------------------------------
end