function T = decentralized_search_random_walk(adjL, src, dst)
%DECENTRALIZED_SEARCH_RANDOM_WALK To compute the delivery time.
%   T = DECENTRALIZED_SEARCH_RANDOM_WALK(adjL, src, dst) returns the delivery
%	time of the message forward from src to dst on the unweighted graph defined 
%   by the adjacency list. If there is a path between src and dst, T will be 
%   less than Inf, otherwise, it will be Inf.
%
%   Algorithm:
%   A greedy heuristic: each message holder forwards the message to its randomly 
%   chose neighbor. Repeating delivery will be avoid.
%
%   Note:
%   1. The node in the adjacency list starts at zero, i.e., adjL{i} represents 
%	   the neighbors of node i-1, i ranges from 1 to N, where N is the number of
%	   nodes.
%   2. This algorithm could be unstable, one should run it for several times.
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

N = size(adjL, 1);

assert(0 <= src && src < N, sprintf('Err: src out of range [0, %d]', N-1));
assert(0 <= dst && dst < N, sprintf('Err: dst out of range [0, %d]', N-1));

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
    Nsrc = setdiff(adjL{src+1}, had_message_nodes);

    %to avoid repeating delivery
    if isempty(Nsrc)
        T = inf;
        continue;
    end

    if ismember(dst, Nsrc)
        src = dst;
        continue;
    end

    src = Nsrc(randi(length(Nsrc)));
    had_message_nodes = [had_message_nodes; src];
end

%-------------------------------------------------------------------------------
end