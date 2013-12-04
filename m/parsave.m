function parsave(filename, variables)
%PARSAVE Save file.
%   PARSAVE(filename, variables) stores the specified variables. 
%
%   Algorithm:
%
%   Note:
%   1. Same behavior as MATLAB built-in function 'save'.
%   2. Making 'save' as a seperate function is to avoid violating the 
%      transparency in PARFOOR loop.
%
%   Example:
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/12/20 09:00$
%

%-------------------------------------------------------------------------------

save(filename, 'variables');

%-------------------------------------------------------------------------------
end