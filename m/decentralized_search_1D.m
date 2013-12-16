function T = decentralized_search_1D(L, adjL, src, dst, pbc)
%DECENTRALIZED_SEARCH_1D To compute the delivery time on 1-D lattice.
%   T = DECENTRALIZED_SEARCH_1D(L, adjL, src, dst, pbc) returns the delivery 
%   time of the message forward from src to dst on the 1D lattice defined by the
%   adjacency list. If there is a path between src and dst, T will be less than 
%   Inf, otherwise, it will be Inf.
%
%   Algorithm:
%   A greedy heuristic: each message holder forwards the message across a
%   connection that brings it as close as possible to the target in lattice
%   distance.
%
%   Note:
%   1. pbc: boundary conditions. true for periodic boundary conditions.
%   2. The node in the adjacency list starts at zero, i.e., adjL{i} represents 
%      the neighbors of node i-1, i ranges from 1 to N, where N is the number 
%      of nodes.
%
%   Example:
%
%   Ref:
%   Kleinberg J M. Navigation in a small world[J]. Nature, 2000, 406(6798): 
%   845-845.
%
%   See also: DECENTRALIZED_SEARCH_2D
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/11/20 09:00$
%

%-------------------------------------------------------------------------------

N = size(adjL, 1);
assert(L == N, 'Err: Lattice size.');

assert(0 <= src && src < N, sprintf('Err: src out of range [0, %d]', N-1));
assert(0 <= dst && dst < N, sprintf('Err: dst out of range [0, %d]', N-1));

maxT = L;
T    = 0;

dist_max = floor(L/2); %the maximal dist between 2 nodes in one dimension.

had_message_nodes = src;
if ~isempty(find(not(cellfun(@isempty, adjL)), 1))
    while 1
        if T > maxT
            T = inf;
            
            break;
        end
        
        if src == dst            
            break;
        end
        
        T = T + 1;
        
        %forward the message from src to its neighbor which is the nearest
        %one to dst in lattice distance.
        xdst = dst;
        
        Nsrc = adjL{src+1};
        Nsrc = setdiff(Nsrc, had_message_nodes);
        
        if isempty(Nsrc)
            continue;
        end
        
        xNsrc = Nsrc;
        
        %if periodic boundary condition, map Nsrc to the local lattice which the
        %center is dst.
        
        gtx = pbc .* (xNsrc > xdst + dist_max) + not(pbc) .* xNsrc;
        ltx = pbc .* (xNsrc < xdst - dist_max) + not(pbc) .* xNsrc;
        
        xNsrc(gtx>0) = xNsrc(gtx>0) - L;
        xNsrc(ltx>0) = xNsrc(ltx>0) + L;
                
        dist = abs(xdst - xNsrc);
        
        %choose the next src
        while 1
            if sum(isinf(dist)) == length(dist)
                T = inf;
                
                break;
            end
            
            %
            next_srcs = Nsrc(dist == min(dist));
            
            src = next_srcs(randi(length(next_srcs)));
            if ~isempty(src)
                had_message_nodes = [had_message_nodes; src];
                
                break;
            end
            
            dist(Nsrc == src) = inf;
        end
    end
end

%-------------------------------------------------------------------------------
end