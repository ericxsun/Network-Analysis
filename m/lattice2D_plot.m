function [xpoints, ypoints] = lattice2D_plot(L, adjL, local, long)
%LATTICE2D_PLOT Plot picture of a 2-D lattice. 
%   LATTICE2D_PLOT(L) / LATTICE2D_PLOT(L, {}) plots the nearest lattice.
%
%   LATTICE2D_PLOT(L, adjL) plots the lattice given by the adjacency list.
%
%   LATTICE2D_PLOT(L, adjL, localSpec, longSpec) allows optional parameters
%   localSpec, longSpec to set the local-contacts, long-range contacts color. 
%   Use '' to omit one or both.
%
%   [xpoints, ypoints] = LATTICE2D_PLOT(L, ...) also returns the coordinates of 
%   each node.
%
%   Algorithm:
%
%   Note:
%   1. If 'adjL' is empty, the nearest lattice will be shown.
%
%   Example:
%
%   Ref:
%
%   See also: LATTICE1D_PLOT
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/10/10 09:00$
%

%--------------------------------------------------------------------------

msg = 'Warning: only show a lattice which size is less than 50';
assert(L <= 50, msg);

if nargin < 3 || isempty(local)
    local = 'b';
    long  = 'r';
end
if nargin < 4 || isempty(long)
    long = 'r';
end

% +----->y
% |
% |
% v
% x
[xpoints, ypoints] = meshgrid(1:L, 1:L);
xlines = [xpoints([1:L, 1:L+1:L^2]);     xpoints([L^2:-1:L^2-L+1, 1:L+1:L^2])];
ylines = [ypoints([1:L, 1:L  :L^2-L+1]); ypoints([1:L,            L:L:L^2])];

hfigure = figure();
haxes   = axes('parent', hfigure, 'xlim', [1, L], 'ylim', [1, L], ...
               'xcolor', 'k', 'ycolor', 'k', 'linewidth', 2);
set(gca, 'ydir', 'reverse');
set(gca, 'xaxislocation', 'top');
axis equal;
axis off;
hold on;

%local contacts
plot(xlines, ylines, 'c');

%long-range contacts
if nargin > 1 && ~isempty(find(not(cellfun(@isempty, adjL)), 1))
    N = size(adjL, 1);
    
    assert(L == sqrt(N), 'Err: Lattice size.');
    
    for u = 0 : N-1
        Nu = adjL{u+1};
        
        ux = mod(u, L) + 1;
        uy = floor(u/L)+ 1;
        
        N1xy = [[ux+1 uy]; [ux-1 uy]; [ux uy+1]; [ux uy-1]];
        N1xy(N1xy(:,1) > L, 1) = N1xy(N1xy(:,1) > L, 1) - L;
        N1xy(N1xy(:,1) < 1, 1) = N1xy(N1xy(:,1) < 1, 1) + L;
        N1xy(N1xy(:,2) > L, 2) = N1xy(N1xy(:,2) > L, 2) - L;
        N1xy(N1xy(:,2) < 1, 2) = N1xy(N1xy(:,2) < 1, 2) + L;

        N1 = (N1xy(:,1)-1) + (N1xy(:,2)-1).*L;
        
        Nu = setdiff(Nu(:), N1(:));
        Nu = Nu(:);
        if isempty(Nu)
            continue;
        end
                
        xx = [repmat(xpoints(u+1), size(Nu)), xpoints(Nu+1)];
        yy = [repmat(ypoints(u+1), size(Nu)), ypoints(Nu+1)];
        
        line(xx, yy, 'color', long);
%         quiver(xx(:,1), yy(:,1), xx(:,2)-xx(:,1), yy(:,2)-yy(:,1), 'color', long);
    end
end

nodes = 0: L*L-1;
nodes = reshape(strtrim(cellstr(num2str(nodes(:)))), L, L);

%points
plot(haxes, xpoints, ypoints, 'o', 'markersize', 20, 'MarkerFaceColor', ...
     [0.96 0.96 0.86], 'color', local);
text(xpoints(:), ypoints(:), nodes(:), 'parent', haxes, ...
     'horizontalalignment', 'center');
hold off;

%--------------------------------------------------------------------------
end
