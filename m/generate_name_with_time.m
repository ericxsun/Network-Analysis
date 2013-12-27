function name = generate_name_with_time(prefix, suffix)
%GENERATE_NAME_WITH_TIME Generate name with respect to current time.
%   name = GENERATE_NAME_WITH_TIME(prefix, suffix) returns a string like 
%   prefix-year-month-day-hour-miniute-sec_ms+suffix.
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
%   $Date:  2012/11/18 09:00$
%

%--------------------------------------------------------------------------

if nargin == 0
    prefix = '';
    suffix = '';
elseif nargin == 1
    suffix = '';
end

t = clock();

computer_name = get_computername();
if strcmp(prefix, '') == 1
    name = strcat(computer_name, '-');
else
    name = strcat(prefix, '-', computer_name, '-');
end

name = strcat(name,                             ...
              num2str(t(1),            '%04d'), ...   %year
              num2str(t(2:3),         '-%02d'), ...   %-month-day
              num2str(t(4:5),         '-%02d'), ...   %-hour-minute
              num2str(fix(t(6)*1000), '-%05d'));      %-sec+ms

if strcmp(suffix, '') ~= 1
    name = strcat(name, suffix);
end

%--------------------------------------------------------------------------
end