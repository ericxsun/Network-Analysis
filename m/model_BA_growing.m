function edgeL = model_BA_growing(m0, m, N)
%MODEL_BA_GROWING Generate an undirected connected scale-free graph 
%according to the Barabasi-Albert model.
%   edgeL = MODEL_BA_GROWING(m0, m, N) generates a scale-free graph based
%   on the Barabasi-Albert model. m0, m, N are the number of nodes of an
%   initial graph, add nodes each iteration, final nodes respectively.
%
%   Algorithm:
%   Each new node is connected to  existing nodes with a probability that 
%   is proportional to the number of links that the existing nodes already 
%   have.
%
%   Note:
%   1. m0 >= 2, m <= m0.
%   2. Each line in edgeL is expressed as [src dst], where 'src', and 'dst'
%      stand for nodes index at the ends of an edge. The node index starts
%      at zero.
%
%   Example:
%
%   returns:
%
%   Ref:
%   1. Albert-László Barabási & Réka Albert (October 1999). "Emergence of 
%      scaling in random networks". Science 286 (5439): 509–512.
%   
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/05/26 20:26$
%

%--------------------------------------------------------------------------

assert(m0 > 1,  'm0 > 1 is required.');
assert(m <= m0, 'm <= m0 is required.');

edgeL = [];

%init
for i = 1 : m0
    i_neighbors = i : m0 - 1;
    
    edgeL = [edgeL; repmat(i-1, length(i_neighbors), 1), i_neighbors'];
end

deltaN = N - m0;

node = m0 - 1;

%growth
percent10 = 1;
fprintf('Adding: 0%%');

while node < N-1
    
    if (node+1 - m0 + 1) == round(deltaN * percent10 / 10)
        fprintf('==>%2d%%', percent10 * 10);
        percent10 = percent10 + 1;
    end
    
    %add new node
    node = node + 1;
    
    %add m edges
    deg = degrees(edgeL, false, 'edgeL');
    
    while 1
        v = randsample(deg(:, 1), m, true, deg(:, 2));
        if length(unique(v)) == length(v)
            break;
        end
    end
    
    u = repmat(node, m, 1);
    
    %ensure edgeL(i, 1) < edgeL(i, 2)
    edgeL = [edgeL; (v<u).*v+(u<v).*u, (v>=u).*v+(u>=v).*u];
end
fprintf('\n');

edgeL = sortrows(edgeL);

%--------------------------------------------------------------------------
end