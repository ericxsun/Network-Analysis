function T = decentralized_search_weak_ties(edgeL_ties, directed, src, dst)
%DECENTRALIZED_SEARCH_LENGTH_TIES To compute the delivery time.
%   T = DECENTRALIZED_SEARCH_LENGTH_TIES(edgeL_ties, directed, src, dst) returns
%   the delivery time of the message forward from src to dst on the weighted 
%   graph defined by the edgeL_ties. If there is a path between src and dst, T 
%   will be less than Inf, otherwise, it will be Inf.
%
%   Algorithm:
%   A greedy heuristic: each message holder forwards the message across a tie 
%   with probability which is proportional to the length of ties. Repeating 
%   delivery will be avoid.
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] where 'src', 'dst' 
%      and 'weight' stand for nodes index at the ends of an edge and its weight 
%      respectively. The node index starts at zero.
%   3. This algorithm could be unstable, one should run it for several times.
%
%   Example:
%
%   Ref:
%
%   See also: DECENTRALIZED_SEARCH_1D, DECENTRALIZED_SEARCH_2D
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/12/17 09:00$
%

%-------------------------------------------------------------------------------

msg = 'The edgeL_ties must contain 2 columns at least.';
assert(size(edgeL_ties, 2) >= 2, msg);

%ids in edgeL_ties start at 0.
[~, edgeL_ties] = iscontinuous(edgeL_ties, directed); 
if size(edgeL_ties, 2) == 2
    edgeL_ties(:, 3) = 1;
end
if not(directed)
    edgeL_ties = unique([edgeL_ties; ...
                        [edgeL_ties(:,2), edgeL_ties(:,1), edgeL_ties(:,3)]], ...
                        'rows');
end

N = max(max(edgeL_ties(:, 1:2))) + 1;

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
    Nsrc_ties = edgeL_ties(edgeL_ties(:,1) == src, 2:3);
    Nsrc_ties(ismember(Nsrc_ties(:,1), had_message_nodes), :) = [];
    
    %to avoid repeating delivery
    if isempty(Nsrc_ties)
        T = inf;
        continue;
    end    
    
    if ismember(dst, Nsrc_ties(:,1))
        src = dst;
        continue;
    end

    if size(Nsrc_ties, 1) == 1
        src = Nsrc_ties(1, 1);
    else
        src = randsample(Nsrc_ties(:,1), 1, true, Nsrc_ties(:,2));
    end
    
    had_message_nodes = unique([had_message_nodes; src]);
end

%-------------------------------------------------------------------------------
end