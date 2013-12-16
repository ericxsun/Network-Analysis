function [xpoints, ypoints] = lattice1D_plot(L, adjL, local, long)
%LATTICE1D_PLOT Plot picture of a 1-D lattice. 
%   LATTICE1D_PLOT(L) / LATTICE1D_PLOT(L, {}) plots the nearest lattice.
%
%   LATTICE1D_PLOT(L, adjL) plots the lattice given by the adjacency list.
%
%   LATTICE1D_PLOT(L, adjL, localSpec, longSpec) allows optional parameters
%   localSpec, longSpec to set the local-contacts, long-range contacts color. 
%   Use '' to omit one or both.
%
%   [xpoints, ypoints] = LATTICE1D_PLOT(L, ...) also returns the coordinates of 
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
%   See also: LATTICE2D_PLOT
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

theta = linspace(0, 2*pi, L+1);
xpoints = 100*cos(theta);
ypoints = 100*sin(theta);
xpoints = xpoints(:);
ypoints = ypoints(:);

nodes   = 0: L-1;
nodes   = strtrim(cellstr(num2str(nodes(:))));

hfigure = figure('color', 'w');
haxes   = axes('parent', hfigure, 'xlim', [-100, 100], 'ylim', [-100, 100], ...
               'xcolor', 'w', 'ycolor', 'w', 'linewidth', 2);
axis equal;
axis off;
hold on;

%local contacts
plot(haxes, xpoints, ypoints, '-', 'color', local);

%long-range contacts
if nargin > 1 && ~isempty(find(not(cellfun(@isempty, adjL)), 1))
    N = size(adjL, 1);
    
    assert(L == N, 'Err: Lattice size.');
    
    for u = 0 : N-1
        Nu = adjL{u+1};
        N1 = [u-1; u+1];
        N1(N1>=L) = N1(N1>=L) - L;
        N1(N1< 0) = N1(N1< 0) + L;
        
        Nu = setdiff(Nu, N1);
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

%points
plot(haxes, xpoints, ypoints, 'o', 'markersize', 20, 'MarkerFaceColor', ...
     [0.96 0.96 0.86], 'color', local);
text(xpoints(1:L), ypoints(1:L), nodes, 'parent', haxes, ...
     'horizontalalignment', 'center');
hold off;

%--------------------------------------------------------------------------
end
