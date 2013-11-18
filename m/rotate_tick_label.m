function h = rotate_tick_label(h, tick, rotation)
%ROTATE_TICK_LABEL Rotate the tick label according to the parameters
%   h = ROTATE_TICK_LABEL(h, tick, rotation) rotates the tick label with
%   angle rotation.
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

assert(not(isempty(h)) && ishandle(h), 'Wrong figure handle.');

tick = validatestring(lower(tick), {'xtick', 'ytick'}, ...
                      mfilename('fullpath'), 'tick');

while rotation > 360
    rotation = rotation - 360;
end

while rotation < 0
    rotation = rotation + 360;
end

if strcmp(tick, 'xtick')
    a = get(h, 'xticklabel');
    set(h, 'xticklabel', []);
    b = get(h, 'xtick');
    c = get(h, 'ytick');
elseif strcmp(tick, 'ytick')
    a = get(h, 'yticklabel');
    set(h, 'ytickalbe', []);
    b = get(h, 'ytick');
    c = get(h, 'xtick');
else
    error('Only for xtick or ytick');
end

%make new tick labels
if rotation < 180
    h = text(b, repmat(c(1), [1, length(b)]), a, ...
             'horizontalalignment', 'right', 'rotation', rotation, ...
             'fontsize', 12);
else
    h = text(b, repmat(c(1), [1, length(b)]), a, ...
             'horizontalalignment', 'left', 'rotation', rotation, ...
             'fontsize', 12);
end

%--------------------------------------------------------------------------
end