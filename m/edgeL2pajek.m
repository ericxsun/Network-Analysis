function edgeL2pajek(filename, edgeL, directed, ic, c)
%EDGEL2PAJEK Write the edge list to a pajek format file.
%   EDGEL2PAJEK(filename, edgeL, directed) writes the graph defined by the
%   edge list and the directionality to a pajek format file.
%
%   EDGEL2PAJEK(filename, edgeL, directed, nodeSpec, edgeSpec) allows 
%   optional parameters nodeSpec, edgeSpec to set the node or edge color. 
%   Use '' to omit one or both.
%
%   Alogrithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%   2. Pajek file format:
%       *Vertices   n_nodes
%           node_index label ic ic_color
%       *Arcs/*Edges
%           src dst value_for_edge c c_color
%
%   Example:
%       filename = 'test.net';
%       edgeL    = [0 1; 0 2; 1 2];
%       directed = false;
%       ic = {'Red', 'Green', 'Blue'};
%       c  = {'Red', 'Green', 'Blue'};
%
%       EDGEL2PAJEK(filename, edgeL, directed, ic, c)
%   returns: (in file: 'test.net')
%       *Vertices 3
%           1 "v1" ic Red
%           2 "v2" ic Green
%           3 "v3" ic Blue
%       *Edges
%           1 2 1.000 c Red
%           1 3 1.000 c Green
%           2 3 1.000 c Blue
%
%   Ref:
%   1. pajek reference manual
%
%   See also: ADJ2ADJL, ADJ2EDGEL, ADJ2INC, ADJL2ADJ, ADJL2EDGEL, ADJL2INC, 
%             EDGEL2ADJ, EDGEL2ADJL, EDGEL2INC, INC2ADJ, INC2ADJL, 
%             INC2EDGEL
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:06$
%

%--------------------------------------------------------------------------

if exist(filename, 'file') ~= 0
    error('File: %s does exist. Please retry.', filename);
end

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');

if size(edgeL, 2) == 2
    edgeL(:, 3) = 1;
end

[~, edgeL] = iscontinuous(edgeL, directed);

id_min = min(min(edgeL(:, 1:2)));
if id_min == 0
    edgeL(:, 1:2) = edgeL(:, 1:2) + 1;
end

nodes = edgeL(:, 1:2);
nodes = unique(nodes(:));

try
    fp = fopen(filename, 'w', 'ieee-le');  %ieee-le: IEEE floating point

    %nodes
    nodes_label = cellstr(strcat('v', num2str(nodes, '%-d')));
    n_nodes     = length(nodes);
    
    fprintf(fp, '*Vertices %d\n', n_nodes);
    if nargin > 3 && ~isempty(ic)
        ic = ic(:);
        nic= size(ic, 1);
        
        if nic ~= n_nodes
            error('Size of ic(%d) ~= size(nodes, 1)(%d)', nic, n_nodes);
        end
        
        res = cat(2, num2cell(nodes), nodes_label, ic);
        res = res';

        fprintf(fp, '\t%d "%s" ic %s\n', res{:});
    else
        res = cat(2, num2cell(nodes), nodes_label);
        res = res';

        fprintf(fp, '\t%3d %s\n', res{:});  
    end

    %edges
    if not(directed)
        fprintf(fp, '*Edges\n');
    else
        fprintf(fp, '*Arcs\n');
    end

    if nargin > 4 && ~isempty(c)
        c  = c(:);
        nc = size(c, 1);
        ne = size(edgeL, 1);
        
        if nc ~= ne
            error('Size of c(%d) ~= size(edgeL, 1)(%d)', nc, ne);
        end
        
        res = cat(2, num2cell(edgeL), c);
        res = res';
        fprintf(fp, '\t%d %d %.3f c %s\n', res{:});
    else
        fprintf(fp, '\t%d %d %.3f\n', edgeL');
    end
catch ME
    disp(ME.identifier);
    fclose(fp);
    delete(filename);
end

%--------------------------------------------------------------------------
end