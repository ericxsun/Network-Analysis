function adjL = model_Regular2Dlattice_pbc(L, pdist)
%MODEL_REGULAR2DLATTICE_PBC Generate two-dimensional regular lattice with 
%the Periodic Boundary Conditions.
%   adjL = MODEL_REGULAR2DLATTICE_PBC(L, pdist) returns the adjacency list
%   of a 2-D lattice with LxL nodes and the neighborhood of each node
%   contains all the nodes within pdist lattice step.
%
%   Algorithm:
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i}
%      represents the neighbors of node i-1, i ranges from 1 to N, where N 
%      is the number of nodes.
%
%   Example:
%       MODEL_REGULAR2DLATTICE_PBC(3, 1)
%
%   returns:
%       adjL{1} = [1; 2; 3; 5], ...
%   it looks like:
%        | | | | |                +--->x
%       -8-6-7-8-6-               |
%        | | | | |                |
%       -2-0-1-2-0-               v
%        | | | | |                y
%       -5-3-4-5-3-
%        | | | | |
%       -8-6-7-8-6-
%        | | | | |
%       -2-0-1-2-0-
%        | | | | |
%
%   Ref:
% 
%   See also: MODEL_BA_GROWING, MODEL_BA_STATIC, MODEL_ER, 
%             MODEL_REGULAR1DLATTICE_PBC, MODEL_WS
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/10 09:30:00$
%

%--------------------------------------------------------------------------

assert(L > 0, 'L > 0 is required.');

msg = sprintf('0 < pdist <= %d is required.', L);
assert(0 < pdist && pdist <= L, msg);

N    = L*L;
adjL = cell(N, 1);

%u = 0
ux0 = mod(0, L)  + 1;
uy0 = floor(0/L) + 1;

for pd = 1 : pdist
    adjL{0+1} = [adjL{0+1}; find_d_neighbors(L, [ux0,uy0], pd)];
end
vxu0 = bsxfun(@mod, adjL{1}, L) + 1;
vyu0 = floor(adjL{1} ./ L) + 1;

if matlabpool('size') > 0
    parfor u = 1 : N-1
        ux = mod(u, L)  + 1;
        uy = floor(u/L) + 1;
        
        dx = ux - ux0;
        dy = uy - uy0;
        
        vxyu = [vxu0+dx, vyu0+dy];
        vxyu(vxyu(:, 1) > L, 1) = vxyu(vxyu(:, 1) > L, 1) - L;
        vxyu(vxyu(:, 1) < 1, 1) = vxyu(vxyu(:, 1) < 1, 1) + L;
        vxyu(vxyu(:, 2) > L, 2) = vxyu(vxyu(:, 2) > L, 2) - L;
        vxyu(vxyu(:, 2) < 1, 2) = vxyu(vxyu(:, 2) < 1, 2) + L;
        
        adjL{u+1} = unique(vxyu(:,1)-1 + (vxyu(:,2)-1).*L);
    end
else
    percent10 = 1;
    fprintf('Adding: 0%%');
      
    for u = 1 : N-1
        if u == round(percent10 * (N-1) / 10)
            fprintf('==>%2d%%', percent10 * 10);
            percent10 = percent10 + 1;
        end
        
        ux = mod(u, L)  + 1;
        uy = floor(u/L) + 1;
        
        dx = ux - ux0;
        dy = uy - uy0;
        
        vxyu = [vxu0+dx, vyu0+dy];
        vxyu(vxyu(:, 1) > L, 1) = vxyu(vxyu(:, 1) > L, 1) - L;
        vxyu(vxyu(:, 1) < 1, 1) = vxyu(vxyu(:, 1) < 1, 1) + L;
        vxyu(vxyu(:, 2) > L, 2) = vxyu(vxyu(:, 2) > L, 2) - L;
        vxyu(vxyu(:, 2) < 1, 2) = vxyu(vxyu(:, 2) < 1, 2) + L;
        
        adjL{u+1} = unique(vxyu(:,1)-1 + (vxyu(:,2)-1).*L);
    end
    
    fprintf('\n');
end

%--------------------------------------------------------------------------
end

function v = find_d_neighbors(L, u, pdist)
%find the neighbors of u with lattice distance pdist
%           x x+1
%           ||
%     2     ||
%           ||   1
% y+1 ------||
% ----------+-------- y
%          ||-------- y-1
%          ||
%     3    ||    4
%          ||
%        x-1 x
%

uv= [];

pdist_max = floor(L/2);

ux = u(1);
uy = u(2);

%quadrant 1
bx = ux + pdist_max;            %boundary
by = uy - pdist_max;

dx = (1       :  1 : pdist)';   %dx + dy = pdist
dy = (pdist-1 : -1 : 0)';

x = ux + dx;
y = uy - dy;

xy = [x, y];
xy(xy(:, 1) > bx, :) = [];
xy(xy(:, 2) < by, :) = [];

uv = [uv; xy];

%quadrant 2
bx = ux - pdist_max;            %boundary
by = uy - pdist_max;

dx = (0     :  1 : pdist-1)';   %dx + dy = pdist
dy = (pdist : -1 : 1)';

x = ux - dx;
y = uy - dy;

xy = [x, y];
xy(xy(:, 1) < bx, :) = [];
xy(xy(:, 2) < by, :) = [];

uv = [uv; xy];

%quadrant 3
bx = ux - pdist_max;
by = uy + pdist_max;

dx = (1       :  1 : pdist)';
dy = (pdist-1 : -1 : 0)';

x = ux - dx;
y = uy + dy;

xy = [x, y];
xy(xy(:, 1) < bx, :) = [];
xy(xy(:, 2) > by, :) = [];

uv = [uv; xy];

%quadrant 4
bx = ux + pdist_max;
by = uy + pdist_max;

dx = (0     :  1 : pdist-1)';
dy = (pdist : -1 : 1)';

x = ux + dx;
y = uy + dy;

xy = [x, y];
xy(xy(:, 1) > bx, :) = [];
xy(xy(:, 2) > by, :) = [];

uv = [uv; xy];

%final
uv(uv(:, 1) > L, 1) = uv(uv(:, 1) > L, 1) - L;
uv(uv(:, 1) < 1, 1) = uv(uv(:, 1) < 1, 1) + L;
uv(uv(:, 2) > L, 2) = uv(uv(:, 2) > L, 2) - L;
uv(uv(:, 2) < 1, 2) = uv(uv(:, 2) < 1, 2) + L;

v = (uv(:,1)-1) + (uv(:,2)-1).*L;
v = unique(v);

end