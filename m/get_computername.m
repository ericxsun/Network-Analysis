function name = get_computername()
%GET_COMPUTERNAME To get the computer name or hostname.
%   name = GET_COMPUTERNAME() returns the computer name/hostname.
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
%   $Date:  2012/06/26 20:06$
%

%--------------------------------------------------------------------------

[ret, name] = system('hostname');
if ret ~= 0
    if ispc
        name = getenv('COMPUTERNAME');
    else
        name = getenv('HOSTNAME');
    end
end

name = lower(name);

%--------------------------------------------------------------------------
end