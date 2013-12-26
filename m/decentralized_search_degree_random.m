function T = decentralized_search_degree_random(edgeL, adjL, degree, ...
            directed, src, dst)
%DECENTRALIZED_SEARCH_DEGREE_RANDOM To compute the delivery time.
%   T = DECENTRALIZED_SEARCH_DEGREE_RANDOM(edgeL, adjL, degree, directed, src, 
%   dst) returns the delivery time of the message forward from src to dst on the 
%   unweighted graph defined by the adjacency list. If there is a path between 
%   src and dst, T will be less than Inf, otherwise, it will be Inf.
%
%   Algorithm:
%   A greedy heuristic: each message holder forwards the message to its neighbor
%	with a probability which is proportional to degree. Repeat delivery will be 
%   allowed, but the probability to forward message thought the repeated edge 
%   will decrease.
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst], where 'src', 'dst' stand 
%      for nodes index at the ends of an edge respectively. The node index 
%      starts at zero.
%   2. The node in the adjacency list starts at zero, i.e., adjL{i} represents 
%	   the neighbors of node i-1, i ranges from 1 to N, where N is the number of
%	   nodes.
%	3. degree should contain one column that represents the node degrees. For
%	   example: degree(i) represents the degree of node i-1.
%   4. This algorithm could be unstable, one should run it for several times.
%
%   Example:
%
%   Ref:
%
%   See also: DECENTRALIZED_SEARCH_1D, DECENTRALIZED_SEARCH_2D
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/12/20 09:00$
%

%-------------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'Err: The edgeL must contain 2 columns at least.');

N = size(adjL, 1);
assert(N == size(degree, 1), 'Err: size is not equal.');

assert(0 <= src && src < N, sprintf('Err: src out of range [0, %d]', N-1));
assert(0 <= dst && dst < N, sprintf('Err: dst out of range [0, %d]', N-1));

edgeL = edgeL(:, 1:2);
[~, edgeL] = iscontinuous(edgeL, directed);
if not(directed)
    edgeL = unique([edgeL; edgeL(:,2), edgeL(:,1)], 'rows');
end
edgeL(:, 3) = 0;    %record the times of message goes through this edge.

maxT = N^2; %N-1
T    = 0;

had_message_nodes = src;
while 1
    if T > maxT
        T = inf;
        break;
    end

    if src == dst
        break;
    end

    T = T + 1;

    %forward the message
    Nsrc = adjL{src+1};

    if ismember(dst, Nsrc)
    	src = dst;
    	continue;
    end
    
    if length(Nsrc) == 1
        next_src = Nsrc;
    else
        T_Nsrc = edgeL(edgeL(:,1)==src & ismember(edgeL(:,2),Nsrc), 3);
        beta   = exp(-T_Nsrc);

        P_deg = degree(Nsrc+1) ./ sum(degree(Nsrc+1));      %degree prior
        P_rnd = rand(size(P_deg));                      %random walk

        P = beta .* P_deg + (1-beta) .* P_rnd;

        next_src = randsample(Nsrc, 1, true, P);
    end
    
    idx = (edgeL(:,1) == src) & (edgeL(:,2) == next_src);
    edgeL(idx, 3) = edgeL(idx, 3) + 1;
    
    src = next_src;
    had_message_nodes = unique([had_message_nodes; src]);
end

%-------------------------------------------------------------------------------
end